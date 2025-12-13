#!/usr/bin/env bash

while true; do
    a=$(bspc query -D --names | tr '\n' ' ')
    hora=$(date +"%H:%M:%S | %d-%m-%Y")
    bateria=$(cat /sys/class/power_supply/BAT0/capacity) 
    bateria_estado=$(cat /sys/class/power_supply/BAT0/status)

    if [ $bateria_estado = "Discharging" ]; then
        incono_bateria=""
    fi
    echo "%{l}$a %{c}$hora %{r}$bateria% $icono_bateria"
    sleep
done | lemonbar
