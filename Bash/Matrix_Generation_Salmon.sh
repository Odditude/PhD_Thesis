#!/bin/bash

# Version 1.1
# Script for generating matrix out of salmon read counts.
# The reads you map back are the same reads used to generate the assembly.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_SCRIPT=/home/leandro/miniconda3/envs/Trinity/bin

echo "Directionaries are loaded"

#########
# Files #
#########

SAMPLES=matrix_cond.txt

echo "Files loaded"


##########
# Source #
##########

# Salmon and Trinity are loaded in the Trinity environment.
#  If not all ready in the envorinment, activate it:
# conda activate Trinity

echo "Sourced: Salmon and Trinity"

#######
# Run #
#######

$DIR_SCRIPT/abundance_estimates_to_matrix.pl --est_method salmon \
    --gene_trans_map none \
    --out_prefix salmon_hedin_08022019 \
    --name_sample_by_basedir \
    --quant_files $SAMPLES
