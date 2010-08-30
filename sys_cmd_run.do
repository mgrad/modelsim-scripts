	# record all system stimulus
	vcd dumpports -file $VCDstim_sys_file $tbpath${ps}${pcore}_0${ps}${pcore}_0${ps}*

	# todo: run until bp + some delta time
	run 100us
