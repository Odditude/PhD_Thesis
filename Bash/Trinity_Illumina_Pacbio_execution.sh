#!/bin/bash

# Script of general execution of Trinity with both Illumina reads and Pacbio ccs.
# The different samples are specified in sample_file. 
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in the unzip directionary: /faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files/

#########
# Files #
#########

INPUT=cond_I.txt
OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/20171012_condI_trinity
CCS=ccs.fasta
MEMORY=100G
CORES=16


echo "Files loaded"

##########
# Source #
##########

source /com/extra/BLAST/2.6.0/load.sh
source /com/extra/bowtie2/2.2.8/load.sh
source /com/extra/java/8/load.sh
source /com/extra/trinityrnaseq/2.4.0/load.sh
echo "Sourced: BLAST, Bowtie2, Java 8, Trinity"

#######
# Run #
#######
echo "This script will run for $INPUT"

echo "Trinity will start running now"

Trinity --seqType fq --max_memory $MEMORY --full_cleanup --samples_file $INPUT --CPU $CORES --long_reads $CCS --output $OUTPUT

echo "Trinity is done"

echo "Remove not needed BLAST database"
rm ccs.fasta.nhr
rm ccs.fasta.nin
rm ccs.fasta.nsq

echo "Done"
