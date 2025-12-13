#!/usr/bin/env bash

while true; do
    mapfile -t desktop < <(bspc query -D --names)

    desktopActivo=$(bspc query -D -d focused --names
)
    hora=$(date +"%H:%M:%S | %d-%m-%Y")
    bateria=$(cat /sys/class/power_supply/BAT0/capacity) 
    bateria_estado=$(cat /sys/class/power_supply/BAT0/status)
    
    for i in ${!desktop[@]}; do
        d="${desktop[$i]}"
        desktop[$i]="%{A:bspc desktop -f $d:}$d%{A}"

        if [[ $d == "$desktopActivo" ]]; then
            desktop[$i]="%{F#ff0000}$d%{F-}"
        fi
    done

    echo "%{l}${desktop[*]} %{c}$hora %{r}$bateria%"
    sleep 1
done | lemonbar | sh
