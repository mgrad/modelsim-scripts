if { [ info exists argc] && $argc == 0  } {
	echo " ----------------------------------------------------------------- "
	echo Loading configuration (Initialization)
	echo -- change params only if not setup already
	echo " ----------------------------------------------------------------- "
}

# tag that config has been read
quietly set xcmdconf 1

quietly set DEBUG_LEVEL 0 


# setenv PATH  "C:/Modeltech_6.2c/win32;C:/Xilinx/ISE91i/smartmodel/nt/installed_nt/bin;C:/Xilinx/ISE91i/smartmodel/nt/installed_nt/lib/pcnt.lib;C:/Xilinx/EDK91i/bin/nt;C:/Xilinx/ISE91i/bin/nt;C:/Modeltech_6.2c/win32;C:/WINDOWS/system32;C:/WINDOWS;C:/WINDOWS/System32/Wbem;c:/Xilinx/EDK91i/cygwin/bin/;c:/Program Files/GnuWin32/bin/;[pwd]/../../data;"

# ---------------------------- #
# bram
# ---------------------------- #
if { ![info exists ELFfile] } { quietly set ELFfile "../../TestApp_Memory/executable.elf" }
if { ![info exists UCFfile] } { quietly set UCFfile "tmp.ucf" }

if { ![info exists VERfile]} { quietly set VERfile "system_init.v" }
if { ![info exists VERsys] } { quietly set VERsys "dut" }
if { ![info exists VERmod] } { quietly set VERmod "system_conf" }
if { ![info exists VERsim] } { quietly set VERsim "beh" }


# ---------------------------- #
# fcm
# ---------------------------- #
if {![info exists fcm_lib] } {
	quietly set fcm_lib "../../pcores/fcm_apu_bswap/hdl/verilog/"
	quietly set fcm_lib "${fcm_lib}+../../pcores/"
	quietly set fcm_lib "${fcm_lib}+C:/Xilinx/EDK91i/hw/XilinxProcessorIPLib/pcores/"
	quietly set fcm_lib "${fcm_lib}+C:/Xilinx/EDK91i/hw/XilinxReferenceDesigns/pcores/"
}
if {![info exists pcore]} { quietly set pcore fcm_apu_bswap }
if {![info exists pcore_src]} { quietly set pcore_src "../../pcores/fcm_apu_bswap/hdl/verilog/fcm.v" }


# ---------------------------- #
# wave
# ---------------------------- #
if { [info exists PathSeparator] } { quietly set ps $PathSeparator } else { quietly set ps "/" }
if { ![info exists tbpath] } { quietly set tbpath "system_tb${ps}${VERsys}" }

# default value
quietly set pcore_path "$tbpath${ps}${pcore}_0${ps}${pcore}_0"

quietly set binopt {-logic}
quietly set hexopt {-literal -hex}
quietly set show_ppc_wave 1 
quietly set show_ppc_reg_wave 0


# ---------------------------- #
# bp
# ---------------------------- #
if { ![info exists BPfile] } { quietly set BPfile "../../data/bp-result.txt"};		
if { ![info exists ELFdeb_file] }   { quietly set ELFdeb_file ${ELFfile}.deb}
#	"../../TestApp_Memory/executable.elf.deb-llvm" }
if { ![info exists ELFinstr] } { quietly set ELFinstr "udi"};		
if { ![info exists FindSig] }  { quietly set FindSig "dcdaddr"};		# setup breakpoint at that sig

if { [ info exists ELFdeb_data] } { unset ELFdeb_data }



# ---------------------------- #
# vcd_filter
# ---------------------------- #
if { ![info exists VCDstim_sys_file]} { quietly set VCDstim_sys_file "tb_sys.vcd" }
if { ![info exists VCDstim_pcore_file]} { quietly set VCDstim_pcore_file "tb_pcore.vcd" }
if { ![info exists VCDscript]} { quietly set VCDscript "../../data/vcd_filter.pl" }


# ---------------------------- #
# misc
# ---------------------------- #
proc check_eval { cmds } {
	if { [ catch { eval $cmds } errno ] } {
		puts stderr "Error: $errno"
		abort all
	}
}

proc check_var { var_name } {
	if { ![info exists $var_name] } {
		puts stderr "Error: \$$var_name does not exists!"; return 1;
	}
	check_eval "upvar $var_name var"
	if { [string length $var] == 0 } { 
		puts stderr "Error: \$$var_name is empty !"; return 2;
	}
	return 0;
}

# ---------------------------- #
if { $argc == 0 } { echo done. }
