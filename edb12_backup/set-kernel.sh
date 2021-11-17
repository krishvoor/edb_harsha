sudo sysctl -w vm.zone_reclaim_mode=0

sudo sysctl -w vm.drop_caches=3

sudo sysctl -w vm.dirty_ratio=60
sudo sysctl -w vm.dirty_background_ratio=60
sudo sysctl -w vm.dirty_background_bytes=37108864
sudo sysctl -w vm.dirty_bytes=296870912

sudo sysctl -w fs.file-max=65535

#sudo sysctl -w vm.nr_overcommit_hugepages=512
#sudo sysctl -w vm.nr_hugepages=6144
#sudo sysctl -w vm.nr_hugepages=2000

sudo sysctl -w vm.hugetlb_shm_group=`id -g enterprisedb`
sudo sysctl -w vm.hugepages_treat_as_movable=0

sudo sysctl -w vm.swappiness=0

shmall=$(( `grep MemTotal /proc/meminfo |awk '{print $2}'` * 1024 * 9 / (`getconf PAGE_SIZE` * 10)))
sudo sysctl -w kernel.shmall=$shmall
shmmax=$(( `grep MemTotal /proc/meminfo |awk '{print $2}'` * 1024 * 8 / 10 ))
sudo sysctl -w kernel.shmmax=$shmmax

#pages=$((` grep ^VmPeak /proc/8006/status|awk '{print $2}'`/ `getconf PAGE_SIZE` + 1 ))
#echo ` grep ^VmPeak /proc/8006/status|awk '{print $2}'` `getconf PAGE_SIZE`
#echo pages = $pages
#sudo sysctl -w vm.nr_hugepages=138

## Added the following Params
sudo sysctl -w vm.nr_hugepages=2000
sudo sysctl -w vm.nr_overcommit_hugepages=512
sudo sysctl -w  kernel.sched_autogroup_enabled=1
