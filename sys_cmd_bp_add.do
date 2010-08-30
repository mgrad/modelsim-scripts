proc proc_bp_add_usage {} {
	echo "usage: sys bp add <signal> <value>\n
	Where options are:
	\t <sig val>		 	: call breakpoint when signal will receive value"
	abort all;	
}


# ------------ main ---------------- #
# convert macro arguments to list format
quietly set args [ split $1 {\ } ]
if { 2 != [llength $args] } { proc_bp_add_usage }

echo "-- param input signal:    '[set sig  [ string trimleft [ lindex $args 0 ] {\ } ]]'"
echo "-- param input value:     '[set val  [ string trimleft [ lindex $args 1 ] {\ } ]]'"

when "$sig = 'h$val" {
	echo " ----------------------------------------------------------------- "
	echo Breakpoint occured at $now: $sig == $val
	echo " ----------------------------------------------------------------- "
	echo " -- saving results to '$BPfile'"

	# save results to file
	if { [file exists $BPfile] } { file delete "$BPfile"}
	set fid [ open $BPfile "w" ]
	puts -nonewline $fid [ list $now $sig $val ]
	close $fid

#	# stop after 40clk's
#	if {[ when -label stop_bp ] == "" } {
#		when -label stop_bp { $now = 200000 } {
#			nowhen stop_bp
#			stop
#		}
#	}
	resume
}

