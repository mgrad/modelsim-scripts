proc proc_bp_read_usage {} {
	echo "usage: sys bp read <file> <var_result>\n
	Where options are:
	\t file			: file with debugging informations
	\t var_result	: variable name to store results"
	abort all;	
}


# ------------ main ---------------- #
# convert macro arguments to list format
quietly set args [ split $1 {\ } ]
if { 2 != [llength $args] } { proc_bp_read_usage }

# get parameters
echo "-- param input  filename: '[set file [ string trimleft [ lindex $args 0] {\ } ]]'" 
echo "-- param output var name: '\$[ set var_name [ string trimleft [ lindex $args 1] {\ } ]]'"

if {	[ catch {set fp [ open $file r ] } errno ] } {
		puts stderr "Error: $errno"
		abort all
}

if	{	[ catch {upvar 0 $var_name ${var_name}__ } errno ] } {
		puts stderr "Error: $errno"
		abort all
}

if {	[ catch { set ${var_name}__  [ read $fp ]  } errno ] } {
		puts stderr "Error: $errno"
		abort all
}

if {	[ catch { close $fp } errno ] } {
		puts stderr "Error: $errno"
		abort all
}

# unset fp
