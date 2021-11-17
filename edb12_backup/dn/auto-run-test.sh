#!/bin/bash

VM_RUN=no



# Check for testcase pending to run.
testcase=`find ./tc/* -type f | sort | head -n 1`
while [ ! -z ${testcase} ];
do

echo Running Testcase ${testcase}
source ${testcase}
echo runname=${runname}
echo SCALE=${SCALE}
echo thread=${thread}
echo mode=${mode}
echo perf_stat=${perf_stat}
echo Cores=${cores}
echo VM_RUN=$VM_RUN
echo Mount HOST=$HOST
echo Mount point=$MOUNT
echo Command to Run=$RUN_CMD
###################################################################################################

hostname=`hostname`
echo hostname=`hostname`

if [ -z "${VM_RUN}" ]; then
VM_RUN=no
fi

if [ -z "${HOST}" ]; then
HOST="129.40.83.124"
fi

if [ -z "${MOUNT}" ]; then
MOUNT="/home/deepak/output"
fi

if [ -z "${recreateduringrun}" ]; then
recreateinstance=yes
fi

if [ -z "${warmup}" ]; then
warmup=no
fi

if [ -z "${perf_stat}" ]; then
perf_stat=no
fi

if [ -z "${SCALE}" ]; then
SCALE=1000
fi

if [ -z "${thread}" ]; then
thread="160 170 180 190 200 210 220 230 240 260 270 280 290 300"
fi

if [ -z "${runtime}" ]; then
runtime=300
fi

if [ -z "${smtlist}" ]; then
smtlist="8"
fi

if [ -z "${PGSQL}" ]; then
export PGSQL=/usr/local/pgsql/bin
fi

if [ -z "${PGPORT}" ]; then
export PGPORT=5444
fi

maxcores=`sudo ppc64_cpu --cores-present|awk '{print $6}'`
if [ -z "${cores}" ]; then
cores=${maxcores}
else
echo Setting Cores to ${cores}
fi
sudo ppc64_cpu --cores-on=${cores}

if [ -z "${RUN_CMD}" ]; then
echo Executing command passed in $RUN_CMD
`$RUN_CMD`
fi

datetime=`date +"%Y-%m-%d-%H%M%S"`
DATETIME=`date +"%Y-%m-%d-%H%M%S"`
datetime=${datetime}_${runname}_${cores}_Cores_${mode}_${SCALE}_Scale
echo Run Name = ${datetime}
sleep 1
mkdir -p runlog/${datetime}

echo recreateinstance=${recreateinstance} >> runlog/${datetime}/run-params.txt
echo cores=${cores} >> runlog/${datetime}/run-params.txt
echo PGPORT=${PGPORT} >> runlog/${datetime}/run-params.txt
echo PGSQL=${PGSQL} >> runlog/${datetime}/run-params.txt
echo smtlist=${smtlist} >> runlog/${datetime}/run-params.txt
echo runtime=${runtime}  >> runlog/${datetime}/run-params.txt
echo thread=${thread}  >> runlog/${datetime}/run-params.txt
echo SCALE=${SCALE}  >> runlog/${datetime}/run-params.txt
echo perf_stat=${perf_stat} >> runlog/${datetime}/run-params.txt
echo recreateduringrun=${recreateduringrun} >> runlog/${datetime}/run-params.txt
echo warmup=${warmup} >> runlog/${datetime}/run-params.txt

#### Validations Done 
rm -f runlog/${hostname}-done
export PATH=${PGSQL}:$PATH;
export PGPORT
${PGSQL}/pg_ctl -V

export LD_LIBRARY_PATH=/usr/libexec/icu-ppas-53.1/lib:/usr/libexec/icu-edb53.1/lib/:$LD_LIBRARY_PATH
sudo sysctl -w net.core.somaxconn=1024

##############################################################
env > runlog/${datetime}/${hostname}-${datetime}-env 2>&1
sysctl -a > runlog/${datetime}/${hostname}-${datetime}-sysctl 2>&1
cat /proc/meminfo > runlog/${datetime}/${hostname}-${datetime}-meminfo 2>&1
cat /proc/cpuinfo > runlog/${datetime}/${hostname}-${datetime}-cpuinfo 2>&1
df > runlog/${datetime}/${hostname}-${datetime}-df 2>&1
lscpu > runlog/${datetime}/${hostname}-${datetime}-lscpu 2>&1
sudo ppc64_cpu --smt > runlog/${datetime}/${hostname}-${datetime}-smt 2>&1
sudo ppc64_cpu --info  > runlog/${datetime}/${hostname}-${datetime}-smt 2>&1
cpupower frequency-info > runlog/${datetime}/${hostname}-${datetime}-cpupower 2>&1
ppc64_cpu --frequency > runlog/${datetime}/${hostname}-${datetime}-ppc64_cpu 2>&1
ulimit -a > runlog/${datetime}/${hostname}-${datetime}-ulimit 2>&1
numactl --hard > runlog/${datetime}/${hostname}-${datetime}-numactl 2>&1
ps -ef > runlog/${datetime}/${hostname}-${datetime}-PS-EF 2>&1
uname -a > runlog/${datetime}/uname
cat /proc/cmdline > runlog/${datetime}/boot-options
rpmquery -a > runlog/${datetime}/installed_rpms 
cat /etc/os-release > runlog/${datetime}/os-release
##############################################################

