sudo systemctl disable avahi-daemon.service
sudo systemctl stop avahi-daemon.service
#systemctl disable messagebus.service
#systemctl stop messagebus.service
sudo systemctl ksmd off
sudo systemctl ksmtuned stop
sudo systemctl ksmtuned off
sudo systemctl ksmd stop
sudo systemctl iptables stop
sudo systemctl mask firewalld
sudo systemctl stop firewalld
sudo systemctl iptables save
sudo systemctl disable iptables.service
sudo systemctl stop iptables.service
sudo systemctl disable ip6tables.service
sudo systemctl stop ip6tables.service
#ppc64_cpu --smt-snooze-delay=16777215
sudo ppc64_cpu --smt-snooze-delay=0
sudo ppc64_cpu --dscr=1

