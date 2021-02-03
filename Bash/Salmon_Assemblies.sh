#!/bin/bash

# Version 1.0
# This script it used to map the Salmon reads for Grouper  
# This need to flags; --dumEq and --writeOrphanLinks
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

#================#
# Directionaries #
#================#

DIR_ASS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8
DIR_IND=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/Salmon/Index
DIR_OUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/Salmon/Output
DIR_REA=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/unzip_files

echo "Directionaries are loaded"

#========#
# Source #
#========#

echo "Salmon is already installed"

#=======#
# Files #
#=======#

i=Index_20181116_condI_trinity.Trinity.fasta
j=(\
R25_1.fq \
R26_1.fq \
)

k=(\
R25_2.fq \
R26_2.fq \
)
T=20181116_condI_trinity.Trinity.fasta

NAME=(\
CondI_R25_quant \
CondI_R26_quant \
)

#=====#
# Run #
#=====#

echo "Making the Index"
salmon index -t $DIR_ASS/$T -i $DIR_IND/$i
echo "Done"

for (( I = 0; I < 2; ++I )); do
	echo "Quantifying ${NAME[I]}"
	salmon quant --gcBias -l A --dumpEq --writeOrphanLinks --validateMappings -p 10 -i $DIR_IND/$i -1 $DIR_REA/${j[I]} -2 $DIR_REA/${k[I]} -o $DIR_OUT/${NAME[I]}
	echo "Done"
done

echo "Done ヽ(^O^)ノ"
