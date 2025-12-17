#!/usr/bin/env bash

workSpaces(){
    readarray -t workspaces < <(i3-msg -t get_workspaces | jq -r '.[].name')
    workspaceActivo=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

    for i in "${!workspaces[@]}"; do
        elemento="${workspaces[$i]}"

        workspaces[$i]="%{A:i3-msg workspace $elemento:}$elemento%{A}"
        if [ "$elemento" = $workspaceActivo ]; then
            workspaces[$i]="%{F#00ff00}$elemento%{F-}"
        fi
    done
    
    echo "${workspaces[*]}"

}

while true; do
    #Hora y fecha -------------------------------------------------
    hora=$(date +"%H:%M:%S | %d-%m-%Y")

    #Volumen ------------------------------------------------------
    volumen=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}')


    #Memoria ----------------------------------------------------
    memoria=$(free -m | awk '/Mem:/ {print int($3*100/$2)}')


    #Bateria ------------------------------------------------------
    bateria="$(cat /sys/class/power_supply/BAT0/capacity)" 
    bateria_estado=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$bateria" -lt 20 ] && [ "$bateria_estado" = "Discharging" ]; then
        bateria="%{F#ff0000}$bateria%{F-}"

    fi


    #Wifi ------------------------------------------------------
    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep sí | cut -d: -f2)
    estadoRed=$(nmcli -t -f CONNECTIVITY general)

    if [ "${#ssid}" -gt 5 ]; then
        ssid="${ssid:0:5}..."
    fi
    
    if [ "$estadoRed" = "full" ]; then
        ssid="%{F#00ff00}$ssid%{F-}"
    elif [ "$estadoRed" = "limited" ]; then
        ssid="%{F#ff0000}$ssid%{F-}"
    elif [ "$estadoRed" = "none" ]; then
        ssid="%{F#ff0000}$estadoRed%{F-}"
    fi
    

    #Salida ----------------------------------------------------
    echo "%{l}$(workSpaces) %{c}$hora %{r}$ssid | Vol: $volumen | Mem: $memoria% | ${bateria_estado:0:4}: $bateria%"

    sleep 1
done | lemonbar | sh
