#!/bin/bash

# Version 1.1
# Script of quantifying the read counts.
# This is done with bowtie 2.
# The reads you map back are the same reads used to generate the assembly.
# You then count how often reads map to each transcript.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/DRAP/Hedin/Evigene
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/DRAP/Hedin/RSEM/Evigene_46585
DIR_SCRIPT=/home/leandro/Scripts/Others
READS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=All_DRAP_Hedin.okay.cds
A=(R1_1.fq R2_1.fq R3_1.fq R4_1.fq R5_1.fq R6_1.fq R7_1.fq R8_1.fq R9_1.fq \
R10_1.fq R11_1.fq R12_1.fq R13_1.fq R14_1.fq R15_1.fq R16_1.fq R17_1.fq \
R18_1.fq R19_1.fq R20_1.fq R21_1.fq R22_1.fq R23_1.fq R24_1.fq R25_1.fq \
R26_1.fq R27_1.fq R28_1.fq R29_1.fq)

B=(R1_2.fq R2_2.fq R3_2.fq R4_2.fq R5_2.fq R6_2.fq R7_2.fq R8_2.fq R9_2.fq \
R10_2.fq R11_2.fq R12_2.fq R13_2.fq R14_2.fq R15_2.fq R16_2.fq R17_2.fq \
R18_2.fq R19_2.fq R20_2.fq R21_2.fq R22_2.fq R23_2.fq R24_2.fq R25_2.fq \
R26_2.fq R27_2.fq R28_2.fq R29_2.fq)

C=(R01 R02 R03 R04 R05 R06 R07 R08 R09 R10 R11 R12 R13 R14 R15 \
R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28 R29)

# Here A is an array of the left reads, whereas B is an array of the right reads.
# C is the name of the sample folders. 

echo "Files loaded"


##########
# Source #
##########
source /com/extra/bowtie2/2.2.8/load.sh
source /com/extra/RSEM/1.2.29/load.sh
source /com/extra/samtools/1.6.0/load.sh
source /com/extra/trinityrnaseq/2.4.0/load.sh
echo "Sourced: Bowtie2, RSEM, SAMtools and Trinity"

#######
# Run #
#######

echo "Now running the script for Transcript quantification"
for (( I = 0; I < 29; ++I )); do
	echo "Creating the directionary for ${C[I]}"
	mkdir $DIR_OUTPUT/${C[I]}
	echo
	echo "Now calculating the read count of ${A[I]} and ${B[I]} for $INPUT"
	echo "---------------------------------------------------------------------------------"
	$DIR_SCRIPT/align_and_estimate_abundance.pl \
		--seqType fq \
		--left $READS/${A[I]} \
		--right $READS/${B[I]} \
		--transcripts $DIR_INPUT/$INPUT \
		--est_method RSEM \
		--aln_method bowtie2 \
		--coordsort_bam \
		--prep_reference \
		--thread_count 16 \
		--output_dir $DIR_OUTPUT/${C[I]}
	echo
done

echo "Done :)"

