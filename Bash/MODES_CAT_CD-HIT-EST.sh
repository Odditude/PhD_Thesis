#!/bin/bash

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 10:00:00 -A norfab 'Scripts/Rarely_Used/Super_CD_hit.sh'

##################
# Directionaries #
##################

DIR_DRAP=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgDRAP
DIR_ListE=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgListE
DIR_ListEU=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgListEU
DIR_CD=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/MODES
M0=CD_0.95_W10

echo "Directionaries are loaded"

#########
# Files #
#########
# 159b
ASS_159b_combi=(\
DRAP_159b_Evg.okay.cds \
DRAP_159b_Evg.okay.cds \
ListE_159b_Evg.okay.cds \
ListE_159b_Evg.okay.cds \
ListEU_159b_Evg.okay.cds \
ListEU_159b_Evg.okay.cds \
)
# 2378
ASS_2378_combi=(\
DRAP_2378_Evg.okay.cds \
DRAP_2378_Evg.okay.cds \
ListE_2378_Evg.okay.cds \
ListE_2378_Evg.okay.cds \
ListEU_2378_Evg.okay.cds \
ListEU_2378_Evg.okay.cds \
)

# Hiverna
ASS_Hiv_combi=(\
DRAP_Hiv_Evg.okay.cds \
DRAP_Hiv_Evg.okay.cds \
ListE_Hiv_Evg.okay.cds \
ListE_Hiv_Evg.okay.cds \
ListEU_Hiv_Evg.okay.cds \
ListEU_Hiv_Evg.okay.cds \
)

# Hedin
ASS_Hedin_combi=(\
DRAP_Hedin.okay.cds \
DRAP_Hedin_CD.fa \
ListE_Hedin.okay.cds \
ListE_Hedin_CD.fasta \
ListEU_Hedin.okay.cds \
ListEU_Hedin_CD.fasta \
)

In=(\
Mode01_DRAP_Evg_20200515.fa \
Mode02_DRAP_CD_20200515.fa \
Mode03_ListE_Evg_20200515.fa \
Mode04_ListE_CD_20200515.fa \
Mode05_ListEU_Evg_20200515.fa \
Mode06_ListEU_CD_20200515.fa \
)

DIR_IND=(\
$DIR_DRAP \
$DIR_DRAP \
$DIR_ListE \
$DIR_ListE \
$DIR_ListEU \
$DIR_ListEU \
)

CPU=8
NAME=(\
Mode01.fa \
Mode02.fa \
Mode03.fa \
Mode04.fa \
Mode05.fa \
Mode06.fa \
)

ROUNDS=6
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



