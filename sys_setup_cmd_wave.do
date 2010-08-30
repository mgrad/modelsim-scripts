proc proc_wave_usage {} {
	echo "usage: sys wave <command>\n
		Where command is one of:
		\t	run		: setups wave window
		\t refresh	: modifies wave window to current state
		\t ppc		: show setting
		\t ppc_on	: show ppc internal signals
		\t ppc_off	: hide ppc internal signals
		\t path <p>	: setup path from which read signals values
		\t path_def	: setup path to default value
		\t cursor	: show cursor with bp"
	abort all
}


# ------------ main ---------------- #
if { $argc == 0 } { proc_wave_usage }

# convert macro arguments to list format
quietly set args [ split $1 {\ } ]

# get command
quietly set cmd [string tolower [ string trimleft [ lindex $args 0] {\ } ] ]
quietly set args [lreplace $args 0 0];		# remove first element (cmd) from args

switch -exact $cmd {
	run	{ do ../../data/sys_cmd_wave_run.do $args }
	refresh	{ 
				if { ![info exists xcmdw ] } { delete wave * }
				sys wave run
			}
	ppc	{	
				set t "Block"; if {$show_ppc_wave} {set t "Show" }
				echo "$t ppc internals."
			}
	ppc_off  { quietly set show_ppc_wave 0 }
	ppc_on   { quietly set show_ppc_wave 1 }
	ppc_reg  { 
				set t "Block"; if {$show_ppc_reg_wave} {set t "Show" }
				echo "$t ppc registers."
	}
	ppc_reg_off { quietly set show_ppc_reg_wave 0 }
	ppc_reg_on { quietly set show_ppc_reg_wave 1 }
	path     {
					if { [string length $args] != 0} {
						quietly set pcore_path $args;
					}
					echo "pcore_path = $pcore_path" 
				}
	path_def { quietly set pcore_path "$tbpath${ps}${pcore}_0${ps}${pcore}_0" }
	cursor	{ do ../../data/sys_cmd_wave_cursor.do }
	default {proc_wave_usage}
}