if [ "${recreateinstance}" = "yes" ]
then
  echo Recreating the Instance
  ${PGSQL}/pg_ctl -D ./data stop -m immediate
  kill -9 `ps -ef |grep postgres| awk '{print $2}'`
  echo Data removing folder
  rm -rf ./data
  echo Initialized DB
  ${PGSQL}/initdb -D ./data
  mv ./data/postgresql.conf ./data/postgresql.conf-ori
  cp ./postgresql.conf ./data/postgresql.conf
  cp  ./data/postgresql.conf runlog/${datetime}/${hostname}-postgresql.conf-NewlyCreated
  sleep 1
  ${PGSQL}/pg_ctl -D ./data start
  pg_ctl -D ./data start
  sleep 5
  echo createdb pgbench
  createdb pgbench
  ${PGSQL}/createdb pgbench
  ${PGSQL}/createdb -p ${PGPORT} pgbench
  sleep 5
  echo initialising tables in the DB in the newly created instance.
  ${PGSQL}/pgbench  -i -s ${SCALE} pgbench >> /tmp/fill-tables  2>&1
else
  #${PGSQL}/pg_ctl -D /media/tmp/data stop
  ${PGSQL}/pg_ctl -D ./data stop -m immediate
  kill -9 `ps -ef |grep postgres| awk '{print $2}'`
  sleep 5
fi

${PGSQL}/pg_ctl -D ./data start
sleep 30

#if [ "`pg_ctl -D ./data status|grep PID|wc -l`" -eq "0" ]
#then
#echo "Server is NOT running on ${hostname} STARTING DB"
#pg_ctl -D ./data start
#sleep 30
#fi
#
#if [ "`pg_ctl -D ./data status|grep PID|wc -l`" -eq "0" ]
#then
#echo "Server is NOT running on ${hostname}  RESTARTING DB"
#pg_ctl -D ./data start
#sleep 30
#fi
#
#if [ "`pg_ctl -D ./data status|grep PID|wc -l`" -eq "0" ]
#then
#echo "Server is NOT running on ${hostname}  RESTARTING DB AGAIN"
#pg_ctl -D ./data start
#sleep 30
#fi


echo 0 > runlog/${datetime}/stoprun

rm  runlog/${datetime}/${hostname}-*-ready2run

