echo
echo " ----------------------------------------------------------------- "
echo   Generating Verilog file from ELF binary.
echo " ----------------------------------------------------------------- "
echo -- UCF file ($UCFfile)
echo -- -- param input elf file:  $ELFfile
echo -- -- param output ucf file: $UCFfile

exec data2mem -bm "system_sim.bmm"  -bd  \
		$ELFfile \
		tag ppc405_0 -u -o u $UCFfile


# --------------------------------------------------------------- #
echo 
echo -- VERILOG file ($VERfile)
echo -- -- param input ucf file:      $UCFfile
echo -- -- param output verilog file: $VERfile
echo -- -- param system:              $VERsys
echo -- -- param module:              $VERmod
echo -- -- param simulation:          $VERsim
echo 

exec  xilperl.exe  "C:/Xilinx/EDK91i/bin/nt/ucf2ver.pl" \
	$UCFfile $VERfile $VERsys $VERmod $VERsim
#	tmp.ucf system_init.v dut system_conf beh


echo " ----------------------------------------------------------------- "
echo Reloading BRAMs with ELF
echo " ----------------------------------------------------------------- "
echo -- -- param input verilog file: $VERfile
echo -- -- param output modelsim module: $VERmod
echo -- -- param changing instance: $VERsys
vlog -quiet -nologo -work work +incdir+  $VERfile

# if missing simulation/behavioral/work - then compile first project
