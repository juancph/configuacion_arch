#!/usr/bin/env bash

while true; do
    #Workspace -------------------------------------------------
    readarray -t workspaces < <(i3-msg -t get_workspaces | jq -r '.[].name')
    workspaceActivo=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

    hora=$(date +"%H:%M:%S | %d-%m-%Y")
    bateria=$(cat /sys/class/power_supply/BAT0/capacity) 
    bateria_estado=$(cat /sys/class/power_supply/BAT0/status)
    

    for i in ${!workspaces[@]}; do
        elemento="${workspaces[$i]}"

        workspaces[$i]="%{A:i3-msg workspace $elemento:}$elemento%{A}"
        if [ "$elemento" = $workspaceActivo ]; then
            workspaces[$i]="%{F#ff0000}$elemento%{F-}"
        fi
    done

    #Wifi ------------------------------------------------------
    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep sí | cut -d: -f2)


    #Memoria ----------------------------------------------------
    memoria=$(
        free -m | awk '/Mem:/ {
            gsub(",", ".");
            print int(($3*100) / $2)
        }'
        )


    #Salida ----------------------------------------------------
    echo "%{l}${workspaces[*]} %{c}$hora %{r}($ssid $(nmcli -t -f CONNECTIVITY general)) | $memoria% | $bateria%"
    sleep 1
done | lemonbar | sh
