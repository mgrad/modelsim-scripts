proc proc_bp_find_cmd_usage {cmd} {
	switch -exact $cmd {
		address { 
			set str_params "<var_opcode> <var_mnemonic>";
			set str_info    "\t var_opcode		: varible name where to store opcode\n"
			append str_info "\t var_mnemonic		: variable name where to store mnemonic"
		}
		opcode { 
			set str_params "<var_address> <var_mnemonic>";
			set str_info    "\t var_address		: varible name where to store address\n"
			append str_info "\t var_mnemonic		: variable name where to store mnemonic"
		}
		mnemonic { 
			set str_params "<var_address> <var_opcode>";
			set str_info    "\t var_address		: varible name where to store address\n"
			append str_info "\t var_opcode		: variable name where to store opcode"
		}
	}

	echo "Usage: sys bp find $cmd <value> $str_params\n
	Where options are:
	\t value 		 : search for that value in $cmd column
	$str_info"
	abort all;	
}

proc opcode_rem_spaces { var_name } {
	upvar $var_name tmp
	regsub -all { } $tmp {} tmp
}

proc opcode_add_spaces { var_name } {
	upvar $var_name tmp
	regexp "(..)(..)(..)(..)" $tmp line a b c d
	set tmp "$a $b $c $d"
	unset line
}

proc mecho { string } {
	upvar DEBUG_LEVEL deb
	if {$deb} {
		echo $string
	}
}
# ------------ main ---------------- #
if { $argc == 0 } { proc_bp_find_usage };		# located in sys_setup_cmd_bp_find.do

# there is command get it
if { $argc > 0 } {
	quietly set cmd [string tolower [ string trimleft $1 {\ } ] ]
}

# there is command but no parameters show command help
if { $argc == 1 } {
	proc_bp_find_cmd_usage $cmd 
}

# there is command + params - parse params
quietly set args [ split $2 {\ } ] 

# convert macro arguments to list format
if { 3 != [llength $args] } { proc_bp_find_cmd_usage $cmd }

mecho "-- param value to search: '[set val [ string trimleft [ lindex $args 0] {\ } ]]'" 

	switch -exact $cmd {
		address  { 
			set pattern "$val:	(.. .. .. ..) 	(.* )" 
			quietly set desc1 opcode; 
			quietly set desc2 mnemonic;
		}
		opcode   { 
			opcode_add_spaces val
			set pattern "(.*):	${val} 	(.* )" 
			quietly set desc1 address; 
			quietly set desc2 mnemonic;
		}
		mnemonic {
			set pattern "(.*):	(.. .. .. ..) 	${val}" 
			quietly set desc1 address; 
			quietly set desc2 opcode;
		}
		default { puts stderr "Error: command '$cmd' not recognized"; proc_bp_find_usage}
	}
	mecho "-- param output var name for $desc1: '\$[ set var_name1 [ string trimleft [ lindex $args 1] {\ } ]]'"
	mecho "-- param output var name for $desc2: '\$[ set var_name2 [ string trimleft [ lindex $args 2] {\ } ]]'"

if { [regexp -line $pattern $ELFdeb_data match $var_name1 $var_name2 ] } {
	# remove spaces for opcode
	if { [string compare $cmd "mnemonic"] == 0 } { 
			opcode_rem_spaces $var_name2
	}
	mecho "Found data:\n\t\[$desc1\]: \$$var_name1 = [ expr $$var_name1]\n\t\[$desc2\]: \$$var_name2 = [expr $$var_name2]"
} else {
	puts stderr "data not found!"
}
