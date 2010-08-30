proc proc_bp_show_usage {} {
	echo "usage: sys bp show <file> <var_result>\n
	Where options are:
	\t file			: file with results
	\t var_result	: variable name to store results"
	abort all;	
}

#.main clear
# ------------ main ---------------- #
# convert macro arguments to list format
quietly set args [ split $1 {\ } ]
if { 2 != [llength $args] } { proc_bp_show_usage }

sys bp read [lindex $args 0 ] [lindex $args 1]
echo [ expr $[lindex $args 1]]
