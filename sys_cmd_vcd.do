# prepare vcd stimulus file for pcore

if { [ info exists xcmds ] } {
	puts stderr "Close simulation first!.\nUse: sys quit"
	abort all
}
	sys bp show $BPfile line
	quietly set list [ split $line { } ]
	quietly set bp_time [ lindex $list 0 ]

	do ../../data/vcd_filter.do $bp_time

