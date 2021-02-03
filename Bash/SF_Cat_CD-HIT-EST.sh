#!/bin/bash

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 10:00:00 -A norfab 'Scripts/Rarely_Used/Super_CD_hit.sh'

##################
# Directionaries #
##################

DIR_SF=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgSoftfilter
DIR_CD=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/MODES
M0=CD_0.95_W10

echo "Directionaries are loaded"

#########
# Files #
#########
# 159b
ASS_159b_combi=(\
SF_Evi_159b.okay.cds \
)

# 2378
ASS_2378_combi=(\
SF_Evi_2378.okay.cds \
)

# Hiverna
ASS_Hiv_combi=(\
SF_Evi_Hiv.okay.cds \
)

# Hedin
ASS_Hedin_combi=(\
SF_Evi_Hedin.okay.cds \
)

In=(\
SF_20200701.fa \
)

DIR_IND=(\
$DIR_SF \
)

CPU=8
NAME=(\
ModeSF.fa \
)

ROUNDS=1
WORD=10
# -o $DIR_CD${M0}_${In[f0]}

echo "Files loaded"


##########
# Source #
##########

source /com/extra/cd-hit/454/load.sh
echo "Sourced: CD-HIT-EST"

echo 'Cat the assemblies together'
for (( I = 0; I < $ROUNDS; ++I )); do
    [ -f ${DIR_IND[I]}/${ASS_159b_combi[I]} ] && echo "File exist" || echo "File does not exist"
    [ -f ${DIR_IND[I]}/${ASS_2378_combi[I]} ] && echo "File exist" || echo "File does not exist"
    [ -f ${DIR_IND[I]}/${ASS_Hiv_combi[I]} ] && echo "File exist" || echo "File does not exist"
    [ -f ${DIR_IND[I]}/${ASS_Hedin_combi[I]} ] && echo "File exist" || echo "File does not exist"
    cat ${DIR_IND[I]}/${ASS_159b_combi[I]} ${DIR_IND[I]}/${ASS_2378_combi[I]} ${DIR_IND[I]}/${ASS_Hiv_combi[I]} \
    ${DIR_IND[I]}/${ASS_Hedin_combi[I]} > $DIR_CD/${In[I]}
done

echo 'Running CD-HIT-EST'
for (( f = 0; f < $ROUNDS; ++f )); do
        cd-hit-est -i $DIR_CD/${In[f]} -o $DIR_CD/${NAME[f]} -c 0.95 -n $WORD -p 1 -g 1 -M 600000 -T $CPU \
        -d 40 1>$DIR_CD/${M0}_${NAME[f]}_Trinity_cd-hit-est_0.95.log 2>$DIR_CD/${M0}_${NAME[f]}_Trinity_cd-hit-est_0.95.err
done
echo 'CD-HIT-EST is done'

echo 'つ ◕_◕ つ  Done'
