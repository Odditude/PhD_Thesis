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

DIR_Work=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/DRAP-original
DIR_EVI=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgDRAP

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

#~~~~~~~#
# Hedin #
Hedin_ExPods=hedin_expansionPod.fa
Hedin_ExSeeds=hedin_expansionSeed.fa
Hedin_FillPods=hedin_fillingPod.fa
Hedin_FillSeeds=hedin_fillingSeed.fa
Hedin_Flower=hedin_flower.fa
Hedin_MatLeaf=hedin_matureLeaf.fa
Hedin_MixWhole=hedin_whole.fa
Hedin_Roots=hedin_roots.fa
Hedin_Stem=hedin_stem.fa
Hedin_YoungLeaf=hedin_youngLeaf.fa

OUT_Hedin=DRAP_Hedin
RENAME_Hedin=RENAME_DRAP_Hedin.fa

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


