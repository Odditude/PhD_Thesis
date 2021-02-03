#!/bin/bash

# Version 1.0
# This script helps filtering the fasta file via the abundance matrix. 
# This is done with a script from the Trinity package.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This script is designed to be run in the directionary where there results are stored.
# This is run with the script and not directly on the terminal to have a better footprint for later use.


DIR_MAT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/RSEM/All_Assemblies_Melodie_20181116.okay.cds.fa
DIR_TRA=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/Overassemblies

##########
# Source #
##########



#######
# Run #
#######


echo 'Now running the commands'

/home/leandro/miniconda3/envs/Trinity/opt/trinity-2.8.3/util/filter_low_expr_transcripts.pl \
        --matrix $DIR_MAT/RSEM.isoform.TMM.EXPR.matrix \
        --transcripts $DIR_TRA/All_Assemblies_Melodie_20181116.okay.cds \
	--min_expr_any 1

echo "Done ヽ(^O^)ノ"
