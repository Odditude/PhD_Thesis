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

DIR_Work=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/SoftFilter
DIR_EVI=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgSoftfilter

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

BIN_159b_Flower=SF_Hiv_flower_bin.fa
BIN_159b_Leaf=SF_Hiv_leaf_bin.fa
BIN_159b_Pod=SF_Hiv_pod_bin.fa
BIN_159b_Seed=SF_Hiv_seed_bin.fa

TRI_159b_Flower=SF_Hiv_flower_tri.fa
TRI_159b_Leaf=SF_Hiv_leaf_tri.fa
TRI_159b_Pod=SF_Hiv_pod_tri.fa
TRI_159b_Seed=SF_Hiv_seed_tri.fa

OUT_159b_Flower=SF_Evi_Hiv_Flower
OUT_159b_Leaf=SF_Evi_Hiv_Leaf
OUT_159b_Pod=SF_Evi_Hiv_Pod
OUT_159b_Seed=SF_Evi_Hiv_Seed

PERLS_159b=(\
'if(/\>/){$a++;print ">Hiverna_Flower_$a\n"}else{print;}' \
'if(/\>/){$a++;print ">Hiverna_Leaf_$a\n"}else{print;}' \
'if(/\>/){$a++;print ">Hiverna_Pod_$a\n"}else{print;}' \
'if(/\>/){$a++;print ">Hiverna_Seed_$a\n"}else{print;}' \
)

RENAME_159b_Flower=RENAME_SF_Hiv_Flower.fa
RENAME_159b_Leaf=RENAME_SF_Hiv_Leaf.fa
RENAME_159b_Pod=RENAME_SF_Hiv_Pod.fa
RENAME_159b_Seed=RENAME_SF_Hiv_Seed.fa

echo "Files loaded"

#=====#
# Run #
#=====#

echo "Cat all the assemblies together"


echo "cat $DIR_Work/${BIN_159b_Flower} $DIR_Work/${TRI_159b_Flower}" 
cat $DIR_Work/${BIN_159b_Flower} $DIR_Work/${TRI_159b_Flower} > $DIR_EVI/${OUT_159b_Flower}.fasta
echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hiverna_Flower_$a\n"}else{print;}' $DIR_EVI/${OUT_159b_Flower}.fasta > $DIR_EVI/${RENAME_159b_Flower}
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI/${OUT_159b_Flower}.tr -input $DIR_EVI/${RENAME_159b_Flower}


echo 

echo "cat $DIR_Work/${BIN_159b_Leaf} $DIR_Work/${TRI_159b_Leaf}"
cat $DIR_Work/${BIN_159b_Leaf} $DIR_Work/${TRI_159b_Leaf} > $DIR_EVI/${OUT_159b_Leaf}.fasta
echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hiverna_Leaf_$a\n"}else{print;}' $DIR_EVI/${OUT_159b_Leaf}.fasta > $DIR_EVI/${RENAME_159b_Leaf}
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI/${OUT_159b_Leaf}.tr -input $DIR_EVI/${RENAME_159b_Leaf}

echo

echo "cat $DIR_Work/${BIN_159b_Pod} $DIR_Work/${TRI_159b_Pod}"
cat $DIR_Work/${BIN_159b_Pod} $DIR_Work/${TRI_159b_Pod} > $DIR_EVI/${OUT_159b_Pod}.fasta
echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hiverna_Pod_$a\n"}else{print;}' $DIR_EVI/${OUT_159b_Pod}.fasta > $DIR_EVI/${RENAME_159b_Pod}
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI/${OUT_159b_Pod}.tr -input $DIR_EVI/${RENAME_159b_Pod}

echo 

echo "cat $DIR_Work/${BIN_159b_Seed} $DIR_Work/${TRI_159b_Seed}"
cat $DIR_Work/${BIN_159b_Seed} $DIR_Work/${TRI_159b_Seed} > $DIR_EVI/${OUT_159b_Seed}.fasta
echo "Rename the files"
perl -ane 'if(/\>/){$a++;print ">Hiverna_Seed_$a\n"}else{print;}' $DIR_EVI/${OUT_159b_Seed}.fasta > $DIR_EVI/${RENAME_159b_Seed}
echo "TR format the files"
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_EVI/${OUT_159b_Seed}.tr -input $DIR_EVI/${RENAME_159b_Seed}
