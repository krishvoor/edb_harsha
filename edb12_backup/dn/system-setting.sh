systemctl disable avahi-daemon.service
systemctl stop avahi-daemon.service
#systemctl disable messagebus.service
#systemctl stop messagebus.service
systemctl ksmd off
systemctl ksmtuned stop
systemctl ksmtuned off
systemctl ksmd stop
systemctl iptables stop
systemctl mask firewalld
systemctl stop firewalld
systemctl iptables save
systemctl disable iptables.service
systemctl stop iptables.service
systemctl disable ip6tables.service
systemctl stop ip6tables.service
ppc64_cpu --smt-snooze-delay=16777215
ppc64_cpu --dscr=1

