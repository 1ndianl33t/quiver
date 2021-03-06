#!/usr/bin/env zsh
 
############################################################# 
# qq-enum-dns
#############################################################

qq-enum-dns-sweep-nmap() {
  qq-vars-set-network
  print -z "sudo nmap -n -Pn -sS -sU -p53 ${__NETWORK} -oA $(__netpath)/dns-sweep"
}

qq-enum-dns-tcpdump() {
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "sudo tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 53 -w $(__hostpath)/dns.pcap"
}

qq-enum-dns-txfr-dig() {
  qq-vars-set-rhost
  local zone && read "zone?$fg[cyan]ZONE:$reset_color "
  print -z "dig axfr @${__RHOST} ${zone}"
}

qq-enum-dns-txfr-host() {
  qq-vars-set-rhost
  local zone && read "zone?$fg[cyan]ZONE:$reset_color "
  print -z "host -l ${zone} ${__RHOST}"
}

qq-enum-dns-brute-rev() {
  qq-vars-set-rhost
  local network && read "network?$fg[cyan]NETWORK(ex: 10.10.10):$reset_color "
  print -z "for h in {1..254}; do host ${network}.$h ${__RHOST}; done | grep pointer"
}


