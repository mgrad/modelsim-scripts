proc proc_sys_usage {} {
	echo "usage: sys <command>\n
		Where command is one of: 
		\t conf		: reload configuration
		\t setup		: reload setup
		\t pcore		: reload pcore simulation
		\t quit		: quits simulation and resets wave windows
		\t init		: quits simulation, reloads brams & fcm 
		\t sim 		: load simulation 
		\t wave		: wave window's menu 
		\t vcd		: record simulation 
		\t bp 		: breakpoint's menu
		\t find		: instruction in wave window
		\t run 		: run simulation
		\t all 		: do everything at once"
		abort all
}


# ------------ main ---------------- #
if { $argc == 0 } { proc_sys_usage }

# get command from macro arguments
quietly set cmd [string tolower [ string trimleft $1 {\ } ] ]
shift;

# convert rest of macro arguments to list format
quietly set nbrArgs $argc
set args "";
for {set x 0 } {$x < $nbrArgs} {incr x} {
	lappend args "$1"
	shift
}


switch -exact $cmd {
	bram  { do ../../data/sys_cmd_bram.do }
	fcm   { do ../../data/sys_cmd_fcm.do }
	quit  { do ../../data/sys_cmd_quit.do }
	conf  { do ../../data/_config.do }
	setup { do ../../data/sys_setup.do }
	pcore { do ../../data/reload_pcore.do }

	init { sys quit; sys bram; sys fcm;  }
	wave { do ../../data/sys_setup_cmd_wave.do $args }
	sim  { do ../../data/sys_cmd_sim.do }
	vcd  { do ../../data/sys_cmd_vcd.do }
	bp   { do ../../data/sys_setup_cmd_bp.do $args }
	run  { do ../../data/sys_cmd_run.do }

	all  {  sys quit ; do ../../data/cmds.do }

	print { do ../../data/sys_cmd_print.do }
	p     { sys print }

	find  { do ../../data/sys_cmd_find.do $args }

	default { proc_sys_usage }
}

# unset cmd
# unset nbrArgs
# unset args
