#!/bin/bash

# this script is machine generated, if you need to
# change it below this section, you can probably save work by grabbing the
# script that creates it and editing that or the input file
# send changes or suggestions to me (Greg Mewhinney <mewhinne@us.ibm.com>)
###############################################################################

# output file to which all perf output will be written. If you are using
# multiple invocations it is important that the --append flag be part of the
# perfflags string
outfile="./p9_pmucounts.out"
###############################################################################

# if you run more than one invocation of perf in this script, you'll want the
# --append flag to be part of the perfflags string.
perfflags="-aA -o $outfile --append"
###############################################################################

# leave mode blank to count everything.  add k or u to count only in kernel
# or userspace respectively
mode=""

# by default, the workload to be counted will be whatever you list after on the
# command line when invoking this script.  You could change it to something
# else by changing the workload= line below
workload=$*

###############################################################################

# for long running workloads, short intervals and continuous sampling can be a
# good option.  Set infinite= to 1 to use this mode.  Otherwise you just get
# one collection.
infinite=0

###############################################################################
if ((infinite==1)); then
        echo $$ > /tmp/countscript_pid
fi


dstr=":D"
mstr=""
if [ ! -z $mode ]; then
        mstr=":${mode}"
        dstr=":${mode}D"
fi

repeat=8
while ((repeat))
do

echo "##############################" >> $outfile
echo "flags=$perfflags" >> $outfile
echo "mode=$mode"       >> $outfile
echo "workload=$workload" >> $outfile
echo "##############################" >> $outfile

