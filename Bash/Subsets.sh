#!/bin/bash

# Script for Subsetting data. 
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in every dictionary. 

#================#
# Directionaries #
#================#

DIR_IN=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reads/
DIR_OUT=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reads/Subsets/

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

A=(R1_1 \
R2_1 \
R3_1 \
R4_1 \
R5_1 \
R6_1 \
R7_1 \
R8_1 \
R9_1 \
R10_1 \
R11_1 \
R12_1 \
R13_1 \
R14_1 \
R15_1 \
R16_1 \
R17_1 \
R18_1 \
R19_1 \
R20_1 \
R21_1 \
R22_1 \
R23_1 \
R24_1 \
R25_1 \
R26_1 \
R1_2 \
R2_2 \
R3_2 \
R4_2 \
R5_2 \
R6_2 \
R7_2 \
R8_2 \
R9_2 \
R10_2 \
R11_2 \
R12_2 \
R13_2 \
R14_2 \
R15_2 \
R16_2 \
R17_2 \
R18_2 \
R19_2 \
R20_2 \
R21_2 \
R22_2 \
R23_2 \
R24_2 \
R25_2 \
R26_2 \
)

B=(A018_pAC_TCCGCGAA_AGGATAGG_run20170523N_S18_R2_001 \
A019_pAT_TCCGCGAA_CTTCGCCT_run20170523N_S19_R2_001 \
A020_pBC_TCCGCGAA_TAAGATTA_run20170523N_S20_R2_001 \
A021_pBT_AGCGATAG_TCAGAGCC_run20170523N_S21_R2_001 \
A018_pAC_TCCGCGAA_AGGATAGG_run20170523N_S18_R1_001 \
A019_pAT_TCCGCGAA_CTTCGCCT_run20170523N_S19_R1_001 \
A020_pBC_TCCGCGAA_TAAGATTA_run20170523N_S20_R1_001 \
A021_pBT_AGCGATAG_TCAGAGCC_run20170523N_S21_R1_001 \
)

echo "Files are loaded"

#========#
# Source #
#========#

echo "Nothing to source"

#=====#
# Run #
#=====#

#echo "Subset all Aarhus reads" 
#echo "--------------------------------"
#for (( I = 0; I < 52; ++I )); do
#	echo
#	echo "Subsetting ${A[I]}.fq"
#	head -n 2000000 $DIR_IN${A[I]}.fq > $DIR_OUT${A[I]}.500k.fq
#done

echo "Subset all Helsinki reads"
echo "--------------------------------"
for (( I = 0; I < 8; ++I )); do
        echo
        echo "Subsetting ${B[I]}.fastq"
        head -n 2000000 $DIR_IN${B[I]}.fastq > $DIR_OUT${B[I]}.500k.fastq
done

echo
echo "Done ヽ(^O^)ノ"
