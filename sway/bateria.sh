#!/bin/bash

BAT=$(upower -e | grep BAT)
LEVEL=$(upower -i $BAT | grep percentage | awk '{print $2}' | tr -d '%')
STATE=$(upower -i $BAT | grep state | awk '{print $2}')

if [ "$STATE" = "discharging" ]; then
    if [ "$LEVEL" -le 25 ] && [ "$LEVEL" -gt 5 ]; then
        notify-send -u normal "Batería baja" "Batería al $LEVEL%"
    fi

    if [ "$LEVEL" -le 5 ]; then
        notify-send -u critical "Batería CRÍTICA" "Conecta el cargador ($LEVEL%)"
    fi
fi
