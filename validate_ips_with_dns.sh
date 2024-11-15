#!/bin/bash

# Funcție pentru verificarea IP-urilor și asocierea cu un host
check_ip() {
    local host=$1
    local ip=$2
    local dns_server=$3

    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        # Verifică asocierea IP-host folosind un server DNS
        resolved_ip=$(dig @$dns_server +short "$host")

        if [[ "$resolved_ip" == "$ip" ]]; then
            echo "Valid association: $host -> $ip"
        else
            echo "Invalid association: $host -> $ip (DNS resolved: $resolved_ip)"
        fi
    else
        echo "Invalid IP: $ip"
    fi
}

# Parcurge fișierul /etc/hosts
while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    host=$(echo "$line" | awk '{print $2}')
    
    # Apel funcție pentru verificare
    check_ip "$host" "$ip" "8.8.8.8"  # Exemplu folosind DNS Google
done < /etc/hosts

