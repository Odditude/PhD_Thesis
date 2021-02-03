#!/bin/bash

# Version 1.0
# This script assemblies small RNA together. 
# This is done with PEAR. 
# This script has bene made to run Sara's samples, on the 21-12-2017. 
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_OUTPUT=/home/leandro/SaraPear/Output
READS=/home/leandro/SaraPear/Reads/NorfabShare/Sara

echo "Directionaries are loaded"

#########
# Files #
#########

A=(1016_S9_L001_R1_001.fastq \
1017_S29_L001_R1_001.fastq \
1116_S10_L001_R1_001.fastq \
1117_S30_L001_R1_001.fastq \
116_S1_L001_R1_001.fastq \
117_S20_L001_R1_001.fastq \
1216_S11_L001_R1_001.fastq \
1217_S31_L001_R1_001.fastq \
1316_S12_L001_R1_001.fastq \
1317_S32_L001_R1_001.fastq \
13D16_S18_L001_R1_001.fastq \
1416_S13_L001_R1_001.fastq \
1417_S33_L001_R1_001.fastq \
1516_S14_L001_R1_001.fastq \
1517_S34_L001_R1_001.fastq \
1616_S15_L001_R1_001.fastq \
1617_S35_L001_R1_001.fastq \
1716_S16_L001_R1_001.fastq \
1717_S36_L001_R1_001.fastq \
1816_S17_L001_R1_001.fastq \
1817_S37_L001_R1_001.fastq \
1917_S38_L001_R1_001.fastq \
2017_S39_L001_R1_001.fastq \
2117_S40_L001_R1_001.fastq \
216_S2_L001_R1_001.fastq \
217_S21_L001_R1_001.fastq \
2217_S41_L001_R1_001.fastq \
2317_S42_L001_R1_001.fastq \
2417_S43_L001_R1_001.fastq \
2517_S44_L001_R1_001.fastq \
2617_S45_L001_R1_001.fastq \
2717_S46_L001_R1_001.fastq \
2817_S47_L001_R1_001.fastq \
2917_S48_L001_R1_001.fastq \
2D16_S19_L001_R1_001.fastq \
3017_S49_L001_R1_001.fastq \
3117_S50_L001_R1_001.fastq \
316_S3_L001_R1_001.fastq \
317_S22_L001_R1_001.fastq \
3217_S51_L001_R1_001.fastq \
3317_S52_L001_R1_001.fastq \
3417_S53_L001_R1_001.fastq \
3517_S54_L001_R1_001.fastq \
3617_S55_L001_R1_001.fastq \
416_S4_L001_R1_001.fastq \
417_S23_L001_R1_001.fastq \
517_S24_L001_R1_001.fastq \
616_S5_L001_R1_001.fastq \
617_S25_L001_R1_001.fastq \
716_S6_L001_R1_001.fastq \
717_S26_L001_R1_001.fastq \
816_S7_L001_R1_001.fastq \
817_S27_L001_R1_001.fastq \
916_S8_L001_R1_001.fastq \
917_S28_L001_R1_001.fastq \
)


B=(1016_S9_L001_R2_001.fastq \
1017_S29_L001_R2_001.fastq \
1116_S10_L001_R2_001.fastq \
1117_S30_L001_R2_001.fastq \
116_S1_L001_R2_001.fastq \
117_S20_L001_R2_001.fastq \
1216_S11_L001_R2_001.fastq \
1217_S31_L001_R2_001.fastq \
1316_S12_L001_R2_001.fastq \
1317_S32_L001_R2_001.fastq \
13D16_S18_L001_R2_001.fastq \
1416_S13_L001_R2_001.fastq \
1417_S33_L001_R2_001.fastq \
1516_S14_L001_R2_001.fastq \
1517_S34_L001_R2_001.fastq \
1616_S15_L001_R2_001.fastq \
1617_S35_L001_R2_001.fastq \
1716_S16_L001_R2_001.fastq \
1717_S36_L001_R2_001.fastq \
1816_S17_L001_R2_001.fastq \
1817_S37_L001_R2_001.fastq \
1917_S38_L001_R2_001.fastq \
2017_S39_L001_R2_001.fastq \
2117_S40_L001_R2_001.fastq \
216_S2_L001_R2_001.fastq  \
217_S21_L001_R2_001.fastq \
2217_S41_L001_R2_001.fastq \
2317_S42_L001_R2_001.fastq \
2417_S43_L001_R2_001.fastq \
2517_S44_L001_R2_001.fastq \
2617_S45_L001_R2_001.fastq \
2717_S46_L001_R2_001.fastq \
2817_S47_L001_R2_001.fastq \
2917_S48_L001_R2_001.fastq \
2D16_S19_L001_R2_001.fastq \
3017_S49_L001_R2_001.fastq \
3117_S50_L001_R2_001.fastq \
316_S3_L001_R2_001.fastq \
317_S22_L001_R2_001.fastq \
3217_S51_L001_R2_001.fastq \
3317_S52_L001_R2_001.fastq \
3417_S53_L001_R2_001.fastq \
3517_S54_L001_R2_001.fastq \
3617_S55_L001_R2_001.fastq \
416_S4_L001_R2_001.fastq \
417_S23_L001_R2_001.fastq \
517_S24_L001_R2_001.fastq \
616_S5_L001_R2_001.fastq \
617_S25_L001_R2_001.fastq \
716_S6_L001_R2_001.fastq \
717_S26_L001_R2_001.fastq \
816_S7_L001_R2_001.fastq \
817_S27_L001_R2_001.fastq \
916_S8_L001_R2_001.fastq \
917_S28_L001_R2_001.fastq \
)

C=(1016_S9 \
1017_S29 \
1116_S10 \
1117_S30 \
116_S1 \
117_S20 \
1216_S11 \
1217_S31 \
1316_S12 \
1317_S32 \
13D16_S18 \
1416_S13 \
1417_S33 \
1516_S14 \
1517_S34 \
1616_S15 \
1617_S35 \
1716_S16 \
1717_S36 \
1816_S17 \
1817_S37 \
1917_S38 \
2017_S39 \
2117_S40 \
216_S2 \
217_S21 \
2217_S41 \
2317_S42 \
2417_S43 \
2517_S44 \
2617_S45 \
2717_S46 \
2817_S47 \
2917_S48 \
2D16_S19 \
3017_S49 \
3117_S50 \
316_S3 \
317_S22 \
3217_S51
3317_S52 \
3417_S53 \
3517_S54 \
3617_S55 \
416_S4 \
417_S23 \
517_S24 \
616_S5 \
617_S25 \
716_S6 \
717_S26 \
816_S7 \
817_S27 \
916_S8 \
917_S28 \
)
# Here A is an array of the left reads, whereas B is an array of the right reads.
# C is the name of the sample folders.

echo "Files loaded"


##########
# Source #
##########

source /com/extra/pear/0.9.4/load.sh
echo "Sourced: Pear"

#######
# Run #
#######

echo "Now running the script for Pear assembly"
for (( I = 0; I < 55; ++I )); do
        echo "Creating the directionary for ${C[I]}"
        mkdir $DIR_OUTPUT/${C[I]}
        echo
	echo "Now assembling the  ${A[I]} and ${B[I]} reads"
        echo "---------------------------------------------------------------------------------"
        pear \
                -f $READS/${A[I]} \
                -r $READS/${B[I]} \
                -o $DIR_OUTPUT/${C[I]}/${C[I]}
        echo
done

echo "Done :)"