#--pm_stat Cycles
perf stat $perfflags \
-e "{cpu/config=0x0000010008,name=PM_RUN_SPURR__r0000010008/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x00000400F4,name=PM_RUN_PURR__r00000400F4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l1_1 L1 Load Stores
perf stat $perfflags \
-e "{cpu/config=0x00000100FC,name=PM_LD_REF_L1__r00000100FC/}$mstr" \
-e "{cpu/config=0x00000200FD,name=PM_L1_ICACHE_MISS__r00000200FD/}$mstr" \
-e "{cpu/config=0x00000300F0,name=PM_ST_MISS_L1__r00000300F0/}$mstr" \
-e "{cpu/config=0x00000,name=PM_LD_MISS_L1__r00000400F0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst Group and Instructions complete
perf stat $perfflags \
-e "{cpu/config=0x00000100F2,name=PM_1PLUS_PPC_CMPL__r00000100F2/}$mstr" \
-e "{cpu/config=0x00000200F2,name=PM_INST_DISP__r00000200F2/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x00000400F2,name=PM_1PLUS_PPC_DISP__r00000400F2/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_smt SMT run cycles
perf stat $perfflags \
-e "{cpu/config=0x000001006C,name=PM_RUN_CYC_ST_MODE__r000001006C/}$mstr" \
-e "{cpu/config=0x000002006C,name=PM_RUN_CYC_SMT4_MODE__r000002006C/}$mstr" \
-e "{cpu/config=0x000003006C,name=PM_RUN_CYC_SMT2_MODE__r000003006C/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_thread Thread run
perf stat $perfflags \
-e "{cpu/config=0x00000100FA,name=PM_ANY_THRD_RUN_CYC__r00000100FA/}$mstr" \
-e "{cpu/config=0x000002000C,name=PM_THRD_ALL_RUN_CYC__r000002000C/}$mstr" \
-e "{cpu/config=0x00000300F4,name=PM_THRD_CONC_RUN_INST__r00000300F4/}$mstr" \
-e "{cpu/config=0x000000E8B0,name=PM_TEND_PEND_CYC__r000000E8B0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_sync Sync instructions
perf stat $perfflags \
-e "{cpu/config=0x000000589C,name=PM_PTESYNC__r000000589C/}$mstr" \
-e "{cpu/config=0x0000005894,name=PM_LWSYNC__r0000005894/}$mstr" \
-e "{cpu/config=0x00000050A0,name=PM_HWSYNC__r00000050A0/}$mstr" \
-e "{cpu/config=0x0000002884,name=PM_ISYNC__r0000002884/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_stat Frequency and Interrupt
perf stat $perfflags \
-e "{cpu/config=0x0000002080,name=PM_EE_OFF_EXT_INT__r0000002080/}$mstr" \
-e "{cpu/config=0x00000200F8,name=PM_EXT_INT__r00000200F8/}$mstr" \
-e "{cpu/config=0x000003000C,name=PM_FREQ_DOWN__r000003000C/}$mstr" \
-e "{cpu/config=0x000004000C,name=PM_FREQ_UP__r000004000C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l1_2 L1 Cache reloads
perf stat $perfflags \
-e "{cpu/config=0x000001002C,name=PM_L1_DCACHE_RELOADED_ALL__r000001002C/}$mstr" \
-e "{cpu/config=0x00000200F6,name=PM_LSU_DERAT_MISS__r00000200F6/}$mstr" \
-e "{cpu/config=0x00000300F6,name=PM_L1_DCACHE_RELOAD_VALID__r00000300F6/}$mstr" \
-e "{cpu/config=0x00000400FA,name=PM_RUN_INST_CMPL__r00000400FA/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flush_1 Flushes
perf stat $perfflags \
-e "{cpu/config=0x0000002880,name=PM_FLUSH_DISP__r0000002880/}$mstr" \
-e "{cpu/config=0x00000050A4,name=PM_FLUSH_MPRED__r00000050A4/}$mstr" \
-e "{cpu/config=0x00000058A4,name=PM_FLUSH_LSU__r00000058A4/}$mstr" \
-e "{cpu/config=0x00000400F8,name=PM_FLUSH__r00000400F8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flush_2 Dispatch Flushes
perf stat $perfflags \
-e "{cpu/config=0x0000002084,name=PM_FLUSH_HB_RESTORE_CYC__r0000002084/}$mstr" \
-e "{cpu/config=0x0000002088,name=PM_FLUSH_DISP_SB__r0000002088/}$mstr" \
-e "{cpu/config=0x0000030012,name=PM_FLUSH_COMPLETION__r0000030012/}$mstr" \
-e "{cpu/config=0x0000002888,name=PM_FLUSH_DISP_TLBIE__r0000002888/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flush_3 LSU Flushes
perf stat $perfflags \
-e "{cpu/config=0x00000020B0,name=PM_LSU_FLUSH_NEXT__r00000020B0/}$mstr" \
-e "{cpu/config=0x000000C0A8,name=PM_LSU_FLUSH_CI__r000000C0A8/}$mstr" \
-e "{cpu/config=0x000000C8A8,name=PM_LSU_FLUSH_ATOMIC__r000000C8A8/}$mstr" \
-e "{cpu/config=0x000000C0AC,name=PM_LSU_FLUSH_EMSH__r000000C0AC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flush_4 LSU flushes
perf stat $perfflags \
-e "{cpu/config=0x000000C8AC,name=PM_LSU_FLUSH_RELAUNCH_MISS__r000000C8AC/}$mstr" \
-e "{cpu/config=0x000000C0B0,name=PM_LSU_FLUSH_UE__r000000C0B0/}$mstr" \
-e "{cpu/config=0x000000C8B0,name=PM_LSU_FLUSH_LHS__r000000C8B0/}$mstr" \
-e "{cpu/config=0x000000C0B4,name=PM_LSU_FLUSH_WRK_ARND__r000000C0B4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flush_5 LSU Flushes
perf stat $perfflags \
-e "{cpu/config=0x000000C8B4,name=PM_LSU_FLUSH_LHL_SHL__r000000C8B4/}$mstr" \
-e "{cpu/config=0x000000C0B8,name=PM_LSU_FLUSH_SAO__r000000C0B8/}$mstr" \
-e "{cpu/config=0x000000C8B8,name=PM_LSU_FLUSH_LARX_STCX__r000000C8B8/}$mstr" \
-e "{cpu/config=0x000000C0BC,name=PM_LSU_FLUSH_OTHER__r000000C0BC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pref_1 Prefetch
perf stat $perfflags \
-e "{cpu/config=0x000000F084,name=PM_PTE_PREFETCH__r000000F084/}$mstr" \
-e "{cpu/config=0x000002C058,name=PM_MEM_PREF__r000002C058/}$mstr" \
-e "{cpu/config=0x000000F8B0,name=PM_L3_SW_PREF__r000000F8B0/}$mstr" \
-e "{cpu/config=0x000000F0B0,name=PM_L3_LD_PREF__r000000F0B0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pref_2 L1 Prefetch
perf stat $perfflags \
-e "{cpu/config=0x000000E880,name=PM_L1_SW_PREF__r000000E880/}$mstr" \
-e "{cpu/config=0x0000020054,name=PM_L1_PREF__r0000020054/}$mstr" \
-e "{cpu/config=0x0000030068,name=PM_L1_ICACHE_RELOADED_PREF__r0000030068/}$mstr" \
-e "{cpu/config=0x0000004888,name=PM_IC_PREF_REQ__r0000004888/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pref_3 Icache prefetch
perf stat $perfflags \
-e "{cpu/config=0x000000488C,name=PM_IC_PREF_WRITE__r000000488C/}$mstr" \
-e "{cpu/config=0x0000004090,name=PM_IC_PREF_CANCEL_PAGE__r0000004090/}$mstr" \
-e "{cpu/config=0x0000004890,name=PM_IC_PREF_CANCEL_HIT__r0000004890/}$mstr" \
-e "{cpu/config=0x0000004094,name=PM_IC_PREF_CANCEL_L2__r0000004094/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pref_4 Dcache prefetch
perf stat $perfflags \
-e "{cpu/config=0x000000F0A4,name=PM_DC_PREF_HW_ALLOC__r000000F0A4/}$mstr" \
-e "{cpu/config=0x000000F8A4,name=PM_DC_PREF_SW_ALLOC__r000000F8A4/}$mstr" \
-e "{cpu/config=0x000000F0A8,name=PM_DC_PREF_CONF__r000000F0A8/}$mstr" \
-e "{cpu/config=0x000000F0AC,name=PM_DC_PREF_STRIDED_CONF__r000000F0AC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_1 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x00000200F0,name=PM_ST_CMPL__r00000200F0/}$mstr" \
-e "{cpu/config=0x000000C8BC,name=PM_STCX_SUCCESS_CMPL__r000000C8BC/}$mstr" \
-e "{cpu/config=0x000004003E,name=PM_LD_CMPL__r000004003E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_2 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x000000509C,name=PM_FORCED_NOP__r000000509C/}$mstr" \
-e "{cpu/config=0x0000024050,name=PM_IOPS_CMPL__r0000024050/}$mstr" \
-e "{cpu/config=0x0000034054,name=PM_PARTIAL_ST_FIN__r0000034054/}$mstr" \
-e "{cpu/config=0x000004505E,name=PM_FLOP_CMPL__r000004505E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_3 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x0000010068,name=PM_BRU_FIN__r0000010068/}$mstr" \
-e "{cpu/config=0x000002505C,name=PM_VSU_FIN__r000002505C/}$mstr" \
-e "{cpu/config=0x0000030066,name=PM_LSU_FIN__r0000030066/}$mstr" \
-e "{cpu/config=0x0000040004,name=PM_FXU_FIN__r0000040004/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_4 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x000001E058,name=PM_STCX_FAIL__r000001E058/}$mstr" \
-e "{cpu/config=0x000002E014,name=PM_STCX_FIN__r000002E014/}$mstr" \
-e "{cpu/config=0x000003C058,name=PM_LARX_FIN__r000003C058/}$mstr" \
-e "{cpu/config=0x000004D05E,name=PM_BR_CMPL__r000004D05E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_5 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x000000F8A0,name=PM_NON_DATA_STORE__r000000F8A0/}$mstr" \
-e "{cpu/config=0x0000024052,name=PM_FXU_IDLE__r0000024052/}$mstr" \
-e "{cpu/config=0x000003000E,name=PM_FXU_1PLUS_BUSY__r000003000E/}$mstr" \
-e "{cpu/config=0x0000045054,name=PM_FMA_CMPL__r0000045054/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_6 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x000000F0A0,name=PM_DATA_STORE__r000000F0A0/}$mstr" \
-e "{cpu/config=0x000002000E,name=PM_FXU_BUSY__r000002000E/}$mstr" \
-e "{cpu/config=0x000003005C,name=PM_BFU_BUSY__r000003005C/}$mstr" \
-e "{cpu/config=0x000004D04C,name=PM_DFU_BUSY__r000004D04C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_mix_7 Instructions Mix
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x0000020016,name=PM_ST_FIN__r0000020016/}$mstr" \
-e "{cpu/config=0x000003D058,name=PM_VSU_DP_FSQRT_FDIV__r000003D058/}$mstr" \
-e "{cpu/config=0x000004D04E,name=PM_VSU_FSQRT_FDIV__r000004D04E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_1 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E054,name=PM_CMPLU_STALL__r000001E054/}$mstr" \
-e "{cpu/config=0x000002D018,name=PM_CMPLU_STALL_EXEC_UNIT__r000002D018/}$mstr" \
-e "{cpu/config=0x000003003A,name=PM_CMPLU_STALL_EXCEPTION__r000003003A/}$mstr" \
-e "{cpu/config=0x000004E018,name=PM_CMPLU_STALL_NTC_DISP_FIN__r000004E018/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_2 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x0000010004,name=PM_CMPLU_STALL_LRQ_OTHER__r0000010004/}$mstr" \
-e "{cpu/config=0x000002C010,name=PM_CMPLU_STALL_LSU__r000002C010/}$mstr" \
-e "{cpu/config=0x0000030004,name=PM_CMPLU_STALL_EMQ_FULL__r0000030004/}$mstr" \
-e "{cpu/config=0x000004C010,name=PM_CMPLU_STALL_STORE_PIPE_ARB__r000004C010/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_3 Completion exec unit stalls
perf stat $perfflags \
-e "{cpu/config=0x000001002A,name=PM_CMPLU_STALL_LARX__r000001002A/}$mstr" \
-e "{cpu/config=0x000002C014,name=PM_CMPLU_STALL_STORE_FINISH__r000002C014/}$mstr" \
-e "{cpu/config=0x000003000A,name=PM_CMPLU_STALL_PM__r000003000A/}$mstr" \
-e "{cpu/config=0x000004C014,name=PM_CMPLU_STALL_LMQ_FULL__r000004C014/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_4 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x0000010036,name=PM_CMPLU_STALL_LWSYNC__r0000010036/}$mstr" \
-e "{cpu/config=0x000002C016,name=PM_CMPLU_STALL_PASTE__r000002C016/}$mstr" \
-e "{cpu/config=0x0000030014,name=PM_CMPLU_STALL_STORE_FIN_ARB__r0000030014/}$mstr" \
-e "{cpu/config=0x000004C016,name=PM_CMPLU_STALL_DMISS_L2L3_CONFLICT__r000004C016/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_5 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001003A,name=PM_CMPLU_STALL_LSU_FIN__r000001003A/}$mstr" \
-e "{cpu/config=0x000002C018,name=PM_CMPLU_STALL_DMISS_L21_L31__r000002C018/}$mstr" \
-e "{cpu/config=0x0000030016,name=PM_CMPLU_STALL_SRQ_FULL__r0000030016/}$mstr" \
-e "{cpu/config=0x000004C01A,name=PM_CMPLU_STALL_DMISS_L3MISS__r000004C01A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_6 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001003C,name=PM_CMPLU_STALL_DMISS_L2L3__r000001003C/}$mstr" \
-e "{cpu/config=0x000002C01A,name=PM_CMPLU_STALL_LHS__r000002C01A/}$mstr" \
-e "{cpu/config=0x000003C05C,name=PM_CMPLU_STALL_VFXU__r000003C05C/}$mstr" \
-e "{cpu/config=0x000004C01C,name=PM_CMPLU_STALL_ST_FWD__r000004C01C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_7 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001005A,name=PM_CMPLU_STALL_DFLONG__r000001005A/}$mstr" \
-e "{cpu/config=0x000002C01C,name=PM_CMPLU_STALL_DMISS_REMOTE__r000002C01C/}$mstr" \
-e "{cpu/config=0x0000030026,name=PM_CMPLU_STALL_STORE_DATA__r0000030026/}$mstr" \
-e "{cpu/config=0x000004C01E,name=PM_CMPLU_STALL_CRYPTO__r000004C01E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_8 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001005C,name=PM_CMPLU_STALL_DP__r000001005C/}$mstr" \
-e "{cpu/config=0x000002D016,name=PM_CMPLU_STALL_FXU__r000002D016/}$mstr" \
-e "{cpu/config=0x0000030038,name=PM_CMPLU_STALL_DMISS_LMEM__r0000030038/}$mstr" \
-e "{cpu/config=0x000004D014,name=PM_CMPLU_STALL_LOAD_FINISH__r000004D014/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_9 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E050,name=PM_CMPLU_STALL_TEND__r000001E050/}$mstr" \
-e "{cpu/config=0x000002D012,name=PM_CMPLU_STALL_DFU__r000002D012/}$mstr" \
-e "{cpu/config=0x0000030028,name=PM_CMPLU_STALL_SPEC_FINISH__r0000030028/}$mstr" \
-e "{cpu/config=0x000004D016,name=PM_CMPLU_STALL_FXLONG__r000004D016/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_10 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E052,name=PM_CMPLU_STALL_SLB__r000001E052/}$mstr" \
-e "{cpu/config=0x000002D014,name=PM_CMPLU_STALL_LRQ_FULL__r000002D014/}$mstr" \
-e "{cpu/config=0x0000030036,name=PM_CMPLU_STALL_HWSYNC__r0000030036/}$mstr" \
-e "{cpu/config=0x000004D018,name=PM_CMPLU_STALL_BRU__r000004D018/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_11 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001001C,name=PM_CMPLU_STALL_THRD__r000001001C/}$mstr" \
-e "{cpu/config=0x000002C012,name=PM_CMPLU_STALL_DCACHE_MISS__r000002C012/}$mstr" \
-e "{cpu/config=0x000003C05A,name=PM_CMPLU_STALL_VDPLONG__r000003C05A/}$mstr" \
-e "{cpu/config=0x000004C012,name=PM_CMPLU_STALL_ERAT_MISS__r000004C012/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_12 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E05C,name=PM_CMPLU_STALL_NESTED_TBEGIN__r000001E05C/}$mstr" \
-e "{cpu/config=0x000002E018,name=PM_CMPLU_STALL_VFXLONG__r000002E018/}$mstr" \
-e "{cpu/config=0x000003405C,name=PM_CMPLU_STALL_DPLONG__r000003405C/}$mstr" \
-e "{cpu/config=0x000004D01A,name=PM_CMPLU_STALL_EIEIO__r000004D01A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_13 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x00000100FC,name=PM_LD_REF_L1__r00000100FC/}$mstr" \
-e "{cpu/config=0x000002D01C,name=PM_CMPLU_STALL_STCX__r000002D01C/}$mstr" \
-e "{cpu/config=0x0000034056,name=PM_CMPLU_STALL_LSU_MFSPR__r0000034056/}$mstr" \
-e "{cpu/config=0x000004E016,name=PM_CMPLU_STALL_LSAQ_ARB__r000004E016/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_14 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x0000010006,name=PM_DISP_HELD__r0000010006/}$mstr" \
-e "{cpu/config=0x000002E01E,name=PM_CMPLU_STALL_NTC_FLUSH__r000002E01E/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x000004405C,name=PM_CMPLU_STALL_VDP__r000004405C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- added group Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E05A,name=PM_CMPLU_STALL_ANY_SYNC__r000001E05A/}$mstr" \
-e "{cpu/config=0x000002C01E,name=PM_CMPLU_STALL_SYNC_PMU_INT__r000002C01E/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_15 Frontend stalls
perf stat $perfflags \
-e "{cpu/config=0x0000002880,name=PM_FLUSH_DISP__r0000002880/}$mstr" \
-e "{cpu/config=0x000002E01C,name=PM_CMPLU_STALL_TLBIE__r000002E01C/}$mstr" \
-e "{cpu/config=0x000003E052,name=PM_ICT_NOSLOT_IC_L3__r000003E052/}$mstr" \
-e "{cpu/config=0x000004E010,name=PM_ICT_NOSLOT_IC_L3MISS__r000004E010/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_16 Frontend stalls
perf stat $perfflags \
-e "{cpu/config=0x00000100F8,name=PM_ICT_NOSLOT_CYC__r00000100F8/}$mstr" \
-e "{cpu/config=0x000002D01A,name=PM_ICT_NOSLOT_IC_MISS__r000002D01A/}$mstr" \
-e "{cpu/config=0x0000034058,name=PM_ICT_NOSLOT_BR_MPRED_ICMISS__r0000034058/}$mstr" \
-e "{cpu/config=0x000004D01E,name=PM_ICT_NOSLOT_BR_MPRED__r000004D01E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_17 Frontend stalls
perf stat $perfflags \
-e "{cpu/config=0x0000010064,name=PM_ICT_NOSLOT_DISP_HELD_TBEGIN__r0000010064/}$mstr" \
-e "{cpu/config=0x000002D01E,name=PM_ICT_NOSLOT_DISP_HELD_ISSQ__r000002D01E/}$mstr" \
-e "{cpu/config=0x0000030018,name=PM_ICT_NOSLOT_DISP_HELD_HB_FULL__r0000030018/}$mstr" \
-e "{cpu/config=0x000004E01A,name=PM_ICT_NOSLOT_DISP_HELD__r000004E01A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_18 Frontend stalls
perf stat $perfflags \
-e "{cpu/config=0x000001006A,name=PM_NTC_ISSUE_HELD_DARQ_FULL__r000001006A/}$mstr" \
-e "{cpu/config=0x000002E016,name=PM_NTC_ISSUE_HELD_ARB__r000002E016/}$mstr" \
-e "{cpu/config=0x000003D05A,name=PM_NTC_ISSUE_HELD_OTHER__r000003D05A/}$mstr" \
-e "{cpu/config=0x000004D01C,name=PM_ICT_NOSLOT_DISP_HELD_SYNC__r000004D01C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_19 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x00000100F2,name=PM_1PLUS_PPC_CMPL__r00000100F2/}$mstr" \
-e "{cpu/config=0x000002405A,name=PM_NTC_FIN__r000002405A/}$mstr" \
-e "{cpu/config=0x0000030006,name=PM_CMPLU_STALL_OTHER_CMPL__r0000030006/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_cpi_20 Completion stalls
perf stat $perfflags \
-e "{cpu/config=0x000001E056,name=PM_CMPLU_STALL_FLUSH_ANY_THREAD__r000001E056/}$mstr" \
-e "{cpu/config=0x000002E01A,name=PM_CMPLU_STALL_LSU_FLUSH_NEXT__r000002E01A/}$mstr" \
-e "{cpu/config=0x000003003C,name=PM_CMPLU_STALL_NESTED_TEND__r000003003C/}$mstr" \
-e "{cpu/config=0x000004E012,name=PM_CMPLU_STALL_MTFPSCR__r000004E012/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_1 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x00000100FC,name=PM_LD_REF_L1__r00000100FC/}$mstr" \
-e "{cpu/config=0x000002C04E,name=PM_LD_MISS_L1_FIN__r000002C04E/}$mstr" \
-e "{cpu/config=0x000003E054,name=PM_LD_MISS_L1__r000003E054/}$mstr" \
-e "{cpu/config=0x00000400FE,name=PM_DATA_FROM_MEMORY__r00000400FE/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_2 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C042,name=PM_DATA_FROM_L2__r000001C042/}$mstr" \
-e "{cpu/config=0x00000200FE,name=PM_DATA_FROM_L2MISS__r00000200FE/}$mstr" \
-e "{cpu/config=0x00000300FE,name=PM_DATA_FROM_L3MISS__r00000300FE/}$mstr" \
-e "{cpu/config=0x000004C042,name=PM_DATA_FROM_L3__r000004C042/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_3 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C048,name=PM_DATA_FROM_ON_CHIP_CACHE__r000001C048/}$mstr" \
-e "{cpu/config=0x000002C048,name=PM_DATA_FROM_LMEM__r000002C048/}$mstr" \
-e "{cpu/config=0x000003C04A,name=PM_DATA_FROM_RMEM__r000003C04A/}$mstr" \
-e "{cpu/config=0x000004C04C,name=PM_DATA_FROM_DMEM__r000004C04C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_4 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C04C,name=PM_DATA_FROM_LL4__r000001C04C/}$mstr" \
-e "{cpu/config=0x000002C04A,name=PM_DATA_FROM_RL4__r000002C04A/}$mstr" \
-e "{cpu/config=0x000003C04C,name=PM_DATA_FROM_DL4__r000003C04C/}$mstr" \
-e "{cpu/config=0x000004C04A,name=PM_DATA_FROM_OFF_CHIP_CACHE__r000004C04A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_5 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C040,name=PM_DATA_FROM_L2_NO_CONFLICT__r000001C040/}$mstr" \
-e "{cpu/config=0x000002C040,name=PM_DATA_FROM_L2_MEPF__r000002C040/}$mstr" \
-e "{cpu/config=0x000003C040,name=PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST__r000003C040/}$mstr" \
-e "{cpu/config=0x000004C040,name=PM_DATA_FROM_L2_DISP_CONFLICT_OTHER__r000004C040/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_6 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C044,name=PM_DATA_FROM_L3_NO_CONFLICT__r000001C044/}$mstr" \
-e "{cpu/config=0x000002C042,name=PM_DATA_FROM_L3_MEPF__r000002C042/}$mstr" \
-e "{cpu/config=0x000003C042,name=PM_DATA_FROM_L3_DISP_CONFLICT__r000003C042/}$mstr" \
-e "{cpu/config=0x000004C044,name=PM_DATA_FROM_L31_ECO_MOD__r000004C044/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_7 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C04A,name=PM_DATA_FROM_RL2L3_SHR__r000001C04A/}$mstr" \
-e "{cpu/config=0x000002C046,name=PM_DATA_FROM_RL2L3_MOD__r000002C046/}$mstr" \
-e "{cpu/config=0x000003C048,name=PM_DATA_FROM_DL2L3_SHR__r000003C048/}$mstr" \
-e "{cpu/config=0x000004C048,name=PM_DATA_FROM_DL2L3_MOD__r000004C048/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_8 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C046,name=PM_DATA_FROM_L31_SHR__r000001C046/}$mstr" \
-e "{cpu/config=0x000002C044,name=PM_DATA_FROM_L31_MOD__r000002C044/}$mstr" \
-e "{cpu/config=0x000003C044,name=PM_DATA_FROM_L31_ECO_SHR__r000003C044/}$mstr" \
-e "{cpu/config=0x000004C046,name=PM_DATA_FROM_L21_MOD__r000004C046/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_data_src_9 Source of Data loaded
perf stat $perfflags \
-e "{cpu/config=0x000001C04E,name=PM_DATA_FROM_L2MISS_MOD__r000001C04E/}$mstr" \
-e "{cpu/config=0x0000020018,name=PM_ST_FWD__r0000020018/}$mstr" \
-e "{cpu/config=0x000003C046,name=PM_DATA_FROM_L21_SHR__r000003C046/}$mstr" \
-e "{cpu/config=0x000004C04E,name=PM_DATA_FROM_L3MISS_MOD__r000004C04E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_1 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x0000014042,name=PM_INST_FROM_L2__r0000014042/}$mstr" \
-e "{cpu/config=0x0000004080,name=PM_INST_FROM_L1__r0000004080/}$mstr" \
-e "{cpu/config=0x00000200F2,name=PM_INST_DISP__r00000200F2/}$mstr" \
-e "{cpu/config=0x0000044042,name=PM_INST_FROM_L3__r0000044042/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_2 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x000001404E,name=PM_INST_FROM_L2MISS__r000001404E/}$mstr" \
-e "{cpu/config=0x000002404C,name=PM_INST_FROM_MEMORY__r000002404C/}$mstr" \
-e "{cpu/config=0x00000300FA,name=PM_INST_FROM_L3MISS__r00000300FA/}$mstr" \
-e "{cpu/config=0x000004404A,name=PM_INST_FROM_OFF_CHIP_CACHE__r000004404A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_3 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x000001404C,name=PM_INST_FROM_LL4__r000001404C/}$mstr" \
-e "{cpu/config=0x000002404A,name=PM_INST_FROM_RL4__r000002404A/}$mstr" \
-e "{cpu/config=0x000003404C,name=PM_INST_FROM_DL4__r000003404C/}$mstr" \
-e "{cpu/config=0x0000040012,name=PM_L1_ICACHE_RELOADED_ALL__r0000040012/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_4 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x0000014048,name=PM_INST_FROM_ON_CHIP_CACHE__r0000014048/}$mstr" \
-e "{cpu/config=0x0000024048,name=PM_INST_FROM_LMEM__r0000024048/}$mstr" \
-e "{cpu/config=0x000003404A,name=PM_INST_FROM_RMEM__r000003404A/}$mstr" \
-e "{cpu/config=0x000004404C,name=PM_INST_FROM_DMEM__r000004404C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_5 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x0000014046,name=PM_INST_FROM_L31_SHR__r0000014046/}$mstr" \
-e "{cpu/config=0x0000024044,name=PM_INST_FROM_L31_MOD__r0000024044/}$mstr" \
-e "{cpu/config=0x0000034046,name=PM_INST_FROM_L21_SHR__r0000034046/}$mstr" \
-e "{cpu/config=0x0000044046,name=PM_INST_FROM_L21_MOD__r0000044046/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_6 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x0000014040,name=PM_INST_FROM_L2_NO_CONFLICT__r0000014040/}$mstr" \
-e "{cpu/config=0x0000024040,name=PM_INST_FROM_L2_MEPF__r0000024040/}$mstr" \
-e "{cpu/config=0x0000034042,name=PM_INST_FROM_L3_DISP_CONFLICT__r0000034042/}$mstr" \
-e "{cpu/config=0x000004404E,name=PM_INST_FROM_L3MISS_MOD__r000004404E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_7 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x0000014044,name=PM_INST_FROM_L3_NO_CONFLICT__r0000014044/}$mstr" \
-e "{cpu/config=0x0000024042,name=PM_INST_FROM_L3_MEPF__r0000024042/}$mstr" \
-e "{cpu/config=0x0000034044,name=PM_INST_FROM_L31_ECO_SHR__r0000034044/}$mstr" \
-e "{cpu/config=0x0000044044,name=PM_INST_FROM_L31_ECO_MOD__r0000044044/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_inst_src_8 Source of Instruction loaded
perf stat $perfflags \
-e "{cpu/config=0x000001404A,name=PM_INST_FROM_RL2L3_SHR__r000001404A/}$mstr" \
-e "{cpu/config=0x0000024046,name=PM_INST_FROM_RL2L3_MOD__r0000024046/}$mstr" \
-e "{cpu/config=0x0000034048,name=PM_INST_FROM_DL2L3_SHR__r0000034048/}$mstr" \
-e "{cpu/config=0x0000044048,name=PM_INST_FROM_DL2L3_MOD__r0000044048/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_1 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x0000015040,name=PM_IPTEG_FROM_L2_NO_CONFLICT__r0000015040/}$mstr" \
-e "{cpu/config=0x0000025040,name=PM_IPTEG_FROM_L2_MEPF__r0000025040/}$mstr" \
-e "{cpu/config=0x0000035042,name=PM_IPTEG_FROM_L3_DISP_CONFLICT__r0000035042/}$mstr" \
-e "{cpu/config=0x0000045042,name=PM_IPTEG_FROM_L3__r0000045042/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_2 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x0000015042,name=PM_IPTEG_FROM_L2__r0000015042/}$mstr" \
-e "{cpu/config=0x0000025042,name=PM_IPTEG_FROM_L3_MEPF__r0000025042/}$mstr" \
-e "{cpu/config=0x0000035044,name=PM_IPTEG_FROM_L31_ECO_SHR__r0000035044/}$mstr" \
-e "{cpu/config=0x0000045044,name=PM_IPTEG_FROM_L31_ECO_MOD__r0000045044/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_3 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x0000015044,name=PM_IPTEG_FROM_L3_NO_CONFLICT__r0000015044/}$mstr" \
-e "{cpu/config=0x0000025044,name=PM_IPTEG_FROM_L31_MOD__r0000025044/}$mstr" \
-e "{cpu/config=0x0000035046,name=PM_IPTEG_FROM_L21_SHR__r0000035046/}$mstr" \
-e "{cpu/config=0x0000045046,name=PM_IPTEG_FROM_L21_MOD__r0000045046/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_4 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x0000015046,name=PM_IPTEG_FROM_L31_SHR__r0000015046/}$mstr" \
-e "{cpu/config=0x0000025046,name=PM_IPTEG_FROM_RL2L3_MOD__r0000025046/}$mstr" \
-e "{cpu/config=0x0000035048,name=PM_IPTEG_FROM_DL2L3_SHR__r0000035048/}$mstr" \
-e "{cpu/config=0x0000045048,name=PM_IPTEG_FROM_DL2L3_MOD__r0000045048/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_5 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x0000015048,name=PM_IPTEG_FROM_ON_CHIP_CACHE__r0000015048/}$mstr" \
-e "{cpu/config=0x0000025048,name=PM_IPTEG_FROM_LMEM__r0000025048/}$mstr" \
-e "{cpu/config=0x000003504A,name=PM_IPTEG_FROM_RMEM__r000003504A/}$mstr" \
-e "{cpu/config=0x000004504A,name=PM_IPTEG_FROM_OFF_CHIP_CACHE__r000004504A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_6 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001504A,name=PM_IPTEG_FROM_RL2L3_SHR__r000001504A/}$mstr" \
-e "{cpu/config=0x000002504A,name=PM_IPTEG_FROM_RL4__r000002504A/}$mstr" \
-e "{cpu/config=0x000003504C,name=PM_IPTEG_FROM_DL4__r000003504C/}$mstr" \
-e "{cpu/config=0x000004504C,name=PM_IPTEG_FROM_DMEM__r000004504C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_7 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001504C,name=PM_IPTEG_FROM_LL4__r000001504C/}$mstr" \
-e "{cpu/config=0x000002504C,name=PM_IPTEG_FROM_MEMORY__r000002504C/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004504E,name=PM_IPTEG_FROM_L3MISS__r000004504E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_8 Instruction PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001504E,name=PM_IPTEG_FROM_L2MISS__r000001504E/}$mstr" \
-e "{cpu/config=0x000002F146,name=PM_MRK_DPTEG_FROM_RL2L3_MOD__r000002F146/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004F142,name=PM_MRK_DPTEG_FROM_L3__r000004F142/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_9 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E040,name=PM_DPTEG_FROM_L2_NO_CONFLICT__r000001E040/}$mstr" \
-e "{cpu/config=0x000002E040,name=PM_DPTEG_FROM_L2_MEPF__r000002E040/}$mstr" \
-e "{cpu/config=0x000003E042,name=PM_DPTEG_FROM_L3_DISP_CONFLICT__r000003E042/}$mstr" \
-e "{cpu/config=0x000004E042,name=PM_DPTEG_FROM_L3__r000004E042/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_10 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E042,name=PM_DPTEG_FROM_L2__r000001E042/}$mstr" \
-e "{cpu/config=0x000002E042,name=PM_DPTEG_FROM_L3_MEPF__r000002E042/}$mstr" \
-e "{cpu/config=0x000003E044,name=PM_DPTEG_FROM_L31_ECO_SHR__r000003E044/}$mstr" \
-e "{cpu/config=0x000004E044,name=PM_DPTEG_FROM_L31_ECO_MOD__r000004E044/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_11 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E044,name=PM_DPTEG_FROM_L3_NO_CONFLICT__r000001E044/}$mstr" \
-e "{cpu/config=0x000002E044,name=PM_DPTEG_FROM_L31_MOD__r000002E044/}$mstr" \
-e "{cpu/config=0x000003E046,name=PM_DPTEG_FROM_L21_SHR__r000003E046/}$mstr" \
-e "{cpu/config=0x000004E046,name=PM_DPTEG_FROM_L21_MOD__r000004E046/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_12 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E046,name=PM_DPTEG_FROM_L31_SHR__r000001E046/}$mstr" \
-e "{cpu/config=0x000002E046,name=PM_DPTEG_FROM_RL2L3_MOD__r000002E046/}$mstr" \
-e "{cpu/config=0x000003E048,name=PM_DPTEG_FROM_DL2L3_SHR__r000003E048/}$mstr" \
-e "{cpu/config=0x000004E048,name=PM_DPTEG_FROM_DL2L3_MOD__r000004E048/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_13 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E048,name=PM_DPTEG_FROM_ON_CHIP_CACHE__r000001E048/}$mstr" \
-e "{cpu/config=0x000002E048,name=PM_DPTEG_FROM_LMEM__r000002E048/}$mstr" \
-e "{cpu/config=0x000003E04A,name=PM_DPTEG_FROM_RMEM__r000003E04A/}$mstr" \
-e "{cpu/config=0x000004E04A,name=PM_DPTEG_FROM_OFF_CHIP_CACHE__r000004E04A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_14 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E04A,name=PM_DPTEG_FROM_RL2L3_SHR__r000001E04A/}$mstr" \
-e "{cpu/config=0x000002E04A,name=PM_DPTEG_FROM_RL4__r000002E04A/}$mstr" \
-e "{cpu/config=0x000003E04C,name=PM_DPTEG_FROM_DL4__r000003E04C/}$mstr" \
-e "{cpu/config=0x000004E04C,name=PM_DPTEG_FROM_DMEM__r000004E04C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pteg_src_15 Data PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E04C,name=PM_DPTEG_FROM_LL4__r000001E04C/}$mstr" \
-e "{cpu/config=0x000002E04C,name=PM_DPTEG_FROM_MEMORY__r000002E04C/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004E04E,name=PM_DPTEG_FROM_L3MISS__r000004E04E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_1 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001E04E,name=PM_DPTEG_FROM_L2MISS__r000001E04E/}$mstr" \
-e "{cpu/config=0x000002F142,name=PM_MRK_DPTEG_FROM_L3_MEPF__r000002F142/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004D058,name=PM_VECTOR_FLOP_CMPL__r000004D058/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_2 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F140,name=PM_MRK_DPTEG_FROM_L2_NO_CONFLICT__r000001F140/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003F142,name=PM_MRK_DPTEG_FROM_L3_DISP_CONFLICT__r000003F142/}$mstr" \
-e "{cpu/config=0x000004F144,name=PM_MRK_DPTEG_FROM_L31_ECO_MOD__r000004F144/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_3 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F142,name=PM_MRK_DPTEG_FROM_L2__r000001F142/}$mstr" \
-e "{cpu/config=0x000002F14C,name=PM_MRK_DPTEG_FROM_MEMORY__r000002F14C/}$mstr" \
-e "{cpu/config=0x000003F144,name=PM_MRK_DPTEG_FROM_L31_ECO_SHR__r000003F144/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_4 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F144,name=PM_MRK_DPTEG_FROM_L3_NO_CONFLICT__r000001F144/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003F146,name=PM_MRK_DPTEG_FROM_L21_SHR__r000003F146/}$mstr" \
-e "{cpu/config=0x000004F14A,name=PM_MRK_DPTEG_FROM_OFF_CHIP_CACHE__r000004F14A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_5 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F146,name=PM_MRK_DPTEG_FROM_L31_SHR__r000001F146/}$mstr" \
-e "{cpu/config=0x000002F140,name=PM_MRK_DPTEG_FROM_L2_MEPF__r000002F140/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004F14C,name=PM_MRK_DPTEG_FROM_DMEM__r000004F14C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_6 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F148,name=PM_MRK_DPTEG_FROM_ON_CHIP_CACHE__r000001F148/}$mstr" \
-e "{cpu/config=0x000002F148,name=PM_MRK_DPTEG_FROM_LMEM__r000002F148/}$mstr" \
-e "{cpu/config=0x000003F148,name=PM_MRK_DPTEG_FROM_DL2L3_SHR__r000003F148/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_7 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F14C,name=PM_MRK_DPTEG_FROM_LL4__r000001F14C/}$mstr" \
-e "{cpu/config=0x000002F14A,name=PM_MRK_DPTEG_FROM_RL4__r000002F14A/}$mstr" \
-e "{cpu/config=0x000003F14C,name=PM_MRK_DPTEG_FROM_DL4__r000003F14C/}$mstr" \
-e "{cpu/config=0x000004F146,name=PM_MRK_DPTEG_FROM_L21_MOD__r000004F146/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_pteg_8 Marked PTEG Source
perf stat $perfflags \
-e "{cpu/config=0x000001F14E,name=PM_MRK_DPTEG_FROM_L2MISS__r000001F14E/}$mstr" \
-e "{cpu/config=0x000002F144,name=PM_MRK_DPTEG_FROM_L31_MOD__r000002F144/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004F14E,name=PM_MRK_DPTEG_FROM_L3MISS__r000004F14E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_9 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D142,name=PM_MRK_DATA_FROM_L31_ECO_SHR_CYC__r000001D142/}$mstr" \
-e "{cpu/config=0x000002D14C,name=PM_MRK_DATA_FROM_L31_ECO_SHR__r000002D14C/}$mstr" \
-e "{cpu/config=0x000003D14E,name=PM_MRK_DATA_FROM_DL2L3_MOD__r000003D14E/}$mstr" \
-e "{cpu/config=0x000004D12E,name=PM_MRK_DATA_FROM_DL2L3_MOD_CYC__r000004D12E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_10 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001415A,name=PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST_CYC__r000001415A/}$mstr" \
-e "{cpu/config=0x000002D148,name=PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST__r000002D148/}$mstr" \
-e "{cpu/config=0x0000035150,name=PM_MRK_DATA_FROM_RL2L3_SHR__r0000035150/}$mstr" \
-e "{cpu/config=0x000004C12A,name=PM_MRK_DATA_FROM_RL2L3_SHR_CYC__r000004C12A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_11 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D150,name=PM_MRK_DATA_FROM_DL2L3_SHR__r000001D150/}$mstr" \
-e "{cpu/config=0x000002C128,name=PM_MRK_DATA_FROM_DL2L3_SHR_CYC__r000002C128/}$mstr" \
-e "{cpu/config=0x000003515C,name=PM_MRK_DATA_FROM_RL4__r000003515C/}$mstr" \
-e "{cpu/config=0x000004D12A,name=PM_MRK_DATA_FROM_RL4_CYC__r000004D12A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_12 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x0000014158,name=PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC__r0000014158/}$mstr" \
-e "{cpu/config=0x000002C120,name=PM_MRK_DATA_FROM_L2_NO_CONFLICT__r000002C120/}$mstr" \
-e "{cpu/config=0x000003D14C,name=PM_MRK_DATA_FROM_DMEM__r000003D14C/}$mstr" \
-e "{cpu/config=0x000004E11E,name=PM_MRK_DATA_FROM_DMEM_CYC__r000004E11E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_13 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x0000014156,name=PM_MRK_DATA_FROM_L2_CYC__r0000014156/}$mstr" \
-e "{cpu/config=0x000002C126,name=PM_MRK_DATA_FROM_L2__r000002C126/}$mstr" \
-e "{cpu/config=0x000003012C,name=PM_MRK_ST_FWD__r000003012C/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_14 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D14C,name=PM_MRK_DATA_FROM_LL4__r000001D14C/}$mstr" \
-e "{cpu/config=0x000002C12E,name=PM_MRK_DATA_FROM_LL4_CYC__r000002C12E/}$mstr" \
-e "{cpu/config=0x0000035158,name=PM_MRK_DATA_FROM_L31_ECO_MOD_CYC__r0000035158/}$mstr" \
-e "{cpu/config=0x000004D144,name=PM_MRK_DATA_FROM_L31_ECO_MOD__r000004D144/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_15 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D152,name=PM_MRK_DATA_FROM_DL4__r000001D152/}$mstr" \
-e "{cpu/config=0x000002C12C,name=PM_MRK_DATA_FROM_DL4_CYC__r000002C12C/}$mstr" \
-e "{cpu/config=0x000003D146,name=PM_MRK_DATA_FROM_L3_NO_CONFLICT__r000003D146/}$mstr" \
-e "{cpu/config=0x000004C124,name=PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC__r000004C124/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_16 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D144,name=PM_MRK_DATA_FROM_L3_DISP_CONFLICT__r000001D144/}$mstr" \
-e "{cpu/config=0x000002C122,name=PM_MRK_DATA_FROM_L3_DISP_CONFLICT_CYC__r000002C122/}$mstr" \
-e "{cpu/config=0x000003D144,name=PM_MRK_DATA_FROM_L2_MEPF_CYC__r000003D144/}$mstr" \
-e "{cpu/config=0x000004C120,name=PM_MRK_DATA_FROM_L2_MEPF__r000004C120/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_17 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D146,name=PM_MRK_DATA_FROM_MEMORY_CYC__r000001D146/}$mstr" \
-e "{cpu/config=0x00000201E0,name=PM_MRK_DATA_FROM_MEMORY__r00000201E0/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x00000401E6,name=PM_MRK_INST_FROM_L3MISS__r00000401E6/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_18 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D154,name=PM_MRK_DATA_FROM_L21_SHR_CYC__r000001D154/}$mstr" \
-e "{cpu/config=0x000002D14E,name=PM_MRK_DATA_FROM_L21_SHR__r000002D14E/}$mstr" \
-e "{cpu/config=0x000003D142,name=PM_MRK_DATA_FROM_LMEM__r000003D142/}$mstr" \
-e "{cpu/config=0x000004D128,name=PM_MRK_DATA_FROM_LMEM_CYC__r000004D128/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_19 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D148,name=PM_MRK_DATA_FROM_RMEM__r000001D148/}$mstr" \
-e "{cpu/config=0x000002C12A,name=PM_MRK_DATA_FROM_RMEM_CYC__r000002C12A/}$mstr" \
-e "{cpu/config=0x000003D148,name=PM_MRK_DATA_FROM_L21_MOD_CYC__r000003D148/}$mstr" \
-e "{cpu/config=0x000004D146,name=PM_MRK_DATA_FROM_L21_MOD__r000004D146/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_20 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001415C,name=PM_MRK_DATA_FROM_L3_MEPF_CYC__r000001415C/}$mstr" \
-e "{cpu/config=0x000002D142,name=PM_MRK_DATA_FROM_L3_MEPF__r000002D142/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x0000040118,name=PM_MRK_DCACHE_RELOAD_INTV__r0000040118/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_21 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D140,name=PM_MRK_DATA_FROM_L31_MOD_CYC__r000001D140/}$mstr" \
-e "{cpu/config=0x000002D144,name=PM_MRK_DATA_FROM_L31_MOD__r000002D144/}$mstr" \
-e "{cpu/config=0x0000035156,name=PM_MRK_DATA_FROM_L31_SHR_CYC__r0000035156/}$mstr" \
-e "{cpu/config=0x000004D124,name=PM_MRK_DATA_FROM_L31_SHR__r000004D124/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_22 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001F14A,name=PM_MRK_DPTEG_FROM_RL2L3_SHR__r000001F14A/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003515A,name=PM_MRK_DATA_FROM_ON_CHIP_CACHE_CYC__r000003515A/}$mstr" \
-e "{cpu/config=0x000004D140,name=PM_MRK_DATA_FROM_ON_CHIP_CACHE__r000004D140/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_23 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D14E,name=PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC__r000001D14E/}$mstr" \
-e "{cpu/config=0x000002D120,name=PM_MRK_DATA_FROM_OFF_CHIP_CACHE__r000002D120/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x0000040134,name=PM_MRK_INST_TIMEO__r0000040134/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_24 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001D14A,name=PM_MRK_DATA_FROM_RL2L3_MOD__r000001D14A/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x0000035154,name=PM_MRK_DATA_FROM_L3_CYC__r0000035154/}$mstr" \
-e "{cpu/config=0x000004D142,name=PM_MRK_DATA_FROM_L3__r000004D142/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_25 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001E15E,name=PM_MRK_L2_TM_REQ_ABORT__r000001E15E/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x0000035152,name=PM_MRK_DATA_FROM_L2MISS_CYC__r0000035152/}$mstr" \
-e "{cpu/config=0x00000401E8,name=PM_MRK_DATA_FROM_L2MISS__r00000401E8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_lat_26 Marked Data Source
perf stat $perfflags \
-e "{cpu/config=0x000001415E,name=PM_MRK_DATA_FROM_L3MISS_CYC__r000001415E/}$mstr" \
-e "{cpu/config=0x00000201E4,name=PM_MRK_DATA_FROM_L3MISS__r00000201E4/}$mstr" \
-e "{cpu/config=0x0000030134,name=PM_MRK_ST_CMPL_INT__r0000030134/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_1 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001515A,name=PM_SYNC_MRK_L2MISS__r000001515A/}$mstr" \
-e "{cpu/config=0x0000020132,name=PM_MRK_DFU_FIN__r0000020132/}$mstr" \
-e "{cpu/config=0x0000030132,name=PM_MRK_VSU_FIN__r0000030132/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_2 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x00000101E4,name=PM_MRK_L1_ICACHE_MISS__r00000101E4/}$mstr" \
-e "{cpu/config=0x0000020134,name=PM_MRK_FXU_FIN__r0000020134/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x0000040132,name=PM_MRK_LSU_FIN__r0000040132/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_3 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001016E,name=PM_MRK_BR_CMPL__r000001016E/}$mstr" \
-e "{cpu/config=0x000002013A,name=PM_MRK_BRU_FIN__r000002013A/}$mstr" \
-e "{cpu/config=0x00000301E4,name=PM_MRK_BR_MPRED_CMPL__r00000301E4/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_4 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x00000101E2,name=PM_MRK_BR_TAKEN_CMPL__r00000101E2/}$mstr" \
-e "{cpu/config=0x0000024058,name=PM_MRK_INST__r0000024058/}$mstr" \
-e "{cpu/config=0x000003515E,name=PM_MRK_BACK_BR_CMPL__r000003515E/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_5 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001013E,name=PM_MRK_LD_MISS_EXPOSED_CYC__r000001013E/}$mstr" \
-e "{cpu/config=0x000000D09C,name=PM_MRK_LSU_FLUSH_RELAUNCH_MISS__r000000D09C/}$mstr" \
-e "{cpu/config=0x000003E158,name=PM_MRK_STCX_FAIL__r000003E158/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_6 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001F150,name=PM_MRK_ST_L2DISP_TO_CMPL_CYC__r000001F150/}$mstr" \
-e "{cpu/config=0x0000020130,name=PM_MRK_INST_DECODED__r0000020130/}$mstr" \
-e "{cpu/config=0x0000030130,name=PM_MRK_INST_FIN__r0000030130/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_7 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001F152,name=PM_MRK_FAB_RSP_BKILL_CYC__r000001F152/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003015E,name=PM_MRK_FAB_RSP_CLAIM_RTY__r000003015E/}$mstr" \
-e "{cpu/config=0x0000040154,name=PM_MRK_FAB_RSP_BKILL__r0000040154/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_8 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001D056,name=PM_MRK_LD_MISS_L1_CYC__r000001D056/}$mstr" \
-e "{cpu/config=0x00000201E2,name=PM_MRK_LD_MISS_L1__r00000201E2/}$mstr" \
-e "{cpu/config=0x0000030162,name=PM_MRK_LSU_DERAT_MISS__r0000030162/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_9 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001D15E,name=PM_MRK_RUN_CYC__r000001D15E/}$mstr" \
-e "{cpu/config=0x0000020112,name=PM_MRK_NTF_FIN__r0000020112/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x00000401E0,name=PM_MRK_INST_CMPL__r00000401E0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_10 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x000002F152,name=PM_MRK_FAB_RSP_DCLAIM_CYC__r000002F152/}$mstr" \
-e "{cpu/config=0x0000030154,name=PM_MRK_FAB_RSP_DCLAIM__r0000030154/}$mstr" \
-e "{cpu/config=0x000004015E,name=PM_MRK_FAB_RSP_RD_RTY__r000004015E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_11 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x00000101EA,name=PM_MRK_L1_RELOAD_VALID__r00000101EA/}$mstr" \
-e "{cpu/config=0x0000020138,name=PM_MRK_ST_NEST__r0000020138/}$mstr" \
-e "{cpu/config=0x00000301E2,name=PM_MRK_ST_CMPL__r00000301E2/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_12 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000015154,name=PM_SYNC_MRK_L3MISS__r0000015154/}$mstr" \
-e "{cpu/config=0x0000024056,name=PM_MRK_STCX_FIN__r0000024056/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x0000040116,name=PM_MRK_LARX_FIN__r0000040116/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_13 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x00000101E0,name=PM_MRK_INST_DISP__r00000101E0/}$mstr" \
-e "{cpu/config=0x000002D15E,name=PM_MRK_DTLB_MISS_16G__r000002D15E/}$mstr" \
-e "{cpu/config=0x000003F150,name=PM_MRK_ST_DRAIN_TO_L2DISP_CYC__r000003F150/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_14 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001015E,name=PM_MRK_FAB_RSP_RD_T_INTV__r000001015E/}$mstr" \
-e "{cpu/config=0x000002015E,name=PM_MRK_FAB_RSP_RWITM_RTY__r000002015E/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004F150,name=PM_MRK_FAB_RSP_RWITM_CYC__r000004F150/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_15 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000010134,name=PM_MRK_ST_DONE_L2__r0000010134/}$mstr" \
-e "{cpu/config=0x000002C124,name=PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER__r000002C124/}$mstr" \
-e "{cpu/config=0x000003D140,name=PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER_CYC__r000003D140/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_16 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000015150,name=PM_SYNC_MRK_PROBE_NOP__r0000015150/}$mstr" \
-e "{cpu/config=0x000000D89C,name=PM_MRK_LSU_FLUSH_UE__r000000D89C/}$mstr" \
-e "{cpu/config=0x000000D0A0,name=PM_MRK_LSU_FLUSH_LHS__r000000D0A0/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_17 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000000D8A0,name=PM_MRK_LSU_FLUSH_LHL_SHL__r000000D8A0/}$mstr" \
-e "{cpu/config=0x000000D0A4,name=PM_MRK_LSU_FLUSH_SAO__r000000D0A4/}$mstr" \
-e "{cpu/config=0x000000D8A4,name=PM_MRK_LSU_FLUSH_LARX_STCX__r000000D8A4/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_18 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000015158,name=PM_SYNC_MRK_L2HIT__r0000015158/}$mstr" \
-e "{cpu/config=0x000002D154,name=PM_MRK_DERAT_MISS_64K__r000002D154/}$mstr" \
-e "{cpu/config=0x000003D154,name=PM_MRK_DERAT_MISS_16M__r000003D154/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_19 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001D15C,name=PM_MRK_DTLB_MISS_1G__r000001D15C/}$mstr" \
-e "{cpu/config=0x000002D150,name=PM_MRK_DERAT_MISS_4K__r000002D150/}$mstr" \
-e "{cpu/config=0x000003D152,name=PM_MRK_DERAT_MISS_1G__r000003D152/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_20 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x000002D152,name=PM_MRK_DERAT_MISS_2M__r000002D152/}$mstr" \
-e "{cpu/config=0x000003D156,name=PM_MRK_DTLB_MISS_64K__r000003D156/}$mstr" \
-e "{cpu/config=0x00000401E4,name=PM_MRK_DTLB_MISS__r00000401E4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_21 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000015156,name=PM_SYNC_MRK_FX_DIVIDE__r0000015156/}$mstr" \
-e "{cpu/config=0x000002D156,name=PM_MRK_DTLB_MISS_4K__r000002D156/}$mstr" \
-e "{cpu/config=0x00000301E6,name=PM_MRK_DERAT_MISS__r00000301E6/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_22 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000010132,name=PM_MRK_INST_ISSUED__r0000010132/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003D15E,name=PM_MULT_MRK__r000003D15E/}$mstr" \
-e "{cpu/config=0x000004013A,name=PM_MRK_IC_MISS__r000004013A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_23 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000010138,name=PM_MRK_BR_2PATH__r0000010138/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003013E,name=PM_MRK_STALL_CMPLU_CYC__r000003013E/}$mstr" \
-e "{cpu/config=0x000004C15E,name=PM_MRK_DTLB_MISS_16M__r000004C15E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_24 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000001F05E,name=PM_MRK_PROBE_NOP_CMPL__r000001F05E/}$mstr" \
-e "{cpu/config=0x0000020114,name=PM_MRK_L2_RC_DISP__r0000020114/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x000004C15C,name=PM_MRK_DERAT_MISS_16G__r000004C15C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_25 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x000000D098,name=PM_MRK_LSU_FLUSH_ATOMIC__r000000D098/}$mstr" \
-e "{cpu/config=0x000000D898,name=PM_MRK_LSU_FLUSH_EMSH__r000000D898/}$mstr" \
-e "{cpu/config=0x000003012A,name=PM_MRK_L2_RC_DONE__r000003012A/}$mstr" \
-e "{cpu/config=0x0000040002,name=PM_INST_CMPL__r0000040002/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mrk_26 Marked group to profile
perf stat $perfflags \
-e "{cpu/config=0x0000015152,name=PM_SYNC_MRK_BR_LINK__r0000015152/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003E15C,name=PM_MRK_L2_TM_ST_ABORT_SISTER__r000003E15C/}$mstr" \
-e "{cpu/config=0x00000028A4,name=PM_MRK_TEND_FAIL__r00000028A4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_1 LSU detailed group
perf stat $perfflags \
-e "{cpu/config=0x000000C090,name=PM_LSU_STCX__r000000C090/}$mstr" \
-e "{cpu/config=0x000000C890,name=PM_LSU_NCST__r000000C890/}$mstr" \
-e "{cpu/config=0x000004D050,name=PM_VSU_NON_FLOP_CMPL__r000004D050/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_4 LSU ERAT misses
perf stat $perfflags \
-e "{cpu/config=0x000000E084,name=PM_LS0_ERAT_MISS_PREF__r000000E084/}$mstr" \
-e "{cpu/config=0x000000E884,name=PM_LS1_ERAT_MISS_PREF__r000000E884/}$mstr" \
-e "{cpu/config=0x000000E088,name=PM_LS2_ERAT_MISS_PREF__r000000E088/}$mstr" \
-e "{cpu/config=0x000000E888,name=PM_LS3_ERAT_MISS_PREF__r000000E888/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_5 LSU store rejects
perf stat $perfflags \
-e "{cpu/config=0x000000F088,name=PM_LSU0_STORE_REJECT__r000000F088/}$mstr" \
-e "{cpu/config=0x000000F888,name=PM_LSU1_STORE_REJECT__r000000F888/}$mstr" \
-e "{cpu/config=0x000000F08C,name=PM_LSU2_STORE_REJECT__r000000F08C/}$mstr" \
-e "{cpu/config=0x000000F88C,name=PM_LSU3_STORE_REJECT__r000000F88C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_6 LSU unaligned loads
perf stat $perfflags \
-e "{cpu/config=0x000000C094,name=PM_LS0_UNALIGNED_LD__r000000C094/}$mstr" \
-e "{cpu/config=0x000000C894,name=PM_LS1_UNALIGNED_LD__r000000C894/}$mstr" \
-e "{cpu/config=0x000000C098,name=PM_LS2_UNALIGNED_LD__r000000C098/}$mstr" \
-e "{cpu/config=0x000000C898,name=PM_LS3_UNALIGNED_LD__r000000C898/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_7 LSU load hits stores
perf stat $perfflags \
-e "{cpu/config=0x000000C0A0,name=PM_LSU0_FALSE_LHS__r000000C0A0/}$mstr" \
-e "{cpu/config=0x000000C8A0,name=PM_LSU1_FALSE_LHS__r000000C8A0/}$mstr" \
-e "{cpu/config=0x000000C0A4,name=PM_LSU2_FALSE_LHS__r000000C0A4/}$mstr" \
-e "{cpu/config=0x000000C8A4,name=PM_LSU3_FALSE_LHS__r000000C8A4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_8 LSU SET Miss predicts
perf stat $perfflags \
-e "{cpu/config=0x000000D080,name=PM_LSU0_SET_MPRED__r000000D080/}$mstr" \
-e "{cpu/config=0x000000D880,name=PM_LSU1_SET_MPRED__r000000D880/}$mstr" \
-e "{cpu/config=0x000000D084,name=PM_LSU2_SET_MPRED__r000000D084/}$mstr" \
-e "{cpu/config=0x000000D884,name=PM_LSU3_SET_MPRED__r000000D884/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_9 LSU LDMX finish
perf stat $perfflags \
-e "{cpu/config=0x000000D088,name=PM_LSU0_LDMX_FIN__r000000D088/}$mstr" \
-e "{cpu/config=0x000000D888,name=PM_LSU1_LDMX_FIN__r000000D888/}$mstr" \
-e "{cpu/config=0x000000D08C,name=PM_LSU2_LDMX_FIN__r000000D08C/}$mstr" \
-e "{cpu/config=0x000000D88C,name=PM_LSU3_LDMX_FIN__r000000D88C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_10 LSU collisions
perf stat $perfflags \
-e "{cpu/config=0x000000D090,name=PM_LS0_DC_COLLISIONS__r000000D090/}$mstr" \
-e "{cpu/config=0x000000D890,name=PM_LS1_DC_COLLISIONS__r000000D890/}$mstr" \
-e "{cpu/config=0x000000D094,name=PM_LS2_DC_COLLISIONS__r000000D094/}$mstr" \
-e "{cpu/config=0x000000D894,name=PM_LS3_DC_COLLISIONS__r000000D894/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_11 LSU Queue full
perf stat $perfflags \
-e "{cpu/config=0x000000D0B4,name=PM_LSU0_SRQ_S0_VALID_CYC__r000000D0B4/}$mstr" \
-e "{cpu/config=0x000000D8B4,name=PM_LSU0_LRQ_S0_VALID_CYC__r000000D8B4/}$mstr" \
-e "{cpu/config=0x000000D0BC,name=PM_LSU0_1_LRQF_FULL_CYC__r000000D0BC/}$mstr" \
-e "{cpu/config=0x000000D8BC,name=PM_LSU2_3_LRQF_FULL_CYC__r000000D8BC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_12 LSU TM group
perf stat $perfflags \
-e "{cpu/config=0x000000E094,name=PM_LSU0_TM_L1_HIT__r000000E094/}$mstr" \
-e "{cpu/config=0x000000E894,name=PM_LSU1_TM_L1_HIT__r000000E894/}$mstr" \
-e "{cpu/config=0x000000E098,name=PM_LSU2_TM_L1_HIT__r000000E098/}$mstr" \
-e "{cpu/config=0x000000E898,name=PM_LSU3_TM_L1_HIT__r000000E898/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_13 LSU TM group
perf stat $perfflags \
-e "{cpu/config=0x000000E09C,name=PM_LSU0_TM_L1_MISS__r000000E09C/}$mstr" \
-e "{cpu/config=0x000000E89C,name=PM_LSU1_TM_L1_MISS__r000000E89C/}$mstr" \
-e "{cpu/config=0x000000E0A0,name=PM_LSU2_TM_L1_MISS__r000000E0A0/}$mstr" \
-e "{cpu/config=0x000000E8A0,name=PM_LSU3_TM_L1_MISS__r000000E8A0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_14 LSU TM group
perf stat $perfflags \
-e "{cpu/config=0x000000E0B4,name=PM_LS0_TM_DISALLOW__r000000E0B4/}$mstr" \
-e "{cpu/config=0x000000E8B4,name=PM_LS1_TM_DISALLOW__r000000E8B4/}$mstr" \
-e "{cpu/config=0x000000E0B8,name=PM_LS2_TM_DISALLOW__r000000E0B8/}$mstr" \
-e "{cpu/config=0x000000E8B8,name=PM_LS3_TM_DISALLOW__r000000E8B8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_15 LSU STCX
perf stat $perfflags \
-e "{cpu/config=0x000000F080,name=PM_LSU_STCX_FAIL__r000000F080/}$mstr" \
-e "{cpu/config=0x000000C8BC,name=PM_STCX_SUCCESS_CMPL__r000000C8BC/}$mstr" \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x000004D05C,name=PM_DP_QP_FLOP_CMPL__r000004D05C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_16 LSU group
perf stat $perfflags \
-e "{cpu/config=0x000000F090,name=PM_LSU0_L1_CAM_CANCEL__r000000F090/}$mstr" \
-e "{cpu/config=0x000000F890,name=PM_LSU1_L1_CAM_CANCEL__r000000F890/}$mstr" \
-e "{cpu/config=0x000000F094,name=PM_LSU2_L1_CAM_CANCEL__r000000F094/}$mstr" \
-e "{cpu/config=0x000000F894,name=PM_LSU3_L1_CAM_CANCEL__r000000F894/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_17 LSU unaligned stores
perf stat $perfflags \
-e "{cpu/config=0x000000F0B8,name=PM_LS0_UNALIGNED_ST__r000000F0B8/}$mstr" \
-e "{cpu/config=0x000000F8B8,name=PM_LS1_UNALIGNED_ST__r000000F8B8/}$mstr" \
-e "{cpu/config=0x000000F0BC,name=PM_LS2_UNALIGNED_ST__r000000F0BC/}$mstr" \
-e "{cpu/config=0x000000F8BC,name=PM_LS3_UNALIGNED_ST__r000000F8BC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_18 DARQ entries
perf stat $perfflags \
-e "{cpu/config=0x000001D058,name=PM_DARQ0_10_12_ENTRIES__r000001D058/}$mstr" \
-e "{cpu/config=0x000002E050,name=PM_DARQ0_7_9_ENTRIES__r000002E050/}$mstr" \
-e "{cpu/config=0x000003504E,name=PM_DARQ0_4_6_ENTRIES__r000003504E/}$mstr" \
-e "{cpu/config=0x000004D04A,name=PM_DARQ0_0_3_ENTRIES__r000004D04A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_19 LSU Load Store group
perf stat $perfflags \
-e "{cpu/config=0x000001001A,name=PM_LSU_SRQ_FULL_CYC__r000001001A/}$mstr" \
-e "{cpu/config=0x0000020002,name=PM_INST_CMPL__r0000020002/}$mstr" \
-e "{cpu/config=0x000003E05E,name=PM_L3_CO_MEPF__r000003E05E/}$mstr" \
-e "{cpu/config=0x000004505A,name=PM_SP_FLOP_CMPL__r000004505A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_20 LSU Load Store group
perf stat $perfflags \
-e "{cpu/config=0x000001002E,name=PM_LMQ_MERGE__r000001002E/}$mstr" \
-e "{cpu/config=0x000002003E,name=PM_LSU_LMQ_SRQ_EMPTY_CYC__r000002003E/}$mstr" \
-e "{cpu/config=0x000000408C,name=PM_L1_DEMAND_WRITE__r000000408C/}$mstr" \
-e "{cpu/config=0x000004D056,name=PM_NON_FMA_FLOP_CMPL__r000004D056/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_21 LSU Load Store group
perf stat $perfflags \
-e "{cpu/config=0x0000010062,name=PM_LD_L3MISS_PEND_CYC__r0000010062/}$mstr" \
-e "{cpu/config=0x000002E05E,name=PM_LMQ_EMPTY_CYC__r000002E05E/}$mstr" \
-e "{cpu/config=0x0000030002,name=PM_INST_CMPL__r0000030002/}$mstr" \
-e "{cpu/config=0x0000040008,name=PM_SRQ_EMPTY_CYC__r0000040008/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_22 LSU group
perf stat $perfflags \
-e "{cpu/config=0x000000E080,name=PM_S2Q_FULL__r000000E080/}$mstr" \
-e "{cpu/config=0x000000D0AC,name=PM_SRQ_SYNC_CYC__r000000D0AC/}$mstr" \
-e "{cpu/config=0x000000C09C,name=PM_LS0_LAUNCH_HELD_PREF__r000000C09C/}$mstr" \
-e "{cpu/config=0x000000C89C,name=PM_LS1_LAUNCH_HELD_PREF__r000000C89C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_23 LSU group
perf stat $perfflags \
-e "{cpu/config=0x0000005090,name=PM_SHL_ST_DISABLE__r0000005090/}$mstr" \
-e "{cpu/config=0x000000588C,name=PM_SHL_ST_DEP_CREATED__r000000588C/}$mstr" \
-e "{cpu/config=0x000000508C,name=PM_SHL_CREATED__r000000508C/}$mstr" \
-e "{cpu/config=0x000004505C,name=PM_MATH_FLOP_CMPL__r000004505C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_lsu_24 LSU group
perf stat $perfflags \
-e "{cpu/config=0x000000D0B8,name=PM_LSU_LMQ_FULL_CYC__r000000D0B8/}$mstr" \
-e "{cpu/config=0x000000D8B8,name=PM_LSU0_LMQ_S0_VALID__r000000D8B8/}$mstr" \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x0000045056,name=PM_SCALAR_FLOP_CMPL__r0000045056/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_1 L3 prefetch
perf stat $perfflags \
-e "{cpu/config=0x00000160A0,name=PM_L3_PF_MISS_L3__r00000160A0/}$mstr" \
-e "{cpu/config=0x00000260A0,name=PM_L3_CO_MEM__r00000260A0/}$mstr" \
-e "{cpu/config=0x00000360A0,name=PM_L3_PF_ON_CHIP_CACHE__r00000360A0/}$mstr" \
-e "{cpu/config=0x00000460A0,name=PM_L3_PF_ON_CHIP_MEM__r00000460A0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_2 L3 castout
perf stat $perfflags \
-e "{cpu/config=0x00000268A0,name=PM_L3_CO_L31__r00000268A0/}$mstr" \
-e "{cpu/config=0x00000368A0,name=PM_L3_PF_OFF_CHIP_CACHE__r00000368A0/}$mstr" \
-e "{cpu/config=0x00000468A0,name=PM_L3_PF_OFF_CHIP_MEM__r00000468A0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_3 L3 castout
perf stat $perfflags \
-e "{cpu/config=0x0000010000,name=PM_SUSPENDED__r0000010000/}$mstr" \
-e "{cpu/config=0x00000260A2,name=PM_L3_CI_HIT__r00000260A2/}$mstr" \
-e "{cpu/config=0x00000360A2,name=PM_L3_L2_CO_HIT__r00000360A2/}$mstr" \
-e "{cpu/config=0x00000460A2,name=PM_L3_LAT_CI_HIT__r00000460A2/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_4 L3 castout
perf stat $perfflags \
-e "{cpu/config=0x0000010000,name=PM_SUSPENDED__r0000010000/}$mstr" \
-e "{cpu/config=0x00000268A2,name=PM_L3_CI_MISS__r00000268A2/}$mstr" \
-e "{cpu/config=0x00000368A2,name=PM_L3_L2_CO_MISS__r00000368A2/}$mstr" \
-e "{cpu/config=0x00000468A2,name=PM_L3_LAT_CI_MISS__r00000468A2/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_5 L3 load store
perf stat $perfflags \
-e "{cpu/config=0x00000160A4,name=PM_L3_HIT__r00000160A4/}$mstr" \
-e "{cpu/config=0x00000260A4,name=PM_L3_LD_HIT__r00000260A4/}$mstr" \
-e "{cpu/config=0x00000360A4,name=PM_L3_CO_LCO__r00000360A4/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_6 L3 load store
perf stat $perfflags \
-e "{cpu/config=0x00000168A4,name=PM_L3_MISS__r00000168A4/}$mstr" \
-e "{cpu/config=0x00000268A4,name=PM_L3_LD_MISS__r00000268A4/}$mstr" \
-e "{cpu/config=0x00000368A4,name=PM_L3_CINJ__r00000368A4/}$mstr" \
-e "{cpu/config=0x00000468A4,name=PM_L3_TRANS_PF__r00000468A4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_7 L3 TM
perf stat $perfflags \
-e "{cpu/config=0x00000160A6,name=PM_TM_SC_CO__r00000160A6/}$mstr" \
-e "{cpu/config=0x00000260A6,name=PM_NON_TM_RST_SC__r00000260A6/}$mstr" \
-e "{cpu/config=0x00000360A6,name=PM_SNP_TM_HIT_M__r00000360A6/}$mstr" \
-e "{cpu/config=0x00000460A6,name=PM_RD_FORMING_SC__r00000460A6/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_8 L3 TM
perf stat $perfflags \
-e "{cpu/config=0x00000168A6,name=PM_TM_CAM_OVERFLOW__r00000168A6/}$mstr" \
-e "{cpu/config=0x00000268A6,name=PM_TM_RST_SC__r00000268A6/}$mstr" \
-e "{cpu/config=0x00000368A6,name=PM_SNP_TM_HIT_T__r00000368A6/}$mstr" \
-e "{cpu/config=0x00000468A6,name=PM_RD_CLEARING_SC__r00000468A6/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_9 L3 prefetch
perf stat $perfflags \
-e "{cpu/config=0x0000010000,name=PM_SUSPENDED__r0000010000/}$mstr" \
-e "{cpu/config=0x00000260A8,name=PM_L3_PF_HIT_L3__r00000260A8/}$mstr" \
-e "{cpu/config=0x00000360A8,name=PM_L3_CO__r00000360A8/}$mstr" \
-e "{cpu/config=0x00000460A8,name=PM_SN_HIT__r00000460A8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_10 L3 machine usage
perf stat $perfflags \
-e "{cpu/config=0x00000168A8,name=PM_L3_WI_USAGE__r00000168A8/}$mstr" \
-e "{cpu/config=0x00000268A8,name=PM_RD_HIT_PF__r00000268A8/}$mstr" \
-e "{cpu/config=0x00000368A8,name=PM_SN_INVL__r00000368A8/}$mstr" \
-e "{cpu/config=0x00000468A8,name=PM_SN_MISS__r00000468A8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_11 L3 castout
perf stat $perfflags \
-e "{cpu/config=0x00000160AA,name=PM_L3_P0_LCO_NO_DATA__r00000160AA/}$mstr" \
-e "{cpu/config=0x00000260AA,name=PM_L3_P0_LCO_DATA__r00000260AA/}$mstr" \
-e "{cpu/config=0x00000360AA,name=PM_L3_P0_CO_MEM__r00000360AA/}$mstr" \
-e "{cpu/config=0x00000460AA,name=PM_L3_P0_CO_L31__r00000460AA/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_12 L3 casout
perf stat $perfflags \
-e "{cpu/config=0x00000168AA,name=PM_L3_P1_LCO_NO_DATA__r00000168AA/}$mstr" \
-e "{cpu/config=0x00000268AA,name=PM_L3_P1_LCO_DATA__r00000268AA/}$mstr" \
-e "{cpu/config=0x00000368AA,name=PM_L3_P1_CO_MEM__r00000368AA/}$mstr" \
-e "{cpu/config=0x00000468AA,name=PM_L3_P1_CO_L31__r00000468AA/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_13 L3 snoop busy
perf stat $perfflags \
-e "{cpu/config=0x00000160AC,name=PM_L3_SN_USAGE__r00000160AC/}$mstr" \
-e "{cpu/config=0x00000260AC,name=PM_L3_PF_USAGE__r00000260AC/}$mstr" \
-e "{cpu/config=0x00000360AC,name=PM_L3_SN0_BUSY__r00000360AC/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_14 L3 CO machine busy
perf stat $perfflags \
-e "{cpu/config=0x00000168AC,name=PM_L3_CI_USAGE__r00000168AC/}$mstr" \
-e "{cpu/config=0x00000268AC,name=PM_L3_RD_USAGE__r00000268AC/}$mstr" \
-e "{cpu/config=0x00000368AC,name=PM_L3_CO0_BUSY__r00000368AC/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_15 L3 retries
perf stat $perfflags \
-e "{cpu/config=0x00000160AE,name=PM_L3_P0_PF_RTY__r00000160AE/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x00000360AE,name=PM_L3_P0_CO_RTY__r00000360AE/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_16 L3 retries
perf stat $perfflags \
-e "{cpu/config=0x00000168AE,name=PM_L3_P1_PF_RTY__r00000168AE/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x00000368AE,name=PM_L3_P1_CO_RTY__r00000368AE/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_17 L3 pumps
perf stat $perfflags \
-e "{cpu/config=0x00000160B0,name=PM_L3_P0_NODE_PUMP__r00000160B0/}$mstr" \
-e "{cpu/config=0x00000260B0,name=PM_L3_P0_GRP_PUMP__r00000260B0/}$mstr" \
-e "{cpu/config=0x00000360B0,name=PM_L3_P0_SYS_PUMP__r00000360B0/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_18 L3 pumps
perf stat $perfflags \
-e "{cpu/config=0x00000168B0,name=PM_L3_P1_NODE_PUMP__r00000168B0/}$mstr" \
-e "{cpu/config=0x00000268B0,name=PM_L3_P1_GRP_PUMP__r00000268B0/}$mstr" \
-e "{cpu/config=0x00000368B0,name=PM_L3_P1_SYS_PUMP__r00000368B0/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_19 L3 pumps
perf stat $perfflags \
-e "{cpu/config=0x00000160B2,name=PM_L3_LOC_GUESS_CORRECT__r00000160B2/}$mstr" \
-e "{cpu/config=0x00000260B2,name=PM_L3_SYS_GUESS_CORRECT__r00000260B2/}$mstr" \
-e "{cpu/config=0x00000360B2,name=PM_L3_GRP_GUESS_WRONG_LOW__r00000360B2/}$mstr" \
-e "{cpu/config=0x00000460B2,name=PM_L3_SYS_GUESS_WRONG__r00000460B2/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_20 L3 pumps
perf stat $perfflags \
-e "{cpu/config=0x00000168B2,name=PM_L3_GRP_GUESS_CORRECT__r00000168B2/}$mstr" \
-e "{cpu/config=0x00000268B2,name=PM_L3_LOC_GUESS_WRONG__r00000268B2/}$mstr" \
-e "{cpu/config=0x00000368B2,name=PM_L3_GRP_GUESS_WRONG_HIGH__r00000368B2/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_21 L3 machine busy
perf stat $perfflags \
-e "{cpu/config=0x00000160B4,name=PM_L3_P0_LCO_RTY__r00000160B4/}$mstr" \
-e "{cpu/config=0x00000260B4,name=PM_L3_P2_LCO_RTY__r00000260B4/}$mstr" \
-e "{cpu/config=0x00000360B4,name=PM_L3_PF0_BUSY__r00000360B4/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l3_22 L3 machine busy
perf stat $perfflags \
-e "{cpu/config=0x00000168B4,name=PM_L3_P1_LCO_RTY__r00000168B4/}$mstr" \
-e "{cpu/config=0x00000268B4,name=PM_L3_P3_LCO_RTY__r00000268B4/}$mstr" \
-e "{cpu/config=0x00000368B4,name=PM_L3_RD0_BUSY__r00000368B4/}$mstr" \
-e "{cpu/config=0x000004001E,name=PM_CYC__r000004001E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_1 L2 loads
perf stat $perfflags \
-e "{cpu/config=0x0000016080,name=PM_L2_LD__r0000016080/}$mstr" \
-e "{cpu/config=0x0000026080,name=PM_L2_LD_MISS__r0000026080/}$mstr" \
-e "{cpu/config=0x0000036080,name=PM_L2_INST__r0000036080/}$mstr" \
-e "{cpu/config=0x0000046080,name=PM_L2_DISP_ALL_L2MISS__r0000046080/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_2 L2 instructions
perf stat $perfflags \
-e "{cpu/config=0x0000016880,name=PM_L2_ST__r0000016880/}$mstr" \
-e "{cpu/config=0x0000026880,name=PM_L2_ST_MISS__r0000026880/}$mstr" \
-e "{cpu/config=0x0000036880,name=PM_L2_INST_MISS__r0000036880/}$mstr" \
-e "{cpu/config=0x0000046880,name=PM_ISIDE_MRU_TOUCH__r0000046880/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_3 L2 load stores
perf stat $perfflags \
-e "{cpu/config=0x0000016082,name=PM_L2_CASTOUT_MOD__r0000016082/}$mstr" \
-e "{cpu/config=0x0000026082,name=PM_L2_IC_INV__r0000026082/}$mstr" \
-e "{cpu/config=0x0000036082,name=PM_L2_LD_DISP__r0000036082/}$mstr" \
-e "{cpu/config=0x0000046082,name=PM_L2_ST_DISP__r0000046082/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_4 L2 load stores
perf stat $perfflags \
-e "{cpu/config=0x0000016882,name=PM_L2_CASTOUT_SHR__r0000016882/}$mstr" \
-e "{cpu/config=0x0000026882,name=PM_L2_DC_INV__r0000026882/}$mstr" \
-e "{cpu/config=0x0000036882,name=PM_L2_LD_HIT__r0000036882/}$mstr" \
-e "{cpu/config=0x0000046882,name=PM_L2_ST_HIT__r0000046882/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_5 L2 internal stats
perf stat $perfflags \
-e "{cpu/config=0x0000016084,name=PM_L2_RCLD_DISP__r0000016084/}$mstr" \
-e "{cpu/config=0x0000026084,name=PM_L2_RCLD_DISP_FAIL_OTHER__r0000026084/}$mstr" \
-e "{cpu/config=0x0000036084,name=PM_L2_RCST_DISP__r0000036084/}$mstr" \
-e "{cpu/config=0x0000046084,name=PM_L2_RCST_DISP_FAIL_OTHER__r0000046084/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_6 L2 internal stats
perf stat $perfflags \
-e "{cpu/config=0x0000016884,name=PM_L2_RCLD_DISP_FAIL_ADDR__r0000016884/}$mstr" \
-e "{cpu/config=0x0000026884,name=PM_DSIDE_MRU_TOUCH__r0000026884/}$mstr" \
-e "{cpu/config=0x0000036884,name=PM_L2_RCST_DISP_FAIL_ADDR__r0000036884/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_7 L2 internal stats
perf stat $perfflags \
-e "{cpu/config=0x0000016086,name=PM_L2_SN_M_WR_DONE__r0000016086/}$mstr" \
-e "{cpu/config=0x0000026086,name=PM_CO_TM_SC_FOOTPRINT__r0000026086/}$mstr" \
-e "{cpu/config=0x0000036086,name=PM_L2_RC_ST_DONE__r0000036086/}$mstr" \
-e "{cpu/config=0x0000046086,name=PM_L2_SN_M_RD_DONE__r0000046086/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_8 L2 internal stats
perf stat $perfflags \
-e "{cpu/config=0x0000016886,name=PM_CO_DISP_FAIL__r0000016886/}$mstr" \
-e "{cpu/config=0x0000020000,name=PM_SUSPENDED__r0000020000/}$mstr" \
-e "{cpu/config=0x0000036886,name=PM_L2_SN_SX_I_DONE__r0000036886/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_9 L2 pumps
perf stat $perfflags \
-e "{cpu/config=0x0000016088,name=PM_L2_LOC_GUESS_CORRECT__r0000016088/}$mstr" \
-e "{cpu/config=0x0000026088,name=PM_L2_GRP_GUESS_CORRECT__r0000026088/}$mstr" \
-e "{cpu/config=0x0000036088,name=PM_L2_SYS_GUESS_CORRECT__r0000036088/}$mstr" \
-e "{cpu/config=0x0000046088,name=PM_L2_CHIP_PUMP__r0000046088/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_10 L2 pumps
perf stat $perfflags \
-e "{cpu/config=0x0000016888,name=PM_L2_LOC_GUESS_WRONG__r0000016888/}$mstr" \
-e "{cpu/config=0x0000026888,name=PM_L2_GRP_GUESS_WRONG__r0000026888/}$mstr" \
-e "{cpu/config=0x0000036888,name=PM_L2_SYS_GUESS_WRONG__r0000036888/}$mstr" \
-e "{cpu/config=0x0000046888,name=PM_L2_GROUP_PUMP__r0000046888/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_11 L2 retries
perf stat $perfflags \
-e "{cpu/config=0x0000010000,name=PM_SUSPENDED__r0000010000/}$mstr" \
-e "{cpu/config=0x000002608A,name=PM_ISIDE_DISP_FAIL_ADDR__r000002608A/}$mstr" \
-e "{cpu/config=0x000003608A,name=PM_L2_RTY_ST__r000003608A/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_12 L2 retries
perf stat $perfflags \
-e "{cpu/config=0x000001688A,name=PM_ISIDE_DISP__r000001688A/}$mstr" \
-e "{cpu/config=0x000002688A,name=PM_ISIDE_DISP_FAIL_OTHER__r000002688A/}$mstr" \
-e "{cpu/config=0x000003688A,name=PM_L2_RTY_LD__r000003688A/}$mstr" \
-e "{cpu/config=0x000004688A,name=PM_L2_SYS_PUMP__r000004688A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_13 L2 TM
perf stat $perfflags \
-e "{cpu/config=0x000001608E,name=PM_ST_CAUSED_FAIL__r000001608E/}$mstr" \
-e "{cpu/config=0x000002608E,name=PM_TM_LD_CONF__r000002608E/}$mstr" \
-e "{cpu/config=0x000003608E,name=PM_TM_ST_CONF__r000003608E/}$mstr" \
-e "{cpu/config=0x000004608E,name=PM_TM_CAP_OVERFLOW__r000004608E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_14 L2 TM
perf stat $perfflags \
-e "{cpu/config=0x000001688E,name=PM_TM_LD_CAUSED_FAIL__r000001688E/}$mstr" \
-e "{cpu/config=0x000002688E,name=PM_TM_FAV_CAUSED_FAIL__r000002688E/}$mstr" \
-e "{cpu/config=0x000003688E,name=PM_TM_ST_CAUSED_FAIL__r000003688E/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_15 L2 RC and CO machine busy
perf stat $perfflags \
-e "{cpu/config=0x000001608C,name=PM_RC0_BUSY__r000001608C/}$mstr" \
-e "{cpu/config=0x0000020000,name=PM_SUSPENDED__r0000020000/}$mstr" \
-e "{cpu/config=0x000003608C,name=PM_CO0_BUSY__r000003608C/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_16 L2 RC and CO machine busy
perf stat $perfflags \
-e "{cpu/config=0x000001688C,name=PM_RC_USAGE__r000001688C/}$mstr" \
-e "{cpu/config=0x000002688C,name=PM_CO_USAGE__r000002688C/}$mstr" \
-e "{cpu/config=0x000003688C,name=PM_SN_USAGE__r000003688C/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_17 L2 RC and CO machine busy
perf stat $perfflags \
-e "{cpu/config=0x0000016090,name=PM_SN0_BUSY__r0000016090/}$mstr" \
-e "{cpu/config=0x0000020000,name=PM_SUSPENDED__r0000020000/}$mstr" \
-e "{cpu/config=0x0000030000,name=PM_SUSPENDED__r0000030000/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_l2_18 L2 internal stats
perf stat $perfflags \
-e "{cpu/config=0x0000016890,name=PM_L1PF_L2MEMACC__r0000016890/}$mstr" \
-e "{cpu/config=0x0000026890,name=PM_ISIDE_L2MEMACC__r0000026890/}$mstr" \
-e "{cpu/config=0x0000030000,name=PM_SUSPENDED__r0000030000/}$mstr" \
-e "{cpu/config=0x0000040000,name=PM_SUSPENDED__r0000040000/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_1 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000001F056,name=PM_RADIX_PWC_L1_HIT__r000001F056/}$mstr" \
-e "{cpu/config=0x000002D024,name=PM_RADIX_PWC_L2_HIT__r000002D024/}$mstr" \
-e "{cpu/config=0x000003F056,name=PM_RADIX_PWC_L3_HIT__r000003F056/}$mstr" \
-e "{cpu/config=0x000004F054,name=PM_RADIX_PWC_MISS__r000004F054/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_2 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000001F058,name=PM_RADIX_PWC_L2_PTE_FROM_L2__r000001F058/}$mstr" \
-e "{cpu/config=0x000002D026,name=PM_RADIX_PWC_L1_PDE_FROM_L2__r000002D026/}$mstr" \
-e "{cpu/config=0x000003F054,name=PM_RADIX_PWC_L4_PTE_FROM_L3MISS__r000003F054/}$mstr" \
-e "{cpu/config=0x000004F056,name=PM_RADIX_PWC_L1_PDE_FROM_L3MISS__r000004F056/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_3 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000001F05A,name=PM_RADIX_PWC_L4_PTE_FROM_L2__r000001F05A/}$mstr" \
-e "{cpu/config=0x000002D028,name=PM_RADIX_PWC_L2_PDE_FROM_L2__r000002D028/}$mstr" \
-e "{cpu/config=0x000003F058,name=PM_RADIX_PWC_L1_PDE_FROM_L3__r000003F058/}$mstr" \
-e "{cpu/config=0x000004F058,name=PM_RADIX_PWC_L2_PTE_FROM_L3__r000004F058/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_4 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000001F15C,name=PM_RADIX_PWC_L3_PDE_FROM_L3__r000001F15C/}$mstr" \
-e "{cpu/config=0x000002D02A,name=PM_RADIX_PWC_L3_PDE_FROM_L2__r000002D02A/}$mstr" \
-e "{cpu/config=0x000003F05A,name=PM_RADIX_PWC_L2_PDE_FROM_L3__r000003F05A/}$mstr" \
-e "{cpu/config=0x000004F05A,name=PM_RADIX_PWC_L4_PTE_FROM_L3__r000004F05A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_5 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000000F098,name=PM_XLATE_HPT_MODE__r000000F098/}$mstr" \
-e "{cpu/config=0x000000F898,name=PM_XLATE_RADIX_MODE__r000000F898/}$mstr" \
-e "{cpu/config=0x0000010000,name=PM_SUSPENDED__r0000010000/}$mstr" \
-e "{cpu/config=0x000004F05C,name=PM_RADIX_PWC_L2_PTE_FROM_L3MISS__r000004F05C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_radix_6 Radix page table stats
perf stat $perfflags \
-e "{cpu/config=0x000000F898,name=PM_XLATE_RADIX_MODE__r000000F898/}$mstr" \
-e "{cpu/config=0x000002D02E,name=PM_RADIX_PWC_L3_PTE_FROM_L2__r000002D02E/}$mstr" \
-e "{cpu/config=0x000003F05E,name=PM_RADIX_PWC_L3_PTE_FROM_L3__r000003F05E/}$mstr" \
-e "{cpu/config=0x000004F05E,name=PM_RADIX_PWC_L3_PTE_FROM_L3MISS__r000004F05E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_erat_1 Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000000E08C,name=PM_LSU0_ERAT_HIT__r000000E08C/}$mstr" \
-e "{cpu/config=0x000000E88C,name=PM_LSU1_ERAT_HIT__r000000E88C/}$mstr" \
-e "{cpu/config=0x000000E090,name=PM_LSU2_ERAT_HIT__r000000E090/}$mstr" \
-e "{cpu/config=0x000000E890,name=PM_LSU3_ERAT_HIT__r000000E890/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tbl_walk Page table walk
perf stat $perfflags \
-e "{cpu/config=0x0000010026,name=PM_TABLEWALK_CYC__r0000010026/}$mstr" \
-e "{cpu/config=0x000000E0BC,name=PM_LS0_PTE_TABLEWALK_CYC__r000000E0BC/}$mstr" \
-e "{cpu/config=0x000000E8BC,name=PM_LS1_PTE_TABLEWALK_CYC__r000000E8BC/}$mstr" \
-e "{cpu/config=0x000000F09C,name=PM_SLB_TABLEWALK_CYC__r000000F09C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_erat_2 Address tanslation
perf stat $perfflags \
-e "{cpu/config=0x000001C05A,name=PM_DERAT_MISS_2M__r000001C05A/}$mstr" \
-e "{cpu/config=0x0000020064,name=PM_IERAT_RELOAD_4K__r0000020064/}$mstr" \
-e "{cpu/config=0x000003006A,name=PM_IERAT_RELOAD_64K__r000003006A/}$mstr" \
-e "{cpu/config=0x000004C05A,name=PM_DTLB_MISS_1G__r000004C05A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_erat_3 Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000001C05C,name=PM_DTLB_MISS_2M__r000001C05C/}$mstr" \
-e "{cpu/config=0x000002C054,name=PM_DERAT_MISS_64K__r000002C054/}$mstr" \
-e "{cpu/config=0x000000589C,name=PM_PTESYNC__r000000589C/}$mstr" \
-e "{cpu/config=0x000004006A,name=PM_IERAT_RELOAD_16M__r000004006A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_erat_4 Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x00000100F6,name=PM_IERAT_RELOAD__r00000100F6/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_slb Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x0000010016,name=PM_DSLB_MISS__r0000010016/}$mstr" \
-e "{cpu/config=0x0000040006,name=PM_ISLB_MISS__r0000040006/}$mstr" \
-e "{cpu/config=0x000000F89C,name=PM_XLATE_MISS__r000000F89C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_dtlb Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000001C058,name=PM_DTLB_MISS_16G__r000001C058/}$mstr" \
-e "{cpu/config=0x000002C05A,name=PM_DERAT_MISS_1G__r000002C05A/}$mstr" \
-e "{cpu/config=0x000003C056,name=PM_DTLB_MISS_64K__r000003C056/}$mstr" \
-e "{cpu/config=0x000004C056,name=PM_DTLB_MISS_16M__r000004C056/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tlb_1 Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000001F054,name=PM_TLB_HIT__r000001F054/}$mstr" \
-e "{cpu/config=0x0000020066,name=PM_TLB_MISS__r0000020066/}$mstr" \
-e "{cpu/config=0x0000030058,name=PM_TLBIE_FIN__r0000030058/}$mstr" \
-e "{cpu/config=0x00000400FC,name=PM_ITLB_MISS__r00000400FC/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_derat Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000001C056,name=PM_DERAT_MISS_4K__r000001C056/}$mstr" \
-e "{cpu/config=0x000002C056,name=PM_DTLB_MISS_4K__r000002C056/}$mstr" \
-e "{cpu/config=0x000003C054,name=PM_DERAT_MISS_16M__r000003C054/}$mstr" \
-e "{cpu/config=0x000004C054,name=PM_DERAT_MISS_16G__r000004C054/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tlb_2 Address Tanslation
perf stat $perfflags \
-e "{cpu/config=0x000000F880,name=PM_SNOOP_TLBIE__r000000F880/}$mstr" \
-e "{cpu/config=0x000000F884,name=PM_TABLEWALK_CYC_PREF__r000000F884/}$mstr" \
-e "{cpu/config=0x00000300FC,name=PM_DTLB_MISS__r00000300FC/}$mstr" \
-e "{cpu/config=0x00000050A8,name=PM_EAT_FORCE_MISPRED__r00000050A8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_1 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x000001515C,name=PM_SYNC_MRK_BR_MPRED__r000001515C/}$mstr" \
-e "{cpu/config=0x00000040AC,name=PM_BR_MPRED_CCACHE__r00000040AC/}$mstr" \
-e "{cpu/config=0x00000048AC,name=PM_BR_MPRED_LSTACK__r00000048AC/}$mstr" \
-e "{cpu/config=0x00000040B0,name=PM_BR_PRED_TAKEN_CR__r00000040B0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_2 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x00000048B0,name=PM_BR_MPRED_PCACHE__r00000048B0/}$mstr" \
-e "{cpu/config=0x00000200FA,name=PM_BR_TAKEN_CMPL__r00000200FA/}$mstr" \
-e "{cpu/config=0x00000040B4,name=PM_BR_PRED_TA__r00000040B4/}$mstr" \
-e "{cpu/config=0x00000040B8,name=PM_BR_MPRED_TAKEN_CR__r00000040B8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_3 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x000000409C,name=PM_BR_PRED__r000000409C/}$mstr" \
-e "{cpu/config=0x000002505E,name=PM_BACK_BR_CMPL__r000002505E/}$mstr" \
-e "{cpu/config=0x00000040A0,name=PM_BR_UNCOND__r00000040A0/}$mstr" \
-e "{cpu/config=0x000000489C,name=PM_BR_CORECT_PRED_TAKEN_CMPL__r000000489C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_4 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x00000048A0,name=PM_BR_PRED_PCACHE__r00000048A0/}$mstr" \
-e "{cpu/config=0x00000040A4,name=PM_BR_PRED_CCACHE__r00000040A4/}$mstr" \
-e "{cpu/config=0x00000040A8,name=PM_BR_PRED_LSTACK__r00000040A8/}$mstr" \
-e "{cpu/config=0x0000020036,name=PM_BR_2PATH__r0000020036/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_5 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x00000048B8,name=PM_BR_MPRED_TAKEN_TA__r00000048B8/}$mstr" \
-e "{cpu/config=0x0000020056,name=PM_TAKEN_BR_MPRED_CMPL__r0000020056/}$mstr" \
-e "{cpu/config=0x00000058A0,name=PM_LINK_STACK_CORRECT__r00000058A0/}$mstr" \
-e "{cpu/config=0x00000400F6,name=PM_BR_MPRED_CMPL__r00000400F6/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_6 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x00000050B0,name=PM_BTAC_BAD_RESULT__r00000050B0/}$mstr" \
-e "{cpu/config=0x00000058B0,name=PM_BTAC_GOOD_RESULT__r00000058B0/}$mstr" \
-e "{cpu/config=0x00000050B4,name=PM_TAGE_CORRECT_TAKEN_CMPL__r00000050B4/}$mstr" \
-e "{cpu/config=0x00000058B4,name=PM_TAGE_CORRECT__r00000058B4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_br_7 Branch prediction
perf stat $perfflags \
-e "{cpu/config=0x00000050B8,name=PM_TAGE_OVERRIDE_WRONG__r00000050B8/}$mstr" \
-e "{cpu/config=0x00000058B8,name=PM_TAGE_OVERRIDE_WRONG_SPEC__r00000058B8/}$mstr" \
-e "{cpu/config=0x0000005098,name=PM_LINK_STACK_WRONG_ADD_PRED__r0000005098/}$mstr" \
-e "{cpu/config=0x0000005898,name=PM_LINK_STACK_INVALID_PTR__r0000005898/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_disp Dispatch held
perf stat $perfflags \
-e "{cpu/config=0x00000028B0,name=PM_DISP_HELD_TBEGIN__r00000028B0/}$mstr" \
-e "{cpu/config=0x000000208C,name=PM_CLB_HELD__r000000208C/}$mstr" \
-e "{cpu/config=0x0000030008,name=PM_DISP_STARVED__r0000030008/}$mstr" \
-e "{cpu/config=0x000000288C,name=PM_DISP_CLB_HELD_BAL__r000000288C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_1 TM group
perf stat $perfflags \
-e "{cpu/config=0x0000002090,name=PM_DISP_CLB_HELD_SB__r0000002090/}$mstr" \
-e "{cpu/config=0x0000002890,name=PM_DISP_CLB_HELD_TLBIE__r0000002890/}$mstr" \
-e "{cpu/config=0x0000002094,name=PM_TM_OUTER_TBEGIN__r0000002094/}$mstr" \
-e "{cpu/config=0x0000002894,name=PM_TM_OUTER_TEND__r0000002894/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_ TM group
perf stat $perfflags \
-e "{cpu/config=0x0000002098,name=PM_TM_NESTED_TEND__r0000002098/}$mstr" \
-e "{cpu/config=0x0000002898,name=PM_TM_TABORT_TRECLAIM__r0000002898/}$mstr" \
-e "{cpu/config=0x000000209C,name=PM_TM_FAV_TBEGIN__r000000209C/}$mstr" \
-e "{cpu/config=0x000000289C,name=PM_TM_NON_FAV_TBEGIN__r000000289C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_3 TM group
perf stat $perfflags \
-e "{cpu/config=0x00000020A0,name=PM_TM_NESTED_TBEGIN__r00000020A0/}$mstr" \
-e "{cpu/config=0x00000028A0,name=PM_TM_TSUSPEND__r00000028A0/}$mstr" \
-e "{cpu/config=0x00000020A4,name=PM_TM_TRESUME__r00000020A4/}$mstr" \
-e "{cpu/config=0x00000020A8,name=PM_TM_FAIL_FOOTPRINT_OVERFLOW__r00000020A8/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_4 TM group
perf stat $perfflags \
-e "{cpu/config=0x00000028A8,name=PM_TM_FAIL_CONF_NON_TM__r00000028A8/}$mstr" \
-e "{cpu/config=0x00000020AC,name=PM_TM_FAIL_CONF_TM__r00000020AC/}$mstr" \
-e "{cpu/config=0x00000028AC,name=PM_TM_FAIL_SELF__r00000028AC/}$mstr" \
-e "{cpu/config=0x000004D05A,name=PM_NON_MATH_FLOP_CMPL__r000004D05A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_5 TM group
perf stat $perfflags \
-e "{cpu/config=0x000000E0A4,name=PM_TMA_REQ_L2__r000000E0A4/}$mstr" \
-e "{cpu/config=0x000000E0AC,name=PM_TM_FAIL_TLBIE__r000000E0AC/}$mstr" \
-e "{cpu/config=0x000000E8AC,name=PM_TM_FAIL_TX_CONFLICT__r000000E8AC/}$mstr" \
-e "{cpu/config=0x000000E0B0,name=PM_TM_FAIL_NON_TX_CONFLICT__r000000E0B0/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_tm_6 TM group
perf stat $perfflags \
-e "{cpu/config=0x0000010060,name=PM_TM_TRANS_RUN_CYC__r0000010060/}$mstr" \
-e "{cpu/config=0x000002E012,name=PM_TM_TX_PASS_RUN_CYC__r000002E012/}$mstr" \
-e "{cpu/config=0x0000030060,name=PM_TM_TRANS_RUN_INST__r0000030060/}$mstr" \
-e "{cpu/config=0x000004E014,name=PM_TM_TX_PASS_RUN_INST__r000004E014/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_isu ISU hold
perf stat $perfflags \
-e "{cpu/config=0x0000003884,name=PM_ISU3_ISS_HOLD_ALL__r0000003884/}$mstr" \
-e "{cpu/config=0x0000003080,name=PM_ISU0_ISS_HOLD_ALL__r0000003080/}$mstr" \
-e "{cpu/config=0x0000003880,name=PM_ISU2_ISS_HOLD_ALL__r0000003880/}$mstr" \
-e "{cpu/config=0x0000003084,name=PM_ISU1_ISS_HOLD_ALL__r0000003084/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_dpref DC prefetch
perf stat $perfflags \
-e "{cpu/config=0x000000F8A8,name=PM_DC_PREF_FUZZY_CONF__r000000F8A8/}$mstr" \
-e "{cpu/config=0x000000F0B4,name=PM_DC_PREF_CONS_ALLOC__r000000F0B4/}$mstr" \
-e "{cpu/config=0x000000F8AC,name=PM_DC_DEALLOC_NO_CONF__r000000F8AC/}$mstr" \
-e "{cpu/config=0x000000F8B4,name=PM_DC_PREF_XCONS_ALLOC__r000000F8B4/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_thr_prio Thred priority
perf stat $perfflags \
-e "{cpu/config=0x0000005880,name=PM_THRD_PRIO_6_7_CYC__r0000005880/}$mstr" \
-e "{cpu/config=0x00000040BC,name=PM_THRD_PRIO_0_1_CYC__r00000040BC/}$mstr" \
-e "{cpu/config=0x00000048BC,name=PM_THRD_PRIO_2_3_CYC__r00000048BC/}$mstr" \
-e "{cpu/config=0x0000005080,name=PM_THRD_PRIO_4_5_CYC__r0000005080/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_decode_1 Decode and Fusion
perf stat $perfflags \
-e "{cpu/config=0x00000058A8,name=PM_DECODE_HOLD_ICT_FULL__r00000058A8/}$mstr" \
-e "{cpu/config=0x0000005084,name=PM_DECODE_FUSION_EXT_ADD__r0000005084/}$mstr" \
-e "{cpu/config=0x0000005884,name=PM_DECODE_LANES_NOT_AVAIL__r0000005884/}$mstr" \
-e "{cpu/config=0x0000005088,name=PM_DECODE_FUSION_OP_PRESERV__r0000005088/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_decode_2 Decode and Fusion
perf stat $perfflags \
-e "{cpu/config=0x00000048A4,name=PM_STOP_FETCH_PENDING_CYC__r00000048A4/}$mstr" \
-e "{cpu/config=0x00000048B4,name=PM_DECODE_FUSION_CONST_GEN__r00000048B4/}$mstr" \
-e "{cpu/config=0x00000048A8,name=PM_DECODE_FUSION_LD_ST_DISP__r00000048A8/}$mstr" \
-e "{cpu/config=0x0000004898,name=PM_IC_DEMAND_L2_BR_REDIRECT__r0000004898/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_icache Icache reloads
perf stat $perfflags \
-e "{cpu/config=0x0000005888,name=PM_IC_INVALIDATE__r0000005888/}$mstr" \
-e "{cpu/config=0x0000005094,name=PM_IC_MISS_ICBI__r0000005094/}$mstr" \
-e "{cpu/config=0x0000004894,name=PM_IC_RELOAD_PRIVATE__r0000004894/}$mstr" \
-e "{cpu/config=0x0000004098,name=PM_IC_DEMAND_L2_BHT_REDIRECT__r0000004098/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_reject_1 LSU rejects
perf stat $perfflags \
-e "{cpu/config=0x0000004880,name=PM_BANK_CONFLICT__r0000004880/}$mstr" \
-e "{cpu/config=0x000002E05C,name=PM_LSU_REJECT_ERAT_MISS__r000002E05C/}$mstr" \
-e "{cpu/config=0x000003001C,name=PM_LSU_REJECT_LMQ_FULL__r000003001C/}$mstr" \
-e "{cpu/config=0x000004E05C,name=PM_LSU_REJECT_LHS__r000004E05C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_reject_2 Store rejects
perf stat $perfflags \
-e "{cpu/config=0x0000004084,name=PM_EAT_FULL_CYC__r0000004084/}$mstr" \
-e "{cpu/config=0x000002E05A,name=PM_LRQ_REJECT__r000002E05A/}$mstr" \
-e "{cpu/config=0x0000030064,name=PM_DARQ_STORE_XMIT__r0000030064/}$mstr" \
-e "{cpu/config=0x000004405E,name=PM_DARQ_STORE_REJECT__r000004405E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_ibuff Icache buffer
perf stat $perfflags \
-e "{cpu/config=0x0000010018,name=PM_IC_DEMAND_CYC__r0000010018/}$mstr" \
-e "{cpu/config=0x0000004088,name=PM_IC_DEMAND_REQ__r0000004088/}$mstr" \
-e "{cpu/config=0x0000004884,name=PM_IBUF_FULL_CYC__r0000004884/}$mstr" \
-e "{cpu/config=0x000004001C,name=PM_INST_IMC_MATCH_CMPL__r000004001C/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mem Memory read write
perf stat $perfflags \
-e "{cpu/config=0x0000010056,name=PM_MEM_READ__r0000010056/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x000003C05E,name=PM_MEM_RWITM__r000003C05E/}$mstr" \
-e "{cpu/config=0x000004C058,name=PM_MEM_CO__r000004C058/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_ict ICT
perf stat $perfflags \
-e "{cpu/config=0x0000010028,name=PM_STALL_END_ICT_EMPTY__r0000010028/}$mstr" \
-e "{cpu/config=0x0000020008,name=PM_ICT_EMPTY_CYC__r0000020008/}$mstr" \
-e "{cpu/config=0x000003001A,name=PM_DATA_TABLEWALK_CYC__r000003001A/}$mstr" \
-e "{cpu/config=0x0000045058,name=PM_IC_MISS_CMPL__r0000045058/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_probe Probe nop
perf stat $perfflags \
-e "{cpu/config=0x0000010058,name=PM_MEM_LOC_THRESH_IFU__r0000010058/}$mstr" \
-e "{cpu/config=0x000002000A,name=PM_HV_CYC__r000002000A/}$mstr" \
-e "{cpu/config=0x000003405E,name=PM_IFETCH_THROTTLE__r000003405E/}$mstr" \
-e "{cpu/config=0x0000040014,name=PM_PROBE_NOP_DISP__r0000040014/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_mem Mem threshold
perf stat $perfflags \
-e "{cpu/config=0x000001C05E,name=PM_MEM_LOC_THRESH_LSU_MED__r000001C05E/}$mstr" \
-e "{cpu/config=0x000002001A,name=PM_NTC_ALL_FIN__r000002001A/}$mstr" \
-e "{cpu/config=0x000003006E,name=PM_NEST_REF_CLK__r000003006E/}$mstr" \
-e "{cpu/config=0x0000040056,name=PM_MEM_LOC_THRESH_LSU_HIGH__r0000040056/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_1 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000010050,name=PM_CHIP_PUMP_CPRED__r0000010050/}$mstr" \
-e "{cpu/config=0x0000020050,name=PM_GRP_PUMP_CPRED__r0000020050/}$mstr" \
-e "{cpu/config=0x0000030050,name=PM_SYS_PUMP_CPRED__r0000030050/}$mstr" \
-e "{cpu/config=0x0000040050,name=PM_SYS_PUMP_MPRED_RTY__r0000040050/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_2 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000010052,name=PM_GRP_PUMP_MPRED_RTY__r0000010052/}$mstr" \
-e "{cpu/config=0x0000020052,name=PM_GRP_PUMP_MPRED__r0000020052/}$mstr" \
-e "{cpu/config=0x0000030052,name=PM_SYS_PUMP_MPRED__r0000030052/}$mstr" \
-e "{cpu/config=0x0000040052,name=PM_PUMP_MPRED__r0000040052/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_3 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000010054,name=PM_PUMP_CPRED__r0000010054/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x0000045050,name=PM_1FLOP_CMPL__r0000045050/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_4 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x000001C050,name=PM_DATA_CHIP_PUMP_CPRED__r000001C050/}$mstr" \
-e "{cpu/config=0x000002C050,name=PM_DATA_GRP_PUMP_CPRED__r000002C050/}$mstr" \
-e "{cpu/config=0x000003C050,name=PM_DATA_SYS_PUMP_CPRED__r000003C050/}$mstr" \
-e "{cpu/config=0x000004C050,name=PM_DATA_SYS_PUMP_MPRED_RTY__r000004C050/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_5 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x000001C052,name=PM_DATA_GRP_PUMP_MPRED_RTY__r000001C052/}$mstr" \
-e "{cpu/config=0x000002C052,name=PM_DATA_GRP_PUMP_MPRED__r000002C052/}$mstr" \
-e "{cpu/config=0x000003C052,name=PM_DATA_SYS_PUMP_MPRED__r000003C052/}$mstr" \
-e "{cpu/config=0x000004C052,name=PM_DATA_PUMP_MPRED__r000004C052/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_6 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x000001C054,name=PM_DATA_PUMP_CPRED__r000001C054/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x000004D052,name=PM_2FLOP_CMPL__r000004D052/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_7 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000014050,name=PM_INST_CHIP_PUMP_CPRED__r0000014050/}$mstr" \
-e "{cpu/config=0x000002C05C,name=PM_INST_GRP_PUMP_CPRED__r000002C05C/}$mstr" \
-e "{cpu/config=0x0000034050,name=PM_INST_SYS_PUMP_CPRED__r0000034050/}$mstr" \
-e "{cpu/config=0x0000044050,name=PM_INST_SYS_PUMP_MPRED_RTY__r0000044050/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_8 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000014052,name=PM_INST_GRP_PUMP_MPRED_RTY__r0000014052/}$mstr" \
-e "{cpu/config=0x000002C05E,name=PM_INST_GRP_PUMP_MPRED__r000002C05E/}$mstr" \
-e "{cpu/config=0x0000034052,name=PM_INST_SYS_PUMP_MPRED__r0000034052/}$mstr" \
-e "{cpu/config=0x0000044052,name=PM_INST_PUMP_MPRED__r0000044052/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_pump_9 Bus pump events
perf stat $perfflags \
-e "{cpu/config=0x0000014054,name=PM_INST_PUMP_CPRED__r0000014054/}$mstr" \
-e "{cpu/config=0x000002001E,name=PM_CYC__r000002001E/}$mstr" \
-e "{cpu/config=0x000003001E,name=PM_CYC__r000003001E/}$mstr" \
-e "{cpu/config=0x0000045052,name=PM_4FLOP_CMPL__r0000045052/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_flop_1 Flop events
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x000002011C,name=PM_MRK_NTC_CYC__r000002011C/}$mstr" \
-e "{cpu/config=0x000003F14A,name=PM_MRK_DPTEG_FROM_RMEM__r000003F14A/}$mstr" \
-e "{cpu/config=0x000004D054,name=PM_8FLOP_CMPL__r000004D054/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_darq_2 DARQ events
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x0000020058,name=PM_DARQ1_10_12_ENTRIES__r0000020058/}$mstr" \
-e "{cpu/config=0x000003005A,name=PM_ISQ_0_8_ENTRIES__r000003005A/}$mstr" \
-e "{cpu/config=0x000004000A,name=PM_ISQ_36_44_ENTRIES__r000004000A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_darq_1 DARQ events
perf stat $perfflags \
-e "{cpu/config=0x0000010002,name=PM_INST_CMPL__r0000010002/}$mstr" \
-e "{cpu/config=0x000002005A,name=PM_DARQ1_7_9_ENTRIES__r000002005A/}$mstr" \
-e "{cpu/config=0x000003E050,name=PM_DARQ1_4_6_ENTRIES__r000003E050/}$mstr" \
-e "{cpu/config=0x000004C122,name=PM_DARQ1_0_3_ENTRIES__r000004C122/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource1 ASO data source 1
perf stat $perfflags \
-e "{cpu/config=0x000001D154,name=PM_MRK_DATA_FROM_L21_SHR_CYC__r000001D154/}$mstr" \
-e "{cpu/config=0x000002D144,name=PM_MRK_DATA_FROM_L31_MOD__r000002D144/}$mstr" \
-e "{cpu/config=0x000003D14C,name=PM_MRK_DATA_FROM_DMEM__r000003D14C/}$mstr" \
-e "{cpu/config=0x000004E11E,name=PM_MRK_DATA_FROM_DMEM_CYC__r000004E11E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource2 ASO data source 2
perf stat $perfflags \
-e "{cpu/config=0x000001D140,name=PM_MRK_DATA_FROM_L31_MOD_CYC__r000001D140/}$mstr" \
-e "{cpu/config=0x000002D14E,name=PM_MRK_DATA_FROM_L21_SHR__r000002D14E/}$mstr" \
-e "{cpu/config=0x000003D148,name=PM_MRK_DATA_FROM_L21_MOD_CYC__r000003D148/}$mstr" \
-e "{cpu/config=0x000004D146,name=PM_MRK_DATA_FROM_L21_MOD__r000004D146/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource3 ASO data source 3
perf stat $perfflags \
-e "{cpu/config=0x000001D14A,name=PM_MRK_DATA_FROM_RL2L3_MOD__r000001D14A/}$mstr" \
-e "{cpu/config=0x000002C128,name=PM_MRK_DATA_FROM_DL2L3_SHR_CYC__r000002C128/}$mstr" \
-e "{cpu/config=0x0000035150,name=PM_MRK_DATA_FROM_RL2L3_SHR__r0000035150/}$mstr" \
-e "{cpu/config=0x000004C12A,name=PM_MRK_DATA_FROM_RL2L3_SHR_CYC__r000004C12A/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource4 ASO data source 4
perf stat $perfflags \
-e "{cpu/config=0x000001D150,name=PM_MRK_DATA_FROM_DL2L3_SHR__r000001D150/}$mstr" \
-e "{cpu/config=0x000002D14A,name=PM_MRK_DATA_FROM_RL2L3_MOD_CYC__r000002D14A/}$mstr" \
-e "{cpu/config=0x000003C04A,name=PM_DATA_FROM_RMEM__r000003C04A/}$mstr" \
-e "{cpu/config=0x000004D142,name=PM_MRK_DATA_FROM_L3__r000004D142/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource5 ASO data source 5
perf stat $perfflags \
-e "{cpu/config=0x0000014156,name=PM_MRK_DATA_FROM_L2_CYC__r0000014156/}$mstr" \
-e "{cpu/config=0x000002C126,name=PM_MRK_DATA_FROM_L2__r000002C126/}$mstr" \
-e "{cpu/config=0x0000035156,name=PM_MRK_DATA_FROM_L31_SHR_CYC__r0000035156/}$mstr" \
-e "{cpu/config=0x000004D124,name=PM_MRK_DATA_FROM_L31_SHR__r000004D124/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource6 ASO data source 6
perf stat $perfflags \
-e "{cpu/config=0x000001D148,name=PM_MRK_DATA_FROM_RMEM__r000001D148/}$mstr" \
-e "{cpu/config=0x000002C12A,name=PM_MRK_DATA_FROM_RMEM_CYC__r000002C12A/}$mstr" \
-e "{cpu/config=0x000003D14E,name=PM_MRK_DATA_FROM_DL2L3_MOD__r000003D14E/}$mstr" \
-e "{cpu/config=0x000004D12E,name=PM_MRK_DATA_FROM_DL2L3_MOD_CYC__r000004D12E/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource7 ASO data source 7
perf stat $perfflags \
-e "{cpu/config=0x000001D14A,name=PM_MRK_DATA_FROM_RL2L3_MOD__r000001D14A/}$mstr" \
-e "{cpu/config=0x000002C048,name=PM_DATA_FROM_LMEM__r000002C048/}$mstr" \
-e "{cpu/config=0x000003D142,name=PM_MRK_DATA_FROM_LMEM__r000003D142/}$mstr" \
-e "{cpu/config=0x000004D128,name=PM_MRK_DATA_FROM_LMEM_CYC__r000004D128/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
#-- pm_aso_dsource8 ASO data source 8
perf stat $perfflags \
-e "{cpu/config=0x000001D150,name=PM_MRK_DATA_FROM_DL2L3_SHR__r000001D150/}$mstr" \
-e "{cpu/config=0x000002D14A,name=PM_MRK_DATA_FROM_RL2L3_MOD_CYC__r000002D14A/}$mstr" \
-e "{cpu/config=0x0000035154,name=PM_MRK_DATA_FROM_L3_CYC__r0000035154/}$mstr" \
-e "{cpu/config=0x000004D142,name=PM_MRK_DATA_FROM_L3__r000004D142/}$mstr" \
-e "{cpu/config=0x600f4,name=PM_RUN_CYC__r600f4/}$dstr" \
-e "{cpu/config=0x500fA,name=PM_RUN_INST_CMPL__r500fA/}$dstr" \
$workload
if ((infinite==0)); then
  repeat=0
fi
#((repeat-=1))
done

