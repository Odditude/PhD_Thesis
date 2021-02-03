# Version 1.0
# This script does NOT reduce transcript redundancy
# This used to be done with "cd-hit-est", see 'Merge_Assemblies.sh' for the old way
# Now it only combines the fasta files and prepares them for Evigene. 
# It might later include the EvidentalGene pipeline
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_Work=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/DRAP-original
DIR_EVI=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgDRAP

echo "Directionaries are loaded"

#########
# Files #
#########

BIN_159b=(\
159b_flower_bin.fa \
159b_leaf_bin.fa \
159b_pod_bin.fa \
159b_seed_bin.fa \
)

TRI_159b=(\
159b_flower_tri.fa \
159b_leaf_tri.fa \
159b_pod_tri.fa \
159b_seed_tri.fa \
)

OUT=All_DRAP_Hedin
RENAME=All_DRAP_Rename_Hedin.fasta

#=========================================================#
# OBS                                                     #
# Remember to edit the perl rename part, currently it is: #
# 'if(/\>/){$a++;print ">Hedin_$a\n"}else{print;}'        #
#=========================================================#

echo "Files loaded"

#######
# Run #
#######

cd $DIR_Work
echo "Cat all the assemblies together"


for (( I = 0; I < $ROUNDS; ++I )); do
	echo "cat $DIR_Work/${BIN_159b[I]} $DIR_Work/${TRI_159b[I]}" 
	cat $DIR_Work/${BIN_159b[I]} $DIR_Work/${TRI_159b[I]} >
	echo "Rename the files"
	perl -ane 'if(/\>/){$a++;print ">Hedin_$a\n"}else{print;}' ${OUT}.fasta > $RENAME

cd $DIR_Work
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI${OUT}.tr -input $RENAME

echo "Done :-)"
