#!/bin/bash

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 10:00:00 -A norfab 'Scripts/Rarely_Used/Super_CD_hit.sh'

##################
# Directionaries #
##################

DIR_IND=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/
DIR_CD=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/CD-HIT-EST/
M0=CD_0.95_W10

echo "Directionaries are loaded"

#########
# Files #
#########

In=(\
Evigene_4Cultivars_030919.fa \
)

CPU=8
NAME=M09
ROUNDS=1
WORD=10
# -o $DIR_CD${M0}_${In[f0]}

echo "Files loaded"


##########
# Source #
##########

source /com/extra/cd-hit/454/load.sh
echo "Sourced: CD-HIT-EST"


echo 'Running CD-HIT-EST'
for (( f = 0; f < $ROUNDS; ++f )); do
        cd-hit-est -i $DIR_IND${In[f]} -o $DIR_CD${NAME} -c 0.95 -n $WORD -p 1 -g 1 -M 600000 -T $CPU \
        -d 40 1>$DIR_CD${M0}_Trinity_cd-hit-est_0.95.log 2>$DIR_CD${M0}_Trinity_cd-hit-est_0.95.err
done
echo 'CD-HIT-EST is done'

echo 'Done ヽ(^O^)ノ'
