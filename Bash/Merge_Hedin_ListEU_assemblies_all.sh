#!/bin/bash

# Version 1.0
# This script does NOT reduce transcript redundancy
# This used to be done with "cd-hit-est", see 'Merge_Assemblies.sh' for the old way
# Now it only combines the fasta files and prepares them for Evigene.
# It might later include the EvidentalGene pipeline
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

#================#
# Directionaries #
#================#

DIR_Work=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/List-EU
DIR_EVI=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgListEU

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

#~~~~~~~#
# Hedin #
Hedin_ExPods=ListEU-DRAP_Hedin_ExpansionPods.fasta
Hedin_ExSeeds=ListEU-DRAP_Hedin_ExpansionPods.txt
Hedin_FillPods=ListEU-DRAP_Hedin_FillingPods.fasta
Hedin_FillSeeds=ListEU-DRAP_Hedin_FillingSeeds.fasta
Hedin_Flower=ListEU-DRAP_Hedin_Flower.fasta
Hedin_MatLeaf=ListEU-DRAP_Hedin_MatureLeafs.fasta
Hedin_MixWhole=ListEU-DRAP_Hedin_Whole.fasta
Hedin_Roots=ListEU-DRAP_Hedin_Roots.fasta
Hedin_Stem=ListEU-DRAP_Hedin_Stem.fasta
Hedin_YoungLeaf=ListEU-DRAP_Hedin_YoungLeaf.fasta

OUT_Hedin=ListEU_Hedin
RENAME_Hedin=RENAME_ListEU_Hedin.fa

echo "Files loaded"

#=====#
# Run #
#=====#

echo "Cat all the assemblies together"
cat $DIR_Work/${Hedin_ExPods} $DIR_Work/${Hedin_ExSeeds} $DIR_Work/${Hedin_FillPods} $DIR_Work/${Hedin_FillSeeds} \
$DIR_Work/${Hedin_Flower} $DIR_Work/${Hedin_MatLeaf} $DIR_Work/${Hedin_MixWhole} $DIR_Work/${Hedin_Roots} \
$DIR_Work/${Hedin_Stem} $DIR_Work/${Hedin_YoungLeaf} > $DIR_EVI/${OUT_Hedin}.fasta
echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hedin_$a\n"}else{print;}' $DIR_EVI/${OUT_Hedin}.fasta > $DIR_EVI/${RENAME_Hedin}
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI/${OUT_Hedin}.tr -input $DIR_EVI/${RENAME_Hedin}

echo
echo "つ ◕_◕ つ  Done"


