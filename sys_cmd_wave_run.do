if { ![info exists xcmds] } {
	echo "Aborting : simulate command was not run"
	abort all
}


echo " ----------------------------------------------------------------- "
echo  "Setting up Wave window display ..."
echo " ----------------------------------------------------------------- "
quietly set xcmdw 1


#  Display clock
  eval add wave -noupdate $binopt ${pcore_path}${ps}clock


# Display PowerPC Internal Registers
# lmcwin - setting up smartmodels internals
if {$show_ppc_wave} {
  eval add wave -noupdate -divider {"PowerPC Internal Registers : ppc405_0"}
  quietly set ppc_path "$tbpath${ps}ppc405_0${ps}ppc405_0${ps}PPC405_ADV_i/ppc405_adv_swift_bw_1/ppc405_adv_swift_inst"
  eval lmcwin enable $ppc_path${ps}DCDADDR
  eval add wave -noupdate $hexopt $ppc_path${ps}DCDADDR
  eval lmcwin enable $ppc_path${ps}DCDDATA
  eval add wave -noupdate $hexopt $ppc_path${ps}DCDDATA
  eval lmcwin enable $ppc_path${ps}EXEFULL
  eval add wave -noupdate $hexopt $ppc_path${ps}EXEFULL
  eval lmcwin enable $ppc_path${ps}EXEADDR
  eval add wave -noupdate $hexopt $ppc_path${ps}EXEADDR
  eval lmcwin enable $ppc_path${ps}EXEAREG
  eval add wave -noupdate $hexopt $ppc_path${ps}EXEAREG
  eval lmcwin enable $ppc_path${ps}EXEBREG
  eval add wave -noupdate $hexopt $ppc_path${ps}EXEBREG
  eval lmcwin enable $ppc_path${ps}EXERESULT
  eval add wave -noupdate $hexopt $ppc_path${ps}EXERESULT
}

if {$show_ppc_reg_wave} {
  eval add wave -noupdate -divider {"PowerPC Standard Registers : ppc405_0"}
  eval lmcwin enable $ppc_path${ps}GPR0
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR0
  eval lmcwin enable $ppc_path${ps}GPR1
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR1
  eval lmcwin enable $ppc_path${ps}GPR1
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR1
  eval lmcwin enable $ppc_path${ps}GPR2
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR2
  eval lmcwin enable $ppc_path${ps}GPR3
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR3
  eval lmcwin enable $ppc_path${ps}GPR4
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR4
  eval lmcwin enable $ppc_path${ps}GPR5
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR5
  eval lmcwin enable $ppc_path${ps}GPR6
  eval add wave -noupdate $hexopt $ppc_path${ps}GPR6
}

eval add wave -noupdate -divider {"fcm inputs"}
# eval add wave -noupdate -in ${pcore_path}${ps}*
  eval add wave -noupdate $hexopt ${pcore_path}${ps}APUFCMINSTRUCTION
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMINSTRVALID
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMDECODED
  eval add wave -noupdate $hexopt ${pcore_path}${ps}APUFCMDECUDI
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMDECUDIVALID
  eval add wave -noupdate $hexopt ${pcore_path}${ps}APUFCMRADATA
  eval add wave -noupdate $hexopt ${pcore_path}${ps}APUFCMRBDATA
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMOPERANDVALID
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMFLUSH
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMWRITEBACKOK
  eval add wave -noupdate $hexopt ${pcore_path}${ps}APUFCMLOADDATA
  eval add wave -noupdate $binopt ${pcore_path}${ps}APUFCMLOADDVALID
# eval add wave -noupdate -in $hexopt ${pcore_path}${ps}*INSTR*
# eval add wave -noupdate -in $hexopt ${pcore_path}${ps}*DEC*
# eval add wave -noupdate -in $hexopt ${pcore_path}${ps}*OPERAND*
# eval add wave -noupdate -in $hexopt ${pcore_path}${ps}*FCMR*
# eval add wave -noupdate -in $hexopt ${pcore_path}${ps}*LOAD*



eval add wave -noupdate -divider {"fcm output"}
# eval add wave -noupdate -out ${pcore_path}${ps}*
  eval add wave -noupdate $hexopt ${pcore_path}${ps}FCMAPURESULT
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPURESULTVALID
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDONE
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPULOADWAIT
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUINSTRACK
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUSLEEPNOTREADY
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDECODEBUSY
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDGPRWRITE
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDRAEN
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDRBEN
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDLOAD
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDSTORE
  eval add wave -noupdate $binopt ${pcore_path}${ps}FCMAPUDCDUPDATE
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*DONE*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*RESULT*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*INSTR*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*BUSY*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*LOAD*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*STORE*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*UPDATE*
# eval add wave -noupdate -out $hexopt ${pcore_path}${ps}*SLEEP*


eval add wave -noupdate -divider {"fcm internals"}
# find signals -internal -recursive ${pcore_path}${ps}*
eval add wave -noupdate -internal ${pcore_path}${ps}*

#  Wave window configuration information
quietly configure  wave -justifyvalue          right
quietly configure  wave -signalnamewidth       1

quietly TreeUpdate [SetDefaultTree]

# property wave -radix hex regfile_wdata
# property wave -radix hex regfile_rdata

# last waveform settings
# quietly wave activecursor 
# quietly wave cursortime -time 1us
# quietly wave seecursor 1
# quietly wave zoomout 10
