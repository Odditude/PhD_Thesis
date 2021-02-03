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
source /com/extra/gcc/5.3.0/load.sh
echo "Sourced: R and gcc"

#######
# Run #
#######


echo 'Now running the commands'

/home/leandro/miniconda3/envs/Trinity/opt/trinity-2.8.3/util/abundance_estimates_to_matrix.pl \
	--est_method RSEM \
	--gene_trans_map 'none' \
	--out_prefix RSEM \
	--name_sample_by_basedir \
	Feu1/RSEM.genes.results \
	Feu2/RSEM.genes.results \
        Feu3/RSEM.genes.results \
        Flo1/RSEM.genes.results \
        Flo2/RSEM.genes.results \
        Flo3/RSEM.genes.results \
        Gou1/RSEM.genes.results \
        Gou2/RSEM.genes.results \
        Gou3/RSEM.genes.results \
        GrL1/RSEM.genes.results \
        GrL2/RSEM.genes.results \
        GrL3/RSEM.genes.results

echo "Done ヽ(^O^)ノ"
