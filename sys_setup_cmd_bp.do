proc proc_bp_usage {} {
	echo "usage: sys bp <command>\n
	Where command is:
	\t read 		: reads debug from file to variable
	\t find 		: search for value in debug
	\t add  		: adds new breakpoint
	\t del		: deletes last setup breakpoint
	\t show		: show time of last occoured breakpoint"
	abort all;	
}

# ------------ main ---------------- #
if { $argc == 0 } { proc_bp_usage }

# convert macro arguments to list format
quietly set args [ split $1 {\ } ]

# get command
quietly set cmd [string tolower [ string trimleft [ lindex $args 0] {\ } ] ]
quietly set args [lreplace $args 0 0];		# remove first element (cmd) from args

switch -exact $cmd {
	add   { do ../../data/sys_cmd_bp_add.do $args}
	read  { do ../../data/sys_cmd_bp_read.do $args }
	find  { do ../../data/sys_setup_cmd_bp_find.do $args }
	del   { do ../../data/sys_cmd_bp_del.do $args  }
	show  { do ../../data/sys_cmd_bp_show.do $args }
	default { proc_bp_usage}
}
