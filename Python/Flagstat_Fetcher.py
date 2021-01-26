import os
import sys


FlagStatFile = sys.argv[1]
if os.path.isfile('./Collected_flags.txt') is False:
    newopen = open('./Collected_flags.txt', 'a')
    newopen.write("Library" + '\t' + "All_reads" + '\t' + "Total_Mappend" + '\t' + "Total_Mappend%" + '\t' + "Proper_mapped" + '\t'
                  + "Proper_mapped%" + '\t' + "Other_Chrom" + '\n')
    newopen.close()

newopen = open('./Collected_flags.txt', 'a')
fp = open(FlagStatFile)


newopen.write(FlagStatFile + '\t')
for i, line in enumerate(fp):
    if i == 0:
        newopen.write(line.split(" ")[0] + '\t')
    elif i == 4:
        newopen.write(line.split(" ")[0] + '\t')
        newopen.write(line.split(" ")[4][1:] + '\t')
    elif i == 8:
        newopen.write(line.split(" ")[0] + '\t')
        newopen.write(line.split(" ")[5][1:] + '\t')
    elif i == 12:
        newopen.write(line.split(" ")[0] + '\n')

fp.close()
newopen.close()




#=======#
# Notes #
#=======#

'''
To run on multiple files:
#!/bin/bash
for file in ./path/*.log
do
    python Flagstat_fletcher.py $file
done
'''
