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
    volumen=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}' | awk -F% '{print $1}')

    if [ "$volumen" -eq 0 ]; then
        icono_volumen=""
    elif [ "$volumen" -lt 40 ]; then
        icono_volumen=""
    else
        icono_volumen=""
    fi

    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
        icono_volumen="x"
    fi

    #Memoria ----------------------------------------------------
    memoria=$(free -m | awk '/Mem:/ {print int($3*100/$2)}')


    #Bateria ------------------------------------------------------
    bateria="$(cat /sys/class/power_supply/BAT0/capacity)" 
    bateria_estado=$(cat /sys/class/power_supply/BAT0/status)
    estados_bateria=(    )

    if [ "$bateria" -ge 90 ]; then
        icono_bateria="${estados_bateria[4]}"
    elif [ "$bateria" -ge 70 ]; then
        icono_bateria="${estados_bateria[3]}"
    elif [ "$bateria" -ge 40 ]; then
        icono_bateria="${estados_bateria[2]}"
    elif [ "$bateria" -ge 20 ]; then
        icono_bateria="${estados_bateria[1]}"
    else
        icono_bateria="${estados_bateria[0]}"
    fi
    

    if [ "$bateria_estado" = "Charging" ]; then
        icono_bateria=""
    elif [ "$bateria" -lt 20 ] && [ "$bateria_estado" = "Discharging" ]; then
        icono_bateria="%{F#ff0000}$icono_bateria%{F-}"
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
        echo "%{l}  $(workSpaces) %{c}$hora %{r}$ssid | $icono_volumen $volumen% |  $memoria% | $icono_bateria $bateria%  "

    sleep 1
done | lemonbar \
  -f "Symbols Nerd Font" \
  -f "monospace" | sh
