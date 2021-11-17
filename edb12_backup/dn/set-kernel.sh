sysctl -w vm.zone_reclaim_mode=0

sysctl -w vm.drop_caches=3

sysctl -w vm.dirty_ratio=60
sysctl -w vm.dirty_background_ratio=60
sysctl -w vm.dirty_background_bytes=37108864
sysctl -w vm.dirty_bytes=296870912

sysctl -w fs.file-max=65535

#sysctl -w vm.nr_overcommit_hugepages=512
#sysctl -w vm.nr_hugepages=6144
#sysctl -w vm.nr_hugepages=2000

sysctl -w vm.hugetlb_shm_group=`id -g enterprisedb`
sysctl -w vm.hugepages_treat_as_movable=0

sysctl -w vm.swappiness=0

shmall=$(( `grep MemTotal /proc/meminfo |awk '{print $2}'` * 1024 * 9 / (`getconf PAGE_SIZE` * 10)))
sysctl -w kernel.shmall=$shmall
shmmax=$(( `grep MemTotal /proc/meminfo |awk '{print $2}'` * 1024 * 8 / 10 ))
sysctl -w kernel.shmmax=$shmmax

#pages=$((` grep ^VmPeak /proc/8006/status|awk '{print $2}'`/ `getconf PAGE_SIZE` + 1 ))
#echo ` grep ^VmPeak /proc/8006/status|awk '{print $2}'` `getconf PAGE_SIZE`
#echo pages = $pages
#sysctl -w vm.nr_hugepages=138

