#!/bin/bash

# Version 1.0
# This script it used to prepare the assemblies for Evigene
# This is done with "trformat.pl"
# It might later include the EvidentalGene pipeline
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_IN=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8
DIR_OUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/Evigene

echo "Directionaries are loaded"


#########
# Files #
#########

NAME=(\
20181116_condA_trinity.Trinity \
20181105_condB_trinity.Trinity \
20181116_condC_trinity.Trinity \
20181116_condD_trinity.Trinity \
20181116_condE_trinity.Trinity \
20181116_condF_trinity.Trinity \
20181116_condG_trinity.Trinity \
20181116_condH_trinity.Trinity \
20181116_condI_trinity.Trinity \
20181116_condJ_trinity.Trinity \
20181116_condMc_trinity.Trinity \
20181116_condMt_trinity.Trinity \
20181116_condIc_trinity.Trinity \
20181116_condIt_trinity.Trinity \
20181116_cond159bFeu_trinity.Trinity \
20181116_cond159bFlo_NEW_trinity.Trinity \
20181116_cond159bGou_trinity.Trinity \
20181116_cond159bGrL_trinity.Trinity \
20181116_cond2378Feu_trinity.Trinity \
20181116_cond2378Flo_trinity.Trinity \
20181116_cond2378Gou_trinity.Trinity \
20181116_cond2378GrL_trinity.Trinity \
20181116_condHivFeu_trinity.Trinity \
20181116_condHivFlo_trinity.Trinity \
20181116_condHivGou_NEW_trinity.Trinity \
20181116_condHivGrL_trinity.Trinity \
)

ID=(\
condA \
condB \
condC \
condD \
condE \
condF \
condG \
condH \
condI \
condJ \
condMc \
condMt \
condIc \
condIt \
cond159bFeu \
cond159bFlo \
cond159bGou \
cond159bGrL \
cond2378Feu \
cond2378Flo \
cond2378Gou \
cond2378GrL \
condHivFeu \
condHivFlo \
condHivGou \
condHivGrL \
)

#=====#
# Run #
#=====#

for (( I = 0; I < 26; ++I )); do
	echo 'Begin'
	mkdir $DIR_OUT/${NAME[I]}
	echo 'Finished'
	perl -ane 'if(/\>/){$a++;print ">159b_$a\n"}else{print;}' All_Assemblies_159b.fasta > All_Rename_159b.fasta
	/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_OUT/${NAME[I]}/${NAME[I]}.tr -input $DIR_IN/${NAME[I]}.fasta
done

echo "Done ヽ(^O^)ノ"
