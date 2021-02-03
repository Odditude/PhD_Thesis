#!/bin/bash

# Version 1.0
# This Script is set out to create SuperTranscripts.
# Cores needs to be specified.
# It is set to work in any directory.
# Remember to 'source activate lace' first

# qx --no-scratch -c 8 -t 05:00:00 -A norfab '/home/leandro/Scripts/Lace_Run.sh'

#~~~~~~~~~~~~~~~~#
# Directionaries #
#~~~~~~~~~~~~~~~~#
DIR_FAS=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/Evigene/
DIR_GRO=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/Evigene/Salmon/Output/
DIR_OUT=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/SuperTranscript/

echo 'Directories are loaded'

#~~~~~~~#
# Files #
#~~~~~~~#

FASTA=M10_Evigene.okay.cds
CLUSTERS=clusters.txt
CORES=8
NAME=M10
Grouper='No'
echo "Files are loaded"


source /home/leandro/miniconda3/etc/profile.d/conda.sh

#~~~~~#
# Run #
#~~~~~#

echo 'Starting the Script'
echo 'Activating the envirronment'

#conda activate SuperTranscript

if [ $Grouper == 'Yes' ]
then
	echo
	echo 'Grouper mode activated'
	echo
fi

echo 'Now running SuperTranscript'

python /home/leandro/bin/Lace-1.13/Lace.py $DIR_FAS$FASTA $DIR_GRO$CLUSTERS --cores $CORES -t --outputDir $DIR_OUT


echo '{$NAME}' > $DIR_GRO$NAME.txt
#mv $DIR_OUT/SuperDuper.fasta $DIR_OUT/$NAME_SuperDuper.fasta
#mv $DIR_OUT/SuperDuper.gff $DIR_OUT/$NAME_SuperDuper.gff

#conda deactivate

echo "Done ヽ(^O^)ノ"




# awk -F'\t' '{ t=$1 ; $1=$2; $2=t; print }' OFS='\t' mag.flat.clust > SWAP_mag.flat.clust
