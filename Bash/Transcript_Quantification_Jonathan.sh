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

DIR_INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/Overassemblies
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/RSEM/All_Assemblies_159b_20181116.okay.cds.fa
DIR_SCRIPT=/home/leandro/miniconda3/envs/Trinity/bin
READS=/faststorage/project/norfab/20181023_INRA

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=All_Assemblies_159b_20181116.okay.cds
A=(159b-Feu-1_ATCACG_L003_BFC_R1_paired.fastq.gz \
159b-Feu-2_CGATGT_L003_BFC_R1_paired.fastq.gz \
159b-Feu-3_ATCACG_L005_BFC_R1_paired.fastq.gz \
159b-Flo-1_CGATGT_L005_BFC_R1_paired.fastq.gz \
159b-Flo-2_CAGATC_L003_BFC_R1_paired.fastq.gz \
159b-Flo-3_ACTTGA_L003_BFC_R1_paired.fastq.gz \
159b-Gou-1_ACAGTG_L005_BFC_R1_paired.fastq.gz \
159b-Gou-2_GTGGCC_L003_BFC_R1_paired.fastq.gz \
159b-Gou-3_GTTTCG_L003_BFC_R1_paired.fastq.gz \
159b-GrL-1_GCCAAT_L005_BFC_R1_paired.fastq.gz \
159b-GrL-2_AGTCAA_L003_BFC_R1_paired.fastq.gz \
159b-GrL-3_AGTTCC_L003_BFC_R1_paired.fastq.gz)

B=(A159b-Feu-1_ATCACG_L003_BFC_R2_paired.fastq.gz \
159b-Feu-2_CGATGT_L003_BFC_R2_paired.fastq.gz \
159b-Feu-3_ATCACG_L005_BFC_R2_paired.fastq.gz \
159b-Flo-1_CGATGT_L005_BFC_R2_paired.fastq.gz \
159b-Flo-2_CAGATC_L003_BFC_R2_paired.fastq.gz \
159b-Flo-3_ACTTGA_L003_BFC_R2_paired.fastq.gz \
159b-Gou-1_ACAGTG_L005_BFC_R2_paired.fastq.gz \
159b-Gou-2_GTGGCC_L003_BFC_R2_paired.fastq.gz \
159b-Gou-3_GTTTCG_L003_BFC_R2_paired.fastq.gz \
159b-GrL-1_GCCAAT_L005_BFC_R2_paired.fastq.gz \
159b-GrL-2_AGTCAA_L003_BFC_R2_paired.fastq.gz \
159b-GrL-3_AGTTCC_L003_BFC_R2_paired.fastq.gz)

C=(Feu1 Feu2 Feu3 Flo1 Flo2 Flo3 Gou1 Gou2 Gou3 GrL1 GrL2 GrL3)

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
for (( I = 0; I < 12; ++I )); do
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
		--SS_lib_type RF \
		--thread_count 8 \
		--output_dir $DIR_OUTPUT/${C[I]}
	echo
done

echo "Done :)"

