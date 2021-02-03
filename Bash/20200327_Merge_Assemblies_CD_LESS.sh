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

DIR_Work=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/DRAP/Hedin/Fasta/EggNog_filtered/
DIR_EVI=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/DRAP/Hedin/Fasta/Evigene_Fasta/eggNog_Filtered/

echo "Directionaries are loaded"

#########
# Files #
#########

H01=Flower_filtered.fasta
H02=Stem_filtered.fasta
H03=Young_Leaf_filtered.fasta
H04=Mature_Leaf_filtered.fasta
H05=Expression_Pods_filtered.fasta
H06=Expression_Seeds_filtered.fasta
H07=Filling_Pods_filtered.fasta
H08=Filling_Seeds_filtered.fasta
H09=Mix_Whole_filtered.fasta
H10=Roots_filtered.fasta

OUT=eggNog-filtered_DRAP_Hedin
RENAME=All_DRAP_Rename_Hedin.fasta

#=========================================================#
# OBS                                                     #
# Remember to edit the perl rename part, currently it is: #
# 'if(/\>/){$a++;print ">Hedin_$a\n"}else{print;}'        #
# Hedin                                                   #
#=========================================================#

echo "Files loaded"

#######
# Run #
#######

cd $DIR_Work
echo "Cat all the assemblies together"


cat $H01 $H02 $H03 $H04 $H05 $H06 $H07 $H08 $H09 $H10 > ${OUT}.fasta
echo "All the assemblies are cat together"

echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hedin_$a\n"}else{print;}' ${OUT}.fasta > $RENAME

cd $DIR_Work
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI${OUT}.tr -input $RENAME

echo "Done :-)"
