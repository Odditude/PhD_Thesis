#!/bin/bash

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 10:00:00 -A norfab 'Scripts/Rarely_Used/Super_CD_hit.sh'

#================#
# Directionaries #
#================#

DIR_IND=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/DRAP-original/
DIR_CD=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/DRAP-original/
M0=CD_0.95_W10

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

ASS_ExPods=hedin_expansionPod.fa
ASS_ExSeeds=hedin_expansionSeed.fa
ASS_FillPods=hedin_fillingPod.fa
ASS_FillSeeds=hedin_fillingSeed.fa
ASS_Flower=hedin_flower.fa
ASS_MatLeaf=hedin_matureLeaf.fa
ASS_MixWhole=hedin_whole.fa
ASS_Roots=hedin_roots.fa
ASS_Stem=hedin_stem.fa
ASS_YoungLeaf=hedin_youngLeaf.fa

FASTA_Hedin=DRAP_Hedin_CatAll.fa

In=(\
$FASTA_Hedin \
)

CPU=8
NAME=DRAP_Hedin
ROUNDS=1
WORD=10
# -o $DIR_CD${M0}_${In[f0]}

echo "Files loaded"


#========#
# Source #
#========#

source /com/extra/cd-hit/454/load.sh
echo "Sourced: CD-HIT-EST"

cat $DIR_IND${ASS_ExPods} $DIR_IND${ASS_ExSeeds} $DIR_IND${ASS_FillPods} $DIR_IND${ASS_FillSeeds} \
$DIR_IND${ASS_Flower} $DIR_IND${ASS_MatLeaf} $DIR_IND${ASS_MixWhole} $DIR_IND${ASS_Roots} $DIR_IND${ASS_Stem} \
$DIR_IND${ASS_YoungLeaf} > $DIR_IND${FASTA_Hedin}

echo 'Running CD-HIT-EST'
for (( f = 0; f < $ROUNDS; ++f )); do
        cd-hit-est -i $DIR_IND${In[f]} -o $DIR_CD${NAME} -c 0.95 -n $WORD -p 1 -g 1 -M 600000 -T $CPU \
        -d 40 1>$DIR_CD${M0}_Trinity_cd-hit-est_0.95.log 2>$DIR_CD${M0}_Trinity_cd-hit-est_0.95.err
done
echo 'CD-HIT-EST is done'

echo 'つ ◕_◕ つ  Done'

