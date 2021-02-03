#!/bin/bash

# Version 1.1
# Script of finding how many of the reads that maps back to the assembly.
# This is done with BWA.
# The reads you map back are the same reads used to generate the assembly.
# Besides the root samples
# This is used as a quality measure. Ideally we want atleast 80 % to be mapped back.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_OUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/BWA-mem/Hedin1.0
READS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files

echo "Directionaries are loaded"

#########
# Files #
#########

ASSEMBLY=All_Assemblies_AI.filtered.01.fa
READS1=(R27_1 R28_1 R29_1)
READS2=(R27_2 R28_2 R29_2)
BAM=(R27 R28 R29)


# Here A is an array of the left reads, whereas B is an array of the right reads.

echo "Files loaded"

#========#
# Source #
#========#

source /com/extra/bwa/0.7.5a/load.sh
source /com/extra/samtools/1.6.0/load.sh

echo "Sourced: BWA and samtools"

#=====#
# Run #
#=====#

echo 'Making the index'
bwa index $DIR_OUT/$ASSEMBLY


for (( I = 0; I < 3; ++I )); do
        echo
        echo "Aligning ${ASSEMBLY} with ${READS1[I]} and ${READS2[I]}"
        bwa mem -t 8 $DIR_OUT/$ASSEMBLY $READS/${READS1[I]}.fq $READS/${READS2[I]}.fq | samtools sort -@8 -o $DIR_OUT/${BAM[I]}.bam -
        echo "Calculating mapping statistics"
        samtools flagstat $DIR_OUT/${BAM[I]}.bam > $DIR_OUT/${BAM[I]}_flagstat.log
        echo 'Done'
done

echo "Done ヽ(^O^)ノ"
