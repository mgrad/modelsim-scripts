# quiet set SIG [ find signals ${pcore_path}${ps}APUFCMINSTRUCTION -recursive ]
# if { [string length $SIG] == 0 } { puts stderr "Signal $FindSig not found!"; abort all; }

quietly set sig_instr sim:/system_tb/dut/fcm_apu_bswap_0/fcm_apu_bswap_0/APUFCMINSTRUCTION
quietly set sig_addr  sim:/system_tb/dut/ppc405_0/ppc405_0/ppc405_adv_i/ppc405_adv_swift_bw_1/ppc405_adv_swift_inst/dcdaddr

sys init
sys sim

sys wave path_def
sys wave ppc_on
sys wave ppc_reg_on
sys wave run

sys bp read $ELFdeb_file ELFdeb_data
sys bp find mnemonic $ELFinstr ADDRESS OPCODE
regsub -all { } $OPCODE {} OPCODE_nospace

sys bp add $sig_instr $OPCODE_nospace

run 30us
sys wave cursor

# sys vcd
