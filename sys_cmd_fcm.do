echo
echo " ----------------------------------------------------------------- "
echo Verilog FCM compilation
echo " ----------------------------------------------------------------- "
vlog -nologo -work $pcore  +incdir+$fcm_lib $pcore_src

# if directory $pcore missing then compile first project
