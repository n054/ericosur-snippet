@echo off
dir /s/b > list.txt
perl d:\ericosur-google\filesize\add_size.pl list.txt outsize.txt
perl d:\ericosur-google\filesize\calc_total_size.pl outsize.txt

rem del list.txt
rem del outsize.txt
