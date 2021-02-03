#!/bin/bash

# Version 1.0
# This script helps putting the results froim the abundance estimates into a matrix. 
# This is done with a script from the Trinity package. 
# How many nodes, cores and amount of time is set in the terminal and not here.
# This script is designed to be run in the directionary where there results are stored.
# This is run with the script and not directly on the terminal to lave a better footprint for later use. 

##########
# Source #
##########

source /com/extra/R/3.5.0/load.sh
source /com/extra/trinityrnaseq/2.4.0/load.sh
source /com/extra/gcc/5.3.0/load.sh
echo "Sourced: R and Trinity"

#######
# Run #
#######


echo 'Now running the commands'

/home/leandro/Scripts/Others/abundance_estimates_to_matrix.pl \
	--est_method RSEM \
	--gene_trans_map 'none' \
	--out_prefix RSEM \
	--name_sample_by_basedir \
	R01/RSEM.genes.results \
	R02/RSEM.genes.results \
	R03/RSEM.genes.results \
	R04/RSEM.genes.results \
	R05/RSEM.genes.results \
	R06/RSEM.genes.results \
	R07/RSEM.genes.results \
	R08/RSEM.genes.results \
	R09/RSEM.genes.results \
	R10/RSEM.genes.results \
	R11/RSEM.genes.results \
	R12/RSEM.genes.results \
	R13/RSEM.genes.results \
        R14/RSEM.genes.results \
        R15/RSEM.genes.results \
        R16/RSEM.genes.results \
        R17/RSEM.genes.results \
        R18/RSEM.genes.results \
        R19/RSEM.genes.results \
        R20/RSEM.genes.results \
        R21/RSEM.genes.results \
        R22/RSEM.genes.results \
        R23/RSEM.genes.results \
        R24/RSEM.genes.results \
        R25/RSEM.genes.results \
        R26/RSEM.genes.results \
        R27/RSEM.genes.results \
        R28/RSEM.genes.results \
	R29/RSEM.genes.results

echo "Done ヽ(^O^)ノ"
