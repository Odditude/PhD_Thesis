import os
import sys
import re


busco_results = sys.argv[1]

if os.path.isfile('./Collected_buscos.txt') is False:
    newopen = open('./Collected_buscos.txt', 'a')
    newopen.write("Busco_File" + '\t' + "Complete%" + '\t' + "Single%" + '\t' + "Duplicated%" + '\t'
                  + "Fragmented%" + '\t' + "Missing%" + '\n')
    newopen.close()

newopen = open('./Collected_buscos.txt', 'a')
fp = open(busco_results)

for line in fp:
    if "C:" in line:
        cake = re.split(r'[:%]', line)
        newopen.write(os.path.basename(busco_results).replace('short_summary.specific.fabales_odb10.busco_', '') + '\t'
                      + cake[1] + '\t' + cake[3] + '\t' + cake[5] + '\t'+ cake[7] + '\t' + cake[9] + '\n')

fp.close()
newopen.close()


'''
To run on multple files:
#!/bin/bash
for file in ./busco_*/short_summary.specific.fabales_odb10.*
do
    python BUSCO_fetcher.py $file
done
'''
