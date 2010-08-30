if { ![info exists xmcdconf ] } {
	sys conf
}

if { [info exists xcmds] } {
	sys quit
}

# reinitialize FCM pcore
sys fcm

echo " ----------------------------------------------------------------- "
echo  Loading simulation
echo " ----------------------------------------------------------------- "
quietly vsim -quiet -vcdstim $VCDstim_pcore_file -t ps "$pcore.$pcore"; quietly set xcmds 1
#quietly vsim -quiet -vcdstim $VCDstim_sys_file -t ps "$pcore.$pcore"; quietly set xcmds 1


# setting up wave window
# sys wave run "$pcore" 1
sys wave path $pcore
sys wave ppc_off
sys wave run

sys bp show $BPfile line
quietly set list [ split $line { } ]
quietly set bp_time [ lindex $list 0 ]

wave zoomrange [expr $bp_time - 5000*10] [ expr $bp_time + 5000*10]
wave zoomout
wave zoomout

sys wave cursor
	
run -all
wave seecursor
