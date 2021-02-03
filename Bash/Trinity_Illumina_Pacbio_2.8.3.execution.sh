#!/bin/bash

# This is version 2.0 of the script
# Script of general execution of Trinity with both Illumina reads and Pacbio ccs.
# The different samples are specified in sample_file.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in the folder where the fasta reads are located. 
# This Script uses Trinity 2.8.3. that is installed on /leandro. 

#================#
# Directionaries #
#================#

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

INPUT=cond_E.txt
OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/20181116_condE_trinity/
CCS=ccs_E.fasta
MEMORY=200G
CORES=16

echo "Files loaded"

#========#
# Source #
#========#

source activate Trinity
echo "Activate Trinity envirronment"

#=====#
# Run #
#=====#

echo "This script will run for $INPUT"

echo "Trinity will start running now"

/home/leandro/miniconda3/envs/Trinity/opt/trinity-2.8.3/Trinity --seqType fq --max_memory $MEMORY --bflyHeapSpaceMax 40G --bflyGCThreads 20 --include_supertranscripts --full_cleanup --samples_file $INPUT --CPU $CORES --long_reads $CCS --output $OUTPUT

echo "Trinity is done"

echo "Remove not needed BLAST database"
rm ${CCS}.nhr
rm ${CCS}.nin
rm ${CCS}.nsq

source deactivate Trinity
echo "Deactivate Trinity envirronment"

echo "Done ヽ(^O^)ノ"
