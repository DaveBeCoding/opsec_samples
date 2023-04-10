#this is not ment to be run on a script, just a one-liner for terminal use
#
#
#
#
#
#
#
#

$ while read -r line; do echo "$line"; r2 -c "VV $line" /path/to/binary; done < functions.txt
