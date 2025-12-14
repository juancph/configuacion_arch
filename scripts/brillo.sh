#

modo=$1
ruta="/sys/class/backlight/intel_backlight"
brillo=$(cat $ruta/brightness)
brillo_maximo=$(cat $ruta/max_brightness)

step=1000

if [ $modo = "up" ]; then
    nuevoBrillo=$(($brillo+$step))
    if [ $nuevoBrillo -gt $brillo_maximo ]; then
        nuevoBrillo=$brillo_maximo 
    fi
    echo $nuevoBrillo | sudo tee $ruta/brightness

elif [ $modo = "down" ]; then
    nuevoBrillo=$(($brillo-$step))
    if [ $nuevoBrillo -lt 0 ]; then
        nuevoBrillo=100
    fi
    echo $nuevoBrillo | sudo tee $ruta/brightness

elif [ $modo = "level" ]; then
    level="$(($brillo*100/$brillo_maximo))%"
    echo $level
fi

