if {  ![ info exists ELFdeb_data] } {
	puts stderr "Warning: debugging file not loaded!\n"; 
	abort all 
}

quietly set sig_instr sim:/system_tb/dut/fcm_apu_bswap_0/fcm_apu_bswap_0/APUFCMINSTRUCTION
quietly set sig_addr  sim:/system_tb/dut/ppc405_0/ppc405_0/ppc405_adv_i/ppc405_adv_swift_bw_1/ppc405_adv_swift_inst/dcdaddr


# get address from dcdaddr signal
quietly set address [ examine -hex -time [getactivecursortime] $sig_addr ]
quietly set address [ string tolower $address]

# get opcode from apufcminstructionsignal
quietly set opcode [ examine -hex -time [getactivecursortime] $sig_instr ]
quietly regexp "(..)(..)(..)(..)" $opcode line a b c d
quietly set opcode_with_spaces "$a $b $c $d"


# find address in debug data
quietly regexp -line -all $address.*$opcode_with_spaces.* $ELFdeb_data debug
echo $debug
