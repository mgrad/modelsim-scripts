	if { [info exists xcmds] } {
		if { [info exists xcmdw] } {
			echo "Deleting cursors from wave windows"
			while { [quietly wave deletecursor] > 0 } { }
		}

		echo " ----------------------------------------------------------------- "
		echo Quiting current simulation
		echo " ----------------------------------------------------------------- "
		quit -sim
	
		# remove tags for compilation, simulation, wave
		if { [info exists xcmdc] } {unset xcmdc}
		if { [info exists xcmds] } {unset xcmds}
		if { [info exists xcmdw] } {unset xcmdw}
	
	} else {
		echo "Simulation not loaded."
	}
