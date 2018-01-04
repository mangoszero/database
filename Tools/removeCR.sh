#!/bin/bash
#
# re error: 
#    /bin/bash^M: bad interpreter: No such file or directory
#
# use this script to remove spurious carriage returns that appear in the script,
# usually as a result of writing the script on a Windows machine
#
# filename - replace with the name of your file

sed -i -e 's/\r$//' dump_tables.sh 
