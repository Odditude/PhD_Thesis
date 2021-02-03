#!/bin/bash

# Version 1.0
# This script it used to map the Salmon reads for Grouper
# This need to flags; --dumEq and --writeOrphanLinks
# How many nodes, cores and amount of time is set in the terminal and not here.
# If --validateMappings are used, --hardFilter needs to be used. 
# This Script is designed to be run in any directionary: /home/leandro/

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 16 -t 10:00:00 -A norfab '/home/leandro/Scripts/Salmon_Corset_Hedin.sh'

#================#
# Directionaries #
#================#

DIR_ASS=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/MODES
DIR_IND=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/MODES/Index
DIR_OUT=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/MODES/M01
DIR_REA=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files

echo "Directionaries are loaded"

#========#
# Source #
#========#

echo "Salmon is already installed"

#=======#
# Files #
#=======#

CORES=16

i=Mode01
T=Mode01.fa


j=(\
R1_1.fq \
R2_1.fq \
R3_1.fq \
R4_1.fq \
R5_1.fq \
R6_1.fq \
R7_1.fq \
R8_1.fq \
R9_1.fq \
R10_1.fq \
R11_1.fq \
R12_1.fq \
R13_1.fq \
R14_1.fq \
R15_1.fq \
R16_1.fq \
R17_1.fq \
R18_1.fq \
R19_1.fq \
R20_1.fq \
R21_1.fq \
R22_1.fq \
R23_1.fq \
R24_1.fq \
R25_1.fq \
R26_1.fq \
R27_1.fq \
R28_1.fq \
R29_1.fq \
)

k=(\
R1_2.fq \
R2_2.fq \
R3_2.fq \
R4_2.fq \
R5_2.fq \
R6_2.fq \
R7_2.fq \
R8_2.fq \
R9_2.fq \
R10_2.fq \
R11_2.fq \
R12_2.fq \
R13_2.fq \
R14_2.fq \
R15_2.fq \
R16_2.fq \
R17_2.fq \
R18_2.fq \
R19_2.fq \
R20_2.fq \
R21_2.fq \
R22_2.fq \
R23_2.fq \
R24_2.fq \
R25_2.fq \
R26_2.fq \
R27_2.fq \
R28_2.fq \
R29_2.fq \
)

NAME=(\
Hedin_R01_quant \
Hedin_R02_quant \
Hedin_R03_quant \
Hedin_R04_quant \
Hedin_R05_quant \
Hedin_R06_quant \
Hedin_R07_quant \
Hedin_R08_quant \
Hedin_R09_quant \
Hedin_R10_quant \
Hedin_R11_quant \
Hedin_R12_quant \
Hedin_R13_quant \
Hedin_R14_quant \
Hedin_R15_quant \
Hedin_R16_quant \
Hedin_R17_quant \
Hedin_R18_quant \
Hedin_R19_quant \
Hedin_R20_quant \
Hedin_R21_quant \
Hedin_R22_quant \
Hedin_R23_quant \
Hedin_R24_quant \
Hedin_R25_quant \
Hedin_R26_quant \
Hedin_R27_quant \
Hedin_R28_quant \
Hedin_R29_quant \
)

#=====#
# Run #
#=====#

echo "Now creating the Index"
salmon index -t $DIR_ASS/$T -i $DIR_IND/$i

echo "Now commencing mapping"

for (( I = 0; I < 29; ++I )); do
        echo "Quantifying ${NAME[I]}"
        salmon quant -l A --gcBias --validateMappings --hardFilter --dumpEq --writeOrphanLinks -p $CORES -i $DIR_IND/$i -1 $DIR_REA/${j[I]} -2 $DIR_REA/${k[I]} -o $DIR_OUT/${NAME[I]}
        echo "Done"
done

echo "Done ヽ(^O^)ノ"
