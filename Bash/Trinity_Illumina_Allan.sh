#!/bin/bash

# Script for execution of Trinity with Allans data (only Illumina reads).
# The different samples are specified in sample_file.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in the unzip directionary: /faststorage/project/norfab/20180126_Allans_data/origData/

#########
# Files #
#########

INPUT=melodie_samples.txt
OUTPUT=/faststorage/project/norfab/20180126_Allans_data/Trinity/20180713_Melodie_Allan_trinity
MEMORY=100G
CORES=12


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

Trinity --seqType fq --max_memory $MEMORY --full_cleanup --samples_file $INPUT --CPU $CORES --output $OUTPUT

echo "Trinity is done"

echo "Done :-)"

