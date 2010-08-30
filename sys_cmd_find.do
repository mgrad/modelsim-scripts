if { $argc > 0 } {
	quietly set mnem $1;

	quietly set DEBUG_LEVEL 0
	quietly set sig_instr sim:/system_tb/dut/fcm_apu_bswap_0/fcm_apu_bswap_0/APUFCMINSTRUCTION
	quietly set sig_addr  sim:/system_tb/dut/ppc405_0/ppc405_0/ppc405_adv_i/ppc405_adv_swift_bw_1/ppc405_adv_swift_inst/dcdaddr

	sys bp find mnemonic $mnem ADDR OPCODE
	set val_addr  'h$ADDR
	set val_instr  'h$OPCODE
	set res [searchlog -expr { $sig_addr == $val_addr && $sig_instr == $val_instr } 0 ns $sig_instr $sig_addr]
	scan $res "\{\{%d" time
	wave cursortime -time $time

} else { echo no params }
