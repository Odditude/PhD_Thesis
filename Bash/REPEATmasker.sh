#!/bin/bash

# Version 1.0
# Script that uses RepeatMasker to find and mask transposones from the gene-set.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/
# This is mostly in script because of often it has to be rerun.

#================#
# Directionaries #
#================#

DIR=/home/leandro/norfab/faststorage/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/TE

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

LIBRARY=RM_64161.WedJan171757392018
FASTA=All_Assemblies_AI.filtered.01.fa

echo "Files loaded"

#========#
# Source #
#========#

source /com/extra/HMMER/3.1b2/load.sh
source /com/extra/TRF/4.04/load.sh

echo "Sourced: HMMER and TRF"

#=====#
# Run #
#=====#

echo "Activate RMBlast envirronment"

source activate rmblast_env

echo "Run RepeatMasker"

/home/leandro/RepeatMasker/RepeatMasker $DIR/$FASTA

echo "Deactivate RMBlast envirronment"

echo "Done :)"