for smt in ${smtlist} ;
do
{
echo setting the SMT to $smt
sudo ppc64_cpu --smt=$smt
pg_ctl -D ./data stop
kill -9 `ps -ef |grep postgres| awk '{print $2}'`
sleep 20;
pg_ctl -D ./data start
sleep 20

for tr in ${thread} ;
do
(
        echo Executing run cycle for thread = $tr

        stoprun=`cat runlog/${datetime}/stoprun`
        echo Checkingstoprun flag
        if [ "$stoprun" -eq "1" ]
        then
          echo Stop Run requested. Exiting the test
          break 10
        fi


        #Recreate and populate DB before each run
        if [ "${recreateduringrun}" = "yes" ]
        then
	   pg_ctl -D ./data stop -m immediate
	   sleep 20;
           kill -9 `ps -ef |grep postgres| awk '{print $2}'`
  	   echo Data removing folder
  	   rm -rf ./data
  	   echo Initialized DB
  	   ${PGSQL}/initdb -D ./data
  	   mv ./data/postgresql.conf ./data/postgresql.conf-ori
  	   cp ./postgresql.conf ./data/postgresql.conf
  	   cp  ./data/postgresql.conf runlog/${datetime}/${hostname}-postgresql.conf-NewlyCreated
  	   sleep 1
	   pg_ctl -D ./data start
  	   sleep 20
           #Drop , Create and initialize the DB
           #echo dropdb pgbench
           #dropdb pgbench
           #sleep 1
	   #pg_ctl -D ./data stop -m immediate
           #sleep 20;
	   #kill -9 `ps -ef |grep postgres| awk '{print $2}'`
           #pg_ctl -D ./data start
           #sleep 20
           #mkdir -p data
           echo createdb pgbench
           ${PGSQL}/createdb  pgbench
           sleep 5

	echo "Client    TPS"
	echo "------    ---"
	paste <(grep threads: runlog/${datetime}/*log|awk '{print $4}') <(grep inclu runlog/${datetime}/*log|awk '{print $3}')

           echo initialising tables in DB.
           ${PGSQL}/pgbench -i -s ${SCALE} pgbench >> /tmp/fill-tables  2>&1
           #sleep 600
           sleep 10
        fi

        #ntpdate -v -s pool.ntp.org
        # Scheduling synchronous run
        date +"%Y-%m-%d-%H%M%S" > runlog/${datetime}/${hostname}-$smt-$tr-ready2run
        touch runlog/${datetime}/${hostname}-$smt-$tr-ready2run
        echo waiting for other VM to be ready
#################################################################################################

	#echo ready > /mnt/edb/`hostname`-edb-ready2run
	if [ "$VM_RUN" == "yes" ]; then
   		clear
   		echo Multi VM run enabled
   		echo Waiting for other VM to be ready...
   		#READY2RUN=`ls /mnt/edb/*-edb-ready2run|wc -l`
   		#COUNTVM=`cat /mnt/edb/edb-countvm`
   		sudo mkdir -p /mnt/edb
   		sudo chmod 777 /mnt/edb
   		sudo umount -f /mnt/edb
   		sudo mount.nfs $HOST:$MOUNT /mnt/edb
   		#sudo rm -f /mnt/edb/*-edb-ready2run
   		sudo rm -f /mnt/edb/`hostname`-edb-ready2run
		
   		#echo $DATETIME > /mnt/edb/`hostname`-edb-ready2run
   		#READY2RUN=`ls /mnt/edb/*-edb-ready2run|wc -l`
		READY2RUN=0
   		COUNTVM=`cat /mnt/edb/edb-countvm`
		
   		while [ "$READY2RUN" -lt "$COUNTVM" ]
   		do
                stoprun=`cat runlog/${datetime}/stoprun`
                if [ "$stoprun" -eq "1" ]
                then
                echo Stop Run requested. Exiting the test
                break 10
                fi

       			sleep 1
       			echo .
       			echo $DATETIME > /mnt/edb/`hostname`-edb-ready2run
       			READY2RUN=`ls /mnt/edb/*-edb-ready2run|wc -l`
   		done
	fi

###################################################################################################

if [ -z "${recreateinstance}" ]; then
recreateinstance=yes
fi

        sudo ppc64_cpu --cores-present
        sudo ppc64_cpu --cores-on
        sudo ppc64_cpu --smt
        sudo ppc64_cpu --subcores-per-core
        sudo ppc64_cpu --threads-per-core
        sudo ppc64_cpu --info

	if [ "`pg_ctl -D ./data status|grep PID|wc -l`" -eq "0" ]
	then
		echo "Server is NOT running on ${hostname}  RESTARTING DB AGAIN"
		pg_ctl -D ./data start
		sleep 30
	fi

        echo Number of VM = `cat runlog/${datetime}/countvm`
        echo Number VM ready to run = `ls runlog/${datetime}/*-$smt-$tr-ready2run|wc -l`

        echo Starting PGBENCH test on ${hostname} for thread = $tr for time = ${runtime}
        echo Starting PGBENCH test on ${hostname} for thread = $tr for time = ${runtime} > runlog/${datetime}/${hostname}-$smt-$tr-starttime
        echo Start time is `date +"%Y-%m-%d-%H:%M:%S"`
	if [ "${perf_stat}" == "yes" ]
	then
        	echo Starting Perf Data collection script
        	vmstat 60 5     > runlog/${datetime}/${hostname}-$smt-$tr-vmstat.log &
        	iostat 60 5     > runlog/${datetime}/${hostname}-$smt-$tr-iostat.log &
        	mpstat 60 5     > runlog/${datetime}/${hostname}-$smt-$tr-mpstat.log &
        	sar -n DEV 60 5 > runlog/${datetime}/${hostname}-$smt-$tr-sar.log &
	fi

	echo "Client    TPS"
	echo "------    ---"
	paste <(grep threads: runlog/${datetime}/*log|awk '{print $4}') <(grep inclu runlog/${datetime}/*log|awk '{print $3}')

	########################################
	if [ "${mode}" == "select" ]; then
       		echo " This is a Read-ONLY Test" ; 
		echo ${PGSQL}/pgbench -n -S -T ${runtime} -c $tr -j $tr pgbench
		${PGSQL}/pgbench -n -S -T ${runtime} -c $tr -j $tr pgbench
	else
       		echo " This is a Read-Write Test" ; 
		echo ${PGSQL}/pgbench -n -T ${runtime} -c $tr -j $tr pgbench
		${PGSQL}/pgbench -n -T ${runtime} -c $tr -j $tr pgbench
	fi
	########################################

        echo End time is `date +"%Y-%m-%d-%H:%M:%S"` on ${hostname}
        echo End time is `date +"%Y-%m-%d-%H:%M:%S"` on ${hostname} > runlog/${datetime}/${hostname}-$smt-$tr-endtime

  ${PGSQL}/pg_ctl -D ./data stop -m immediate
  killall pgbench
  sleep 10
  kill -9 `ps -ef |grep postgres | awk '{print $2}'`

  if [ "${VM_RUN}" == "yes" ]
  then
	hostname=`hostname`
	echo "Client    TPS" >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	echo "------    ---"  >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	paste <(grep threads: runlog/${datetime}/*.log|awk '{print $4}') <(grep inclu runlog/${datetime}/*.log|awk '{print $3}') >> /mnt/edb/${hostname}_${datetime}-Summary.txt

 	sudo rm -f /mnt/edb/`hostname`-edb-ready2run
  fi


) 2>&1 | tee -a runlog/${datetime}/${hostname}-pgbench-$smt-$tr-${datetime}.log
done
}
done


#Evaluate Results 
sudo ppc64_cpu --cores-on >>runlog/${datetime}/Summary.txt
lscpu |grep CPU\(s\)\:|grep -v \ CPU\(s\)\:  >>runlog/${datetime}/Summary.txt
sudo ppc64_cpu --smt      >>runlog/${datetime}/Summary.txt
cat /proc/meminfo |grep MemTotal >>runlog/${datetime}/Summary.txt

echo "Client    TPS" >> runlog/${datetime}/Summary.txt
echo "------    ---"  >> runlog/${datetime}/Summary.txt
paste <(grep threads: runlog/${datetime}/*log|awk '{print $4}') <(grep inclu runlog/${datetime}/*log|awk '{print $3}')  >> runlog/${datetime}/Summary.txt

if [ "${VM_RUN}" == "yes" ]
then
	hostname=`hostname`
	sudo ppc64_cpu --cores-on >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	lscpu |grep CPU\(s\)\:|grep -v \ CPU\(s\)\:  >>  /mnt/edb/${hostname}_${datetime}-Summary.txt
	sudo ppc64_cpu --smt      >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	cat /proc/meminfo |grep MemTotal >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	echo "Client    TPS" >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	echo "------    ---"  >> /mnt/edb/${hostname}_${datetime}-Summary.txt
	paste <(grep threads: runlog/${datetime}/*log|awk '{print $4}') <(grep inclu runlog/${datetime}/*log|awk '{print $3}') >> /mnt/edb/${hostname}_${datetime}-Summary.txt 
fi

maxtps=`grep includ runlog/${datetime}/*log|awk '{print $3}'|awk '$0>x{x=$0};END{print x}'`
filename=`find runlog/${datetime} -name "*log" -exec grep "= $maxtps" {} \; -print|grep log`
echo Max Results for the run
grep "number of client" $filename|grep -v -i trans
echo Max TPS = $maxtps

tr=`grep "number of client" $filename|grep -v -i trans |awk '{print $4}'`

if [ "${perf_stat}" != "yes" ]
then
        vmstat 60 5 > runlog/${datetime}/vmstat.log &
        iostat 60 5 > runlog/${datetime}/iostat.log &
        mpstat 60 5 > runlog/${datetime}/mpstat.log &
        sar -n DEV 60 5 > runlog/${datetime}/sar.log &
########################################
  	${PGSQL}/pg_ctl -D ./data start
	sleep 35
	if [ "${mode}" == "select" ]; then
       		echo " This is a Read-ONLY Test" ; 
		echo ${PGSQL}/pgbench -n -S -T ${runtime} -c ${tr} -j ${tr} pgbench
		${PGSQL}/pgbench -n -S -T ${runtime} -c ${tr} -j ${tr} pgbench
	else
       		echo " This is a Read-Write Test" ; ${PGSQL}/pgbench -n -T ${runtime} -c ${tr} -j ${tr} pgbench
	fi
########################################
fi

#stopping DB
${PGSQL}/pg_ctl -D ./data stop
sleep 20
kill -9 `ps -ef |grep postgres| awk '{print $2}'`
echo `date +"%Y-%m-%d-%H:%M:%S"` >runlog/${datetime}/${hostname}-done


mkdir -p ./tc-done
mv ${testcase} ${testcase}-$DATETIME
mv ${testcase}-$DATETIME ./tc-done

cat runlog/${datetime}/Summary.txt

# Check for any testcase pending to run.
testcase=`find ./tc -type f | sort | head -n 1`

done   2>&1 | tee -a runlog/`hostname`_auto-run-`date +"%Y-%m-%d-%H%M%S"`

