#!/bin/bash

# Version 1.1
# This version if for stranded reads.
# Script of quantifying the read counts.
# This is done with bowtie 2.
# The reads you map back are the same reads used to generate the assembly.
# You then count how often reads map to each transcript.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Overassemblies
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RSEM/All_Assemblies_AI.okay.cds
DIR_SCRIPT=/home/leandro/Scripts/Others
READS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=All_Assemblies_AI.okay.cds
A=(R25_1 R26_1)
B=(R25_2 R26_2)
C=(Sample_R25 Sample_R26)
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
for (( I = 0; I < 2; ++I )); do
	echo "Creating the directionary for ${C[I]}"
	mkdir $DIR_OUTPUT/${C[I]}
	echo
	echo "Now calculating the read count of ${A[I]} and ${B[I]} for $INPUT"
	echo "---------------------------------------------------------------------------------"
	$DIR_SCRIPT/align_and_estimate_abundance.pl \
		--seqType fq \
		--left $READS/${A[I]}.fq \
		--right $READS/${B[I]}.fq \
		--transcripts $DIR_INPUT/$INPUT \
		--est_method RSEM \
		--aln_method bowtie2 \
		--coordsort_bam \
		--prep_reference \
		--thread_count 8 \
		--output_dir $DIR_OUTPUT/${C[I]} \
		--SS_lib_type RF
	echo
done

echo "Done :)"

