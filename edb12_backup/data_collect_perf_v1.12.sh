#!/bin/bash
# Version 1.7, added ethtool -S and ethtool -l and capture interrupts by Calvin Sze
# Version 1.8, added more ethtool options  and ps aux to capture memory information for each process by Calvin Sze, 2017/7/31
# Version 1.9, soem clean up ..  
# Version 1.11, added cpu idle - after, fixed perf stat

echo "Collecting data using Version 1.12 at time: `date`" | tee datacollection.txt
# enabling trace
mount -t debugfs none /sys/kernel/debug
echo "" > /sys/kernel/debug/tracing/trace # zero out trace buffer
#end of trace enabling
echo 0 > /proc/sys/kernel/kptr_restrict

if [[ -n $1 ]] 
then
	runlength=$1
else
	((runlength=15*60))
fi

renice -n -20 $$
TSTAMP=`date +%Y%m%d%H%M`
if [[ $# -ge 1 ]];then
        TSTAMP=${TSTAMP}_$1
fi
echo $TSTAMP

OUTDIR=${TSTAMP}
mkdir -p $OUTDIR
cd $OUTDIR
echo "Collecting data at time: `date`" | tee datacollection.txt
nmon -f -t -s 5 -c 180 -m .
date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug1.out
cat /proc/sched_debug >> sched_debug1.out
lspci > lspci.out 
ifconfig > ifconfig.out
date > cpupower-idle-info_before.out;cpupower idle-info  >> cpupower-idle-info_before.out
cat /proc/cmdline   > cmdline.out
cat   /sys/kernel/debug/sched_features >sched_features.out
cat /proc/kallsyms > kallsyms.out
ppc64_cpu --info > ppc64_cpu_info.out
cpupower frequency-info >> ppc64_cpu_info.out
ppc64_cpu --subcores-per-core >ppc64_cpu_subcore-per-core.out


((intervals=runlength))
((vintervals=runlength/5))
vmstat -t 1 $intervals     > vmstat.out &
vmstat -at 1 $intervals     > vmstat.act_memory &
mpstat -P ALL 5 $vintervals > mpstat.out &
iostat -mtxz 5 $vintervals   > iostat.out &
lspci > lspci.out

nvidia-smi -q -d CLOCK >smi_query.out
nvidia-smi -q -d PERFORMANCE >>smi_query.out
nvidia-smi topo --matrix >>smi_query.out
nvidia-smi pmon -d 5 -c $vintervals -s u -o T -f pmon_u.out&
nvidia-smi pmon -d 5 -c $vintervals -s m -o T -f pmon_m.out&
nvidia-smi -q -lms 1000 -d MEMORY,UTILIZATION,POWER,CLOCK,COMPUTE >>smi_query.out&
SMIID=$!

#print " *** Collecting netstat data "
echo "Collecting before statistics at : `date`" |tee -a datacollection.txt
    netstat -in > netstat_in.before
    netstat -avpe > netstat_vpe.before
    netstat -s > netstat_s.before
    ps -ef > ps-ef_before.out
    ps -eLf > ps-eLf_before.out
    ps aux --sort -rss >ps-aux_before.out

for i in $(ifconfig -a |grep -i enp |awk -F: '{print $1}');do
       ethtool -S $i >ethtool_S.$i.before
       ethtool -l $i >ethtool_l.$i
       ethtool -c $i >ethtool_c.$i
       ethtool -g $i >ethtool_g.$i
       ethtool -k $i >ethtool_k.$i
       ethtool    $i >ethtool.$i
done

cat /proc/interrupts >interrupts.before

echo "Collecting tcpdump  at : `date`" |tee -a datacollection.txt
# tcpdump -s256 -c500000  -B130000 -w tcpdump.bond0.pcap -nnvvi bond0&
# tcpdump -s256 -c500000  -B130000 -w tcpdump.bond1.pcap -nnvvi bond1&
tcpdump -s256 -c500000  -B130000 -w tcpdump.pcap -nnvvi any&
OPPID=$!
sleep 20
kill -SIGINT $OPPID
#kill -9 $(ps -eaf| awk '/tcpdump/{print $2;exit}')
echo "tcpdump completed at : `date`" |tee -a datacollection.txt

#--sleep to allows some additional rampup time before starting profile and counters
sleep 5 

#######################################
echo "starting runtime data collection"
#######################################
cat /etc/os-release > uname.out
uname -a >> uname.out
ps -ef > ps-ef.out
ps -eLf > ps-eLf.out
ps aux --sort -rss >ps-aux.out
dmesg -e > dmesg.STDOUT 2> dmesg-e.STDERR
sysctl -a > sysctl.STDOUT 2> sysctl.STDERR
ulimit -a > ulimit.STDOUT 2> ulimit.STDERR
lsblk -f -t -m > lsblk.STDOUT 2> lsblk.STDERR
cat /etc/fstab > fstab.out
mount > mount.out
lscpu >lscpu.STDOUT 2> lscpu.STDERR
rpm -qa | sort > rpm-qa.STDOUT 2> rpm-qa.STDERR
type dpkg 2>/dev/null && dpkg -l | sort > dpkg-l.STDOUT 2> dpkg-l.STDOUT

if [ -e /proc/ppc64/lparcfg ]; then
          cat /proc/ppc64/lparcfg > lparcfg
    fi

cat /proc/meminfo > meminfo.out
#lsof > lsof.out  #--can be slow if there are a lot of open file descriptors 
numactl --hardware > numactlh.out
numastat -c java > numastatjava.out 

#--create one or move entries like the one below changing searchstring
#--to match process(es) that you are interested in 
#numastat -c searchstring > searchstring.out 


ppc64_cpu --frequency > ppc64_cpu.out
ppc64_cpu --cores-present >> ppc64_cpu.out
ppc64_cpu --smt >> ppc64_cpu.out
ppc64_cpu --cores-on >> ppc64_cpu.out
ppc64_cpu --run-mode >> ppc64_cpu.out
ppc64_cpu --dscr >> ppc64_cpu.out
cat /proc/cpuinfo  > cpuinfo.txt
perf stat -o perf_stat.out sleep 10 

multipath -ll > multipath.out
cat /etc/fstab > fstab.out
#/install/scripts/getpid.sh #--this needs some work

date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug2.out
cat /proc/sched_debug >> sched_debug2.out


#--need to install the kernel-debuginfo packages to get the uncompressed linux kernel that you
#--will need for profiling, then change the --vmlinux string below to match 
# echo "Collecting perf using cycles : `date`" |tee -a datacollection.txt

echo "Collecting operf using cycles : `date`" |tee -a datacollection.txt

#operf -e PM_RUN_CYC:2000000 --vmlinux /usr/lib/debug/boot/vmlinux-3.16.0-45-generic -g -s&
operf -e PM_RUN_CYC:3000000 -g -s&
OPPID=$!
sleep 20
#kill -SIGINT $(ps -ef| awk '/operf/{print $2;exit}')
#kill -9 $(ps -eaf | awk '/operf/{print $2;exit}') 
kill -SIGINT $OPPID

date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug3.out
cat /proc/sched_debug >> sched_debug3.out

sleep 5
echo "Collecting perf profile data (flat) using cycles : `date`" |tee -a datacollection.txt
perf record -e cycles -c 300000 -a sleep 20
mv perf.data perf.data.flat

date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug4.out
cat /proc/sched_debug >> sched_debug4.out
sleep 5

echo "Collecting perf profile data (tree) using cycles : `date`" |tee -a datacollection.txt
perf record --call-graph fp -e cycles -c 300000 -g -a sleep 2
#--collect all counter groups


date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug5.out
cat /proc/sched_debug >> sched_debug5.out

echo "Collecting pmcount data : `date`" |tee -a datacollection.txt
sleep 5

#../get_multi_perf_data_p8.sh 1 .
/home/data/p9_events.sh 3

date >> numastat.out
numastat >> numastat.out
date > sched_debug6.out
cat /proc/sched_debug >> sched_debug6.out

#print " *** Collecting netstat data "
echo "collect netstat data at the end at: `date`" |tee -a datacollection.txt
   netstat -in > netstat_in.after
    netstat -avpe > netstat_vpe.after
    netstat -s > netstat_s.after
    ps -ef > ps-ef_after.out
    ps -eLf > ps-eLf_after.out
    ps aux --sort -rss >ps-aux_after.out
date >cpupower-idle-info_after.out;cpupower idle-info  >> cpupower-idle-info_after.out

for i in $(ifconfig -a |grep -i enp |awk -F: '{print $1}');do
         ethtool -S $i >ethtool_S.$i.after
done
 
cat /proc/interrupts >interrupts.after

#collect trace data
echo 1 > /sys/kernel/debug/tracing/events/enable #enable all trace events
echo 256000 > /sys/kernel/debug/tracing/buffer_size_kb
sleep 2
echo "Collecting 1st set of trace data at : `date`" |tee -a datacollection.txt
echo 1 > /sys/kernel/debug/tracing/tracing_on
sleep 1.5
echo 0 > /sys/kernel/debug/tracing/tracing_on #turn off tracing
#end of tracing

date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug7.out
cat /proc/sched_debug >> sched_debug7.out

#write out first trace data
echo "write the 1st set of trace data at : `date`" |tee -a datacollection.txt
cat /sys/kernel/debug/tracing/trace > trace1.out 
echo "" > /sys/kernel/debug/tracing/trace # zero out trace buffer
echo 1408 > /sys/kernel/debug/tracing/buffer_size_kb

date >> numastat.out
numastat >> numastat.out
date >> free_mem.out
free -m >> free_mem.out
date > sched_debug8.out
cat /proc/sched_debug >> sched_debug8.out


#clean up after tracing
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/kernel/debug/tracing/events/enable #disable all trace events


#--create some profile reports
echo "Postprocessing profile at `date`" |tee -a datacollection.txt

#perf report -k /usr/lib/debug/boot/vmlinux-3.16.0-45-generic > perf_tree.prof 
perf report --call-graph=callee --kallsyms=/proc/kallsyms > perf_tree.prof 
mv perf.data perf.data.tree
mv perf.data.flat perf.data

#perf report --kallsyms=/proc/kallsyms > perf_flat.prof 
perf report --kallsyms=/proc/kallsyms > perf_flat.prof 
perf annotate -v 2>symbols >anno.perf.data

echo "Postprocessing operf profile at `date`" |tee -a datacollection.txt

opreport -lg -o opreport.lg.out
opreport -o opreport.summary.out
# opreport -d -o opreport.details.out
opannotate -a > opreport.assembly.out

echo "waiting or data collection to complete at `date`" |tee -a datacollection.txt
wait
kill -SIGINT $SMIID
echo "packing files at `date`" |tee -a datacollection.txt
cd ..
/bin/tar -cvf `hostname`_${TSTAMP}.tar $TSTAMP
/bin/gzip `hostname`_${TSTAMP}.tar
exit
