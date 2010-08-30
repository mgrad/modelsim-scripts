if { [info exists xcmds] } {
	puts stderr "Error: simulation is currently running!\nUse: sys quit"
} else {
	echo " ----------------------------------------------------------------- "
	echo  Loading simulation
	echo " ----------------------------------------------------------------- "
	quietly vsim -quiet -t ps -L unisims_ver system_tb glbl; 
	quietly set xcmds 1
}
