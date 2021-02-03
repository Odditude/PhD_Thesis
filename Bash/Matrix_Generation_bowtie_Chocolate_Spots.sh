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
	R0_052/RSEM.genes.results \
	R0_053/RSEM.genes.results \
	R0_055/RSEM.genes.results \
	R0_062/RSEM.genes.results \
	R0_064/RSEM.genes.results \
	R0_065/RSEM.genes.results \
	R0_025/RSEM.genes.results \
	R0_027/RSEM.genes.results \
	R0_031/RSEM.genes.results \
	R0_034/RSEM.genes.results \
	R0_038/RSEM.genes.results \
	R0_040/RSEM.genes.results \
	R0_026/RSEM.genes.results \
	R0_030/RSEM.genes.results \
	R0_032/RSEM.genes.results \
	R0_033/RSEM.genes.results \
	R0_035/RSEM.genes.results \
	R0_039/RSEM.genes.results \
	R24_119/RSEM.genes.results \
	R24_120/RSEM.genes.results \
	R24_121/RSEM.genes.results \
	R24_129/RSEM.genes.results \
	R24_130/RSEM.genes.results \
	R24_131/RSEM.genes.results \
	R24_091/RSEM.genes.results \
	R24_093/RSEM.genes.results \
	R24_097/RSEM.genes.results \
	R24_100/RSEM.genes.results \
	R24_104/RSEM.genes.results \
	R24_106/RSEM.genes.results \
	R24_092/RSEM.genes.results \
	R24_096/RSEM.genes.results \
	R24_098/RSEM.genes.results \
	R24_101/RSEM.genes.results \
	R24_103/RSEM.genes.results \
	R24_105/RSEM.genes.results \
	R48_185/RSEM.genes.results \
	R48_186/RSEM.genes.results \
	R48_187/RSEM.genes.results \
	R48_194/RSEM.genes.results \
	R48_196/RSEM.genes.results \
	R48_197/RSEM.genes.results \
	R48_157/RSEM.genes.results \
	R48_159/RSEM.genes.results \
	R48_163/RSEM.genes.results \
	R48_166/RSEM.genes.results \
	R48_170/RSEM.genes.results \
	R48_172/RSEM.genes.results \
	R48_158/RSEM.genes.results \
	R48_162/RSEM.genes.results \
	R48_164/RSEM.genes.results \
	R48_165/RSEM.genes.results \
	R48_167/RSEM.genes.results \
	R48_171/RSEM.genes.results \
	R72_316/RSEM.genes.results \
	R72_317/RSEM.genes.results \
	R72_319/RSEM.genes.results \
	R72_327/RSEM.genes.results \
	R72_328/RSEM.genes.results \
	R72_329/RSEM.genes.results \
	R72_289/RSEM.genes.results \
	R72_291/RSEM.genes.results \
	R72_295/RSEM.genes.results \
	R72_300/RSEM.genes.results \
	R72_302/RSEM.genes.results \
	R72_304/RSEM.genes.results \
	R72_290/RSEM.genes.results \
	R72_294/RSEM.genes.results \
	R72_296/RSEM.genes.results \
	R72_297/RSEM.genes.results \
	R72_299/RSEM.genes.results \
	R72_303/RSEM.genes.results \

echo "Done ヽ(^O^)ノ"
