#!/usr/bin/env bash

while true; do
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

    echo "%{l}${workspaces[*]} %{c}$hora %{r}$bateria%"
    sleep 1
done | lemonbar | sh
