#!/bin/bash
#########################################################################################################
#				ANOTACIÓ IMPORTANT!!!!!!!!!!!!! NECESITES SER SUPERUSUARI					  #
#				S'han de tenir instal·lats els programes ipcalc i whois                  #
#				Si no es tenen instal·lades s'ha de fer:  				  #
#					- sudo apt-get install ipcalc					  #
#					- sudo apt-get install whois					  #
#	l'arxiu .txt va a parar a teva ubicació actual dins el sistema (pwd/a.txt)	  #
#########################################################################################################
##################################USAGE##################################################################
if [ $# -gt 1 ]; then
	echo "ERROR MESSAGE!"
	
	echo "Usage: ./program [-h]"
	echo "Utilitza -h per veure el manual d'ajuda"
	echo "Programa que analitza les interficies del sistema "
	echo "ANOTACIÓ IMPORTANT! NECESITES SER SUPERUSUARI"
	echo "S'han de tenir instal·lats els programes ipcalc i whois "
	echo "Si no es tenen instal·lades s'ha de fer:"
	echo "	- sudo apt-get install ipcalc"
	echo "	- sudo apt-get install whois"
	echo "l'arxiu .txt va a parar a teva ubicació actual dins el sistema (pwd/a.txt)	"
	echo "│	"
	
	echo "Realitzat per: David Martinez i Joaquim Hervàs" 
	exit 1
fi


if [ "$1" = "-h" ]; then

	echo "Benvingut al programa d'analisi de les interficies"
	echo "ANOTACIÓ IMPORTANT! NECESITES SER SUPERUSUARI"
	echo "S'han de tenir instal·lats els programes ipcalc i whois "
	echo "Si no es tenen instal·lades s'ha de fer:"
	echo "	- sudo apt-get install ipcalc"
	echo "	- sudo apt-get install whois"
	echo "l'arxiu .txt va a parar a teva ubicació actual dins el sistema (pwd/a.txt)	"
	echo "│	"
	echo "Aquest programa fa una tasca molt important. Aquí t'expliquem com fer-lo servir:"
	 
	echo "Us:"
	echo "./programa [OPCIONS]"
	echo "│	" 
	echo "Opcions:"
	echo "-h	            Mostra el missatge d'ajuda"
	echo " "
	echo "Exemple:"
	echo "./programa  Executa el programa i l'envia al directori actual de l'usuari"
	echo "│	"
	exit 1
fi
if [ $# != 0 ]; then
	echo "ERROR MESSAGE!"
	echo "Usage: ./program [-h]"
	echo "Utilitza -h per veure el manual d'ajuda"
	echo "Programa que analitza les interficies del sistema "
	echo "ANOTACIÓ IMPORTANT! NECESITES SER SUPERUSUARI"
	echo "S'han de tenir instal·lats els programes ipcalc i whois "
	echo "Si no es tenen instal·lades s'ha de fer:"
	echo "	- sudo apt-get install ipcalc"
	echo "	- sudo apt-get install whois"
	echo "l'arxiu .txt va a parar a teva ubicació actual dins el sistema (pwd/a.txt)	"
	echo "│	"
	
	echo "Realitzat per: David Martinez i Joaquim Hervàs" 
	exit 1
fi
####################################################################################################
##################################COMPROBACIONES##################################################################

#COMPROBACIO INSTALACIO + PERMISOS
command -v whoami > /dev/null 2>&1 || { echo >&2 "Es necesari descarregar whoami. \n Utilitza -h per veure el manual d'ajuda"; exit 1; }
command -v ipcalc > /dev/null 2>&1 || { echo >&2 "Es necesari descarregar ipcalc. \n Utilitza -h per veure el manual d'ajuda"; exit 1; }
if [ $UID -eq 1 ]; then 
echo "ERROR MESSAGE!"
echo "necessites permisos de root!"
echo "Utilitza -h per veure el manual d'ajuda"
exit 1
fi
####################################################################################################
##################################INTRODUCCIONFUNCIONES##################################################################
source ./funcions.sh
source ./recuadro.sh

introduccio
####################################################################################################
touch a.txt




#############################INICIO#######################################################################
echo "Realitzant l'introducció..."
echo "InsertarInicio"> a.txt
echo "│ ">> a.txt
echo "│                ----------------------------------">> a.txt
echo "│           Analisi de les interficies del sistema realitzada">> a.txt
echo "│           per l'usuari $usuari de l'equip $nom_host.">> a.txt
echo "│           Sistema operatiu: $sistema_operatiu">> a.txt
echo "│           Versió del script 0.0 compilada el $data.">> a.txt
echo "│           Analisi iniciada en data $data a les $hora">> a.txt
echo "│                ----------------------------------">> a.txt
echo "│ ">> a.txt
echo "│ ">> a.txt
echo "Introducció realitzada!"
echo "InsertarFinal">> a.txt


####################################################################################################
###############################BUCLEINTERFICIES#####################################################################
for i in $interficie
do
	echo "InsertarInicio">> a.txt

	i_good=${i//:/}
	
	########################PRIMERBLOC############################################################################
	#Primer bloc
	configuracioScript $i_good
	echo "Configuració de la interfície $i_good(1a part)..."	
	echo "│ ">> a.txt
	echo "│ ">> a.txt
	echo "│                -------------------------------------------------------">> a.txt
	echo "│                   Configuració de la interfície $i_good">> a.txt
	echo "│                -------------------------------------------------------">> a.txt
	echo "│ Interfície:                 $i_good">> a.txt
	echo "│ Fabricant(pci):             $fabricant">> a.txt
	echo "│ Adreça MAC:                 $admac">> a.txt
	echo "│ Estat de la interfície:     $estat_interficie">> a.txt		
	echo "│ Mode de la interfície:      $mode_interficie, amb mtu $mtu">> a.txt
	echo "│ ">> a.txt
	echo "1a part realitzada correctament!"
	####################################################################################################

	#Nou bloc 1
    if [ $(iw dev | grep "Interface" | awk '{print$2}' | grep ${i_good} | wc -c) != 0 ]; then		
		echo "│ ">> a.txt
		echo "│ Dispositiu Wi-Fi:            $Disp">>a.txt
		echo "│ Mode de treball:             $Modes">>a.txt
		echo "│ Potencia de transmissio:     $Poten">>a.txt
		if [ "$(iw dev $1 link | grep "Connected" | wc -c)" != "0" ]; then
			echo "│ Connexió a xarxa:            no associat">>a.txt
		else
			echo "│ ">> a.txt
		
			#Nou bloc 2
			echo "│ SSID de la xarxa:            $ssid">>a.txt
			echo "│ Canal de treball:            $canal">>a.txt
			echo "│ Nivell de senyal:            $senyal">>a.txt
			echo "│ Punt d'accés associat:       $puntAcces">>a.txt
			echo "│ Vel. Wi-Fi Recepció:         $velWifiRecepcio">>a.txt
			echo "│ Vel. Wi-Fi Transmissió:      $velWifiTransmissio">>a.txt
			echo "│ ">> a.txt
		fi
	fi
	echo "Configuració de la interfície $i_good(2a part)..."
	#Segon bloc

	try=$(ip a show ${i_good} | grep 'LOOPBACK')
	if [ $if_not_loopback != 0 ]; then 
		echo "│ Adreçament:                 loopback (fitxer /etc/network/interfaces)">> a.txt
	else
		if [ "$mode_adre" == "static" ]; then
			echo "│ Adreçament:                 estàtic (fitxer /etc/network/interfaces)">> a.txt
		else 
			echo "│ Adreçament:                 dinàmic (DHCP $gateway2)">> a.txt

		fi
	fi
	
	echo "│ Adreça ip / màscara:        $adreca_ip ($mascara" "$mascara_2)">> a.txt
	echo "│ Adreça de xarxa:            $ip_a [$adreca_xarxa" - " $adreca_xarxa2]"	>> a.txt
	echo "│ Adreça de broadcast:        $broadcast1 ($broadcast2)">> a.txt
	echo "│ Gateway per defecte:        $gateway">> a.txt
	echo "│ ">>a.txt
	echo "│ Adreça ip / màscara:        $adreca_ip ($mascara" "$mascara_2)">> a.txt
	echo "│ Adreça de xarxa:            $ip_a [$adreca_xarxa" - " $adreca_xarxa2]"	>> a.txt
	echo "│ Adreça de broadcast:        $broadcast1 ($broadcast2)">> a.txt
	echo "│ Gateway per defecte:        $gateway">> a.txt

		
	if [ $(ip a show ${i_good} | grep 'LOOPBACK' | wc -c) != 0 ]; then 
		echo "│ Nom DNS:                    localhost">> a.txt

		echo "│ ">> a.txt

		
		
		
	else
		if [ $ping_down != 0 ]; then 
			echo "No connection !"
			exit 1
		else
		
		
			if [ $DNS == "127.0.0.53" ]; then
				echo "│ Nom DNS:                    -">> a.txt
			else
				echo "│ Nom DNS:                    $DNS">> a.txt
			fi
		fi
		echo "│ ">> a.txt
		echo "2a part realitzada correctament!"
		echo "Configuració de la interfície $i_good(3a part)..."
		#Tercer bloc
		
		echo "│ Adreça IP publica:          $ip  [ $ip_publica ]">> a.txt
		
		if [ "$mascara" == "$ip" ]; then
			echo "│ Detecció de NAT:            Nat no detectada">> a.txt
		
		else
			echo "│ Detecció de NAT:            NAT detectada $router_involucrat routers involucrats [$gateway2 -> $ip ($ip_publica)]">> a.txt
			if [ $(iw dev | grep "Interface" | awk '{print$2}' | grep ${i_good} | wc -c) != 0 ]; then

				echo "│ Consulta sobre:             $ip  $ip_publica ">> a.txt
			fi
		fi
		if [ $(iw dev | grep "Interface" | awk '{print$2}' | grep ${i_good} | wc -c) == 0 ]; then
			echo "│ Nom del domini:             $nom_domini">> a.txt
		fi
		echo "│ Xarxes de l'entitat:        $xarxa_entitat1 $xarxa_entitat2 [$xarxa_entitat3]">> a.txt
		echo "│ Entitat propietària:        $entitat_propietaria">> a.txt
		echo "│ ">> a.txt
		echo "3a part realitzada correctament!"
		echo "Configuració de la interfície $i_good(4a part)..."
		#Quart bloc


		if [[ "$primeralinia" == *"$palabraiproute"* ]]; then
			echo "│ Rutes involucrades:         $ruta_involucrada1">> a.txt
			echo "│                             $ruta_involucrada2">> a.txt
			echo "│"														>> a.txt
		else 
			echo "│ Rutes involucrades:         $ruta_involucrada3">> a.txt
			echo "│ ">> a.txt
		fi
		
		
	
		
		
		
	
	fi
	#Cinque bloc
	echo "Configuració de les velocitats de transmissió... Això pot tardar màxim 30 segons..."
	echo "│ Tràfic Rebut                $bytes_rebuts bytes [$paquets_rebuts paquets] ($errors_rebuts errors, $descartats_rebuts descartats, $perduts_rebuts perduts)" >> a.txt
	echo "│ Tràfic transmés             $bytes_transmesos bytes [$paquets_transmesos paquets] ($errors_transmesos errors, $descartats_transmesos descartats, $perduts_transmesos colisions)" >> a.txt
	Vrecepcio1=$(cat /proc/net/dev | grep "${i}" | awk '{print $3}')
	sleep 5
	Vrecepcio2=$(cat /proc/net/dev | grep "${i}" | awk '{print $3}')
	Vrecep=$((($Vrecepcio2 - $Vrecepcio1)/5))
	echo "│ Velocitat de recepcio       ${Vrecep} bytes/s">> a.txt
	Vtransmisio1=$(cat /proc/net/dev | grep "${i}" | awk '{print $10}')
	sleep 5
	Vtransmisio2=$(cat /proc/net/dev | grep "${i}" | awk '{print $10}')
	Vtrans=$((($Vtransmisio2 - $Vtransmisio1)/5))
	echo "│ Velocitat de Transmissio    ${Vtrans} bytes/s">> a.txt

	echo "penultima part realitzada correctament! "

	echo "│                ----------------------------------">> a.txt
	echo "│  ">> a.txt

	echo "InsertarFinal">> a.txt


	######################################TABLA################################3
    if [ $(iw dev | grep "Interface" | awk '{print$2}' | grep ${i_good} | wc -c) != 0 ]; then
		echo "Realitzant un scan de les xarxes!! Això pot durar una estona ... D:"

		echo "InsertarInicio">> a.txt
		
		touch b.txt
		iw dev $i_good scan > b.txt



		touch c.txt
		touch d.txt
		echo "│ SSID!canal!freqüència!senyal!v. max.!xifrat!algorismes xifrat!Adreça MAC!fabricant">> d.txt
		echo "│ ---------!---!----------!------!---------!-------!---------!-----------!--------">> d.txt
		while read line; do
			if [[ $line == *"wlxfc3497286aa9"* ]]; then
				if [ ! -s c.txt ]; then
					echo "$line" > c.txt
					#primera linea

				else
					#CREAMOS LA LINEA DE LA COMANDA AQUI
					touch d.txt
					mac2=$(cat c.txt | grep "on" | awk '{print$2}' | head -n 1 | tr -d "(on")
					ssid2=$(cat c.txt | grep "SSID" | awk '{print$2$3$4$5$6}'| head -n 1)
					if [[ "$ssid2" == *"x00x"* ]]; then
					ssid2="."
					fi
					canal2=$(cat c.txt | grep "primary channel" | awk '{print$4}'| head -n 1)
					frequencia2=$(cat c.txt | grep "freq" | awk '{print$2 " MHz"}'| head -n 1)
					signal2=$(cat c.txt | grep "signal" | awk '{print$2" "$3}'| head -n 1)
					#XIFRAT
					if [[ $(grep "Privacy" c.txt) ]]; then
						if [[ $(grep "WPA" c.txt) ]]; then 
							if [[ $(grep "RSN" c.txt) ]];then
								xifrat2="WPA2"

							else
								xifrat2="WPA"
							fi

						else 
							xifrat2="WEP"
						fi
					else
						xifrat2="sense"
					fi
					algorismeXifrat1=$(cat c.txt | grep "Authentication suites" | head -n 1 | awk '{print $4}' | tr -d "\n")
        			algorismeXifrat2=$(cat c.txt | grep "Pairwise ciphers" | head -n 1 | awk '{print $4}' | tr -d "\n")
        			algorismeXifrat3=$(cat c.txt | grep "Group cipher" | head -n 1 | awk '{print $4}' | tr -d "\n") 
					if [[ $(grep "RSN" c.txt) ]]; then
						alg2="$algorismeXifrat1-$algorismeXifrat2-$algorismeXifrat3"
					else
						alg2="·"
					fi
					
					
					newmac2=$(echo "${mac2//:}" | tr -d ":" | cut -c 1-6 | tr '[:lower:]' '[:upper:]')
					#echo $newmac
					if [ -n "$newmac2"  ]; then
						fab2=$(cat /usr/share/nmap/nmap-mac-prefixes | grep $newmac2) 
									
					fi
					if [ -z "$fab2"  ]; then
						fab2="desconegut" 
									
					fi

					vMax2=$(cat c.txt | grep "Extended supported rates" | awk '{print $NF " Mbps"}')
					
					echo "│ $ssid2!$canal2!$frequencia2!$signal2!$vMax2!$xifrat2!$alg2!$mac2!$fab2" >> d.txt
					#CREAMOS LA LINEA DE LA COMANDA AQUI
					echo "$line" > c.txt
				fi    
					
			else
				echo "$line" >> c.txt

			fi
		done < b.txt
		touch e.txt
		lista=$(cat  d.txt| column -s! -t | awk '{print$3}')
		sorted=$(echo $lista | sort)
		count=$(echo "$sorted" | uniq -c | wc -l)
		
		echo "│ ---------------------------------------------------------------------------">> a.txt
		echo "│                     S'han detectat $(grep -c "dBm" d.txt) en $count canals a la interfice $i_good">> a.txt
		echo "│ ---------------------------------------------------------------------------">> a.txt
		
		cat d.txt | column -s! -t >>a.txt
		rm d.txt

		echo "InsertarFinal">> a.txt

	fi
	######################################TABLA################################3

	
done
#cuadrado
echo "Programa acabat correctament!! :D"

rm b.txt
rm c.txt
rm e.txt
recuadroG