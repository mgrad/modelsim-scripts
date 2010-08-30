proc proc_bp_find_usage {} {
	echo "search for (address | opcode | mnemonic) and return remaining ones.
		usage: sys bp find <command>\n
		Where options are:
		\t address 	: search for address
		\t opcode 	: search for opcode
		\t	mnemonic	: search for mnemonic"
	abort all;	
}
# ------------ main ---------------- #
if { $argc == 0 } { proc_bp_find_usage }

# get command from macro arguments
quietly set cmd [string tolower [ string trimleft $1 {\ } ] ]
shift;


# convert macro arguments to list format
quietly set args [ split $1 {\ } ]

# get command
quietly set cmd [string tolower [ string trimleft [ lindex $args 0] {\ } ] ]
quietly set args [lreplace $args 0 0];		# remove first element (cmd) from args

switch -exact $cmd {
	address   { do ../../data/sys_cmd_bp_find.do address  $args }
	opcode    { do ../../data/sys_cmd_bp_find.do opcode   $args }
	mnemonic  { do ../../data/sys_cmd_bp_find.do mnemonic $args }
	default { puts stderr "Error: command '$cmd' not recognized"; proc_bp_find_usage}
}
