#!/bin/bash

function introduccio {
    usuari=$(whoami)
    nom_host=$(hostname)
    sistema_operatiu=$(uname -a | awk '{print $1, $4}')
    data=$(date +"%Y-%m-%d")
    hora=$(date +"%H:%M:%S")
    interficie=$(ip link show | grep -oP '(?<=: ).*' | awk '{print $1}')
}

function configuracioScript {
    #Primer bloc
    fabricant=$(lspci | grep 'Ethernet Controller' | awk -F ":" '{print $3}' | awk '{print $1}')
    admac=$(ip a show $1 | awk '/link/ {print $2}' | head -n 1)
    estat_interficie=$(ip a show $1 | awk '/state/{print $9} ')
    mode_interficie=$(ip link show $1 | grep 'mode' | awk '{print $11}')
    mtu=$(ip link show $1 | grep 'mode' | awk '{print $5}')
    

    #Segon bloc
    if_not_loopback=$(ip a show $1 | grep 'LOOPBACK' | wc -c)
    adrecament=$(ip a show $1 |grep 'inet' | awk '{print $7}' | head -n 1) 
    DHCP=$(ip route | grep dhcp | awk '{print $3}')
    adreca_ip=$(ip a show $1| grep 'inet ' | awk '{print $2}') 
    mascara=$(ipcalc $(ip a show $1| grep 'inet ' | awk '{print $2}') | grep Address | awk '{print$2}') 
    mascara_2=$(ipcalc $(ip a show $1| grep 'inet ' | awk '{print $2}') | grep Netmask | awk '{print$2}')
    ip_a=$(ip -o -f inet addr show $1 | awk '{print$4}')
    adreca_xarxa=$(ipcalc $ip_a | grep Address | awk '{print$2}')
    adreca_xarxa2=$(ipcalc $ip_a | grep HostMax | awk '{print$2}')
    broadcast1=$(ipcalc $ip_a | grep Broadcast | awk '{print$2}')
    broadcast2=$(ipcalc $ip_a | grep Wildcard | awk '{print$2}')
    gateway=$(ip route | grep default | awk '{print $3}')
    ping_down=$(ping -c 1 8.8.8.8 | grep "100% packet loss" | wc -c)
    DNS=$(cat /etc/resolv.conf | grep nameserver | awk '{print$2}' | head -n 1)
    mode_adre=$(cat /etc/network/interfaces | grep "iface $1" | awk '{print$4}')


    #Tercer bloc
    ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
    ip_inv2=$(echo $(dig +short myip.opendns.com @resolver1.opendns.com) | awk -F. '{printf "%s.%s.%s.%s\n", $4, $3, $2, $1}')
    ip_inv=$(echo $(dig +short myip.opendns.com @resolver1.opendns.com) | awk -F. '{printf "%s.%s.%s\n", $3, $2, $1}')
    ip_publica=${ip_inv2}.$(dig -x ${ip} | grep -A 1 "ANSWER SECTION" |sed '1d' | awk '{print$5}')
    nom_domini=$(dig -x ${ip} | grep -A 1 "ANSWER SECTION" | sed '1d' | awk '{print$5}')
    xarxa_entitat1=$(whois ${ip} | grep netname  | awk '{print$2}')
    xarxa_entitat2=$(whois ${ip} | grep route  | awk '{print$2}' | head -n 1)
    xarxa_entitat3=$(whois ${ip} | grep inetnum  | awk '{print$2$3$4}')
    entitat_propietaria=$(whois $(dig +short myip.opendns.com @resolver1.opendns.com) |grep desc | tail -n +2 | awk '{print$2}')

    #Quart bloc
    primeralinia=$(ip route | head -n 1)
    palabraiproute="$1"
    ruta_involucrada1=$(ip route | awk '/default/{print$1 " " $2 " " $3 " " $4 " " $5}')
    ruta_involucrada2=$(ip route | awk 'NR == 2 {FS="metric"; print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}')
    ruta_involucrada3=$(ip route | grep "$1")

    #Cinque bloc
    bytes_rebuts=$(cat /proc/net/dev | grep "${i}" | awk '{print $2}')
    paquets_rebuts=$(cat /proc/net/dev | grep "${i}" | awk '{print $3}')
    errors_rebuts=$(cat /proc/net/dev | grep "${i}" | awk '{print $4}')
    descartats_rebuts=$(cat /proc/net/dev | grep "${i}" | awk '{print $5}')
    perduts_rebuts=$(cat /proc/net/dev | grep "${i}" | awk '{print $6}')
    bytes_transmesos=$(cat /proc/net/dev | grep "${i}" | awk '{print $10}')
    paquets_transmesos=$(cat /proc/net/dev | grep "${i}" | awk '{print $11}')
    errors_transmesos=$(cat /proc/net/dev | grep "${i}" | awk '{print $12}')
    descartats_transmesos=$(cat /proc/net/dev | grep "${i}" | awk '{print $13}')
    perduts_transmesos=$(cat /proc/net/dev | grep "${i}" | awk '{print $14}')
        
        
    router_involucrat=$(traceroute $ip -m 5 | grep "*" | head -n 1 | awk '{print$1}')
    gateway2=$(ip route list | grep "default" | head -n 1 | awk '{print$3}')



    if [ $(iw dev | grep "Interface" | awk '{print$2}' | grep ${i_good} | wc -c) != 0 ]; then		
        Disp=$(iw dev | grep -B 1 $1 | head -n 1 | tr -d "#")
        Modes=$(iw dev | grep -A 9 $1  | grep type | awk '{print$2}')
        Poten=$(iw dev $1 info | grep "txpower" | awk '{print$2" "$3}')
        
        #BLOC 2.5
        ssid=$(iw dev $1 info | grep "ssid" | awk '{print$2$3$4$5$6}')
        canal=$(iw dev $1 info | grep "channel" | awk '{print$2" "$3")"}')
        senyal=$(iw dev $1 link | grep "signal" | awk '{print$2" "$3}')
        puntAcces=$(iw dev $1 link | grep "Connected" | awk '{print$3" "$4" "$5}')
        velWifiRecepcio=$(iw dev $1 link  | grep "rx bitrate" | awk '{print$3" "$4}')
        velWifiTransmissio=$(iw dev $1 link  | grep "tx bitrate" | awk '{print$3" "$4}')

        
    fi
}

