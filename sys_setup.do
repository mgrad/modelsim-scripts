.main clear			# clear transcript window

# load configuration
do ../../data/_config.do "no_print"

# setup menu 'sys'
# it is splitted that way because we don't want to use procedures
# they need global var's all the time and don't support quiet keyword
alias sys { do ../../data/sys_setup_cmd.do }

# setup print
alias p { sys print }

echo "Setup loaded."
