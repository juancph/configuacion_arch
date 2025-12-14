while true; do
    bateria=$(cat /sys/class/power_supply/BAT0/capacity)
    estado=$(cat /sys/class/power_supply/BAT0/status)

    if [ $bateria -lt 20 ] && [ $estado = "Discharging" ]; then
        notify-send -u critical "Bajo"
    fi


    if [ $estado = "Charging" ] && [ $bateria -eq 100 ]; then
        notify-send "Bateria cargada"
    fi

    sleep 60
done
