#!/bin/bash

function recuadroG {
    lineamax=$(wc -L a.txt | awk '{print$1}')
    start="┌"
    i=-4
    touch log_inet.log
    echo "">log_inet.log
    while [ $i -lt $lineamax ]; do
        start+="─"
        ((i++))
    done
    start+="┐"
    ends="└"
    i=-4
    while [ $i -lt $lineamax ]; do
        ends+="─"
        ((i++))
    done
    ends+="┘"
    while read b; do
        if [[ "$b" == "InsertarInicio" ]]; then
            echo $start >>log_inet.log
        else
            if [[ "$b" == "InsertarFinal" ]]; then
                echo $ends>>log_inet.log
                echo "">>log_inet.log
            else
                numspaces=$(($lineamax-${#b} + 4))
                echo "$b $(printf "%${numspaces}s")│">>log_inet.log
            fi
        fi
    done < a.txt
    rm a.txt
}