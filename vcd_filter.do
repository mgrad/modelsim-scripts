# usage: do vcd_filter.do bp_time delta_time
#    param1: bp_time = time when bp occoured
#    param2: delta = time used to setup section to export

echo " ----------------------------------------------------------------- "
echo "VCD filter"
echo " ----------------------------------------------------------------- "

if { ![info exists xmcdconf ] } {
	do ../../data/_config.do
}

if { [ info exists delta ] } { quietly unset delta }
if { [ info exists bp_time ] } { quietly unset bp_time }

# setup params from command line
if {$argc > 0} {
	quietly set bp_time $1
}
if {$argc > 1} {
		quietly set delta $2
}

# if not setup - use default values
if { ![info exists bp_time] } {
	if { [info exists bp_saved_time] } {
		quietly set bp_time $bp_saved_time
	} else {
		echo "Warning: can't find time when breakpoint occured"; 
		abort all
	}
}

if {![info exists delta] } {
	# setup default delta time for 100clk's
	quietly set clk_time 5000
	quietly set delta [expr 500 * $clk_time]
	quietly unset clk_time
}

quietly set sec_beg [expr $bp_time - $delta]
quietly set sec_end [expr $bp_time + $delta]

echo "-- exporting data between:\n * start: $sec_beg\n   ---->: $bp_time\n * end: $sec_end" 
exec xilperl.exe $VCDscript $sec_beg $sec_end < $VCDstim_sys_file > $VCDstim_pcore_file 


# cleaning out
unset sec_beg
unset sec_end
unset delta
unset bp_time
