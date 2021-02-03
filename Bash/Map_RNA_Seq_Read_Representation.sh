#!/bin/bash

# Version 1.2
# Script of finding how many of the reads that maps back to the assembly. 
# This is done with bowtie 2. 
# The reads you map back are the same reads used to generate the assembly. 
# This is used as a quality measure. Ideally we want atleast 80 % to be mapped back. 
# How many nodes, cores and amount of time is set in the terminal and not here. 
# This Script is designed to be run in any directionary: /home/leandro/
# Introduced blanklines() function, and change a blank line into a line of "---" 

##################
# Directionaries #
##################

DIR_INDEX=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Index/
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Output/
READS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files/

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Overassemblies/20171020_Cond_all.okay.cds.fa
INDEX=20171012_Cond_all
OUTPUT=CondAll_align_stats.txt
A=(R1_1 R2_1 R3_1 R4_1 R5_1 R6_1 R7_1 R8_1 R9_1 R10_1 R11_1 R12_1 R13_1 R14_1 R15_1 R16_1 R17_1 R18_1 R19_1 R20_1 R21_1 R22_1 R23_1 R24_1 R25_1 R26_1)
B=(R1_2 R2_2 R3_2 R4_2 R5_2 R6_2 R7_2 R8_2 R9_2 R10_2 R11_2 R12_2 R13_2 R14_2 R15_2 R16_2 R17_2 R18_2 R19_2 R20_2 R21_2 R22_2 R23_2 R24_2 R25_2 R26_2)

# Here A is an array of the left reads, whereas B is an array of the right reads.

echo "Files loaded"

#############
# Functions #
#############

# This creates a blank line and puts it into the output file
blankline()
{
	echo | tee -a $DIR_OUTPUT$OUTPUT
}

##########
# Source #
##########

source /com/extra/bowtie2/2.2.8/load.sh
echo "Sourced: Bowtie2"

#######
# Run #
#######

echo "Creating the directionary for the index"
mkdir $DIR_INDEX$INDEX

echo "Bowtie2 will now build the index"

bowtie2-build $INPUT $DIR_INDEX${INDEX}/$INDEX

echo "Bowtie2 will now map the reads back to the assembly they created"


for (( I = 0; I < 26; ++I )); do
	blankline	
	echo "This is the RNA-seq read representation from ${A[I]} and ${B[I]} of the $INDEX assembly" | tee -a $DIR_OUTPUT$OUTPUT
	echo "-------------------------------------------------------------------------------------------" | tee -a $DIR_OUTPUT$OUTPUT
	bowtie2 -p 10 -q -x $DIR_INDEX${INDEX}/$INDEX -1 $READS${A[I]}.fq -2 $READS${B[I]}.fq  \
     		2>&1 1> /dev/null | tee -a $DIR_OUTPUT$OUTPUT
	blankline
done

echo "Done :)"
