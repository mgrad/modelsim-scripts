if { ![info exists xcmdw ] } {
	puts stderr "Error: Wave windows is not running!\nUse: sys wave run"
} else {
	sys bp show $BPfile line
	quietly set list [ split $line { } ]
	quietly set bp_time [ lindex $list 0 ]
	quietly wave addcursor -time ${bp_time}ps -name "Instruction: $ELFinstr"
	quietly wave seecursor
}
