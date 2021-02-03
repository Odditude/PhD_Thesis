#!/bin/bash
# Version 2.0
# This Script is set out to test the quality of the assemblies.
# This is done by using BUSCO
# It is set to work in any directory.

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 01:00:00 -A norfab 'bash -i /home/leandro/Scripts/BUSCO_execution.sh'

#~~~~~~~~~~~~~~~~#
# Directionaries #
#~~~~~~~~~~~~~~~~#

DIR_IND=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8/DRAP/Hedin/Fasta/EggNog_filtered/
DIR_LIB=/home/leandro/busco/library/

echo 'Directories are loaded'

#~~~~~~~#
# Files #
#~~~~~~~#

CPU=8
FASTA=eggNog-filtered_DRAP_Hedin.fasta
LIBRARY=embryophyta_odb9
MODE=transcriptome
OUTPUT=eggNog-filtered_DRAP_Hedin

echo 'Files are loaded'

#~~~~~#
# Run #
#~~~~~#

echo 'Now running the script'

cd /home/leandro/busco
conda activate BUSCO
python /home/leandro/busco/scripts/run_BUSCO.py -i $DIR_IND$FASTA -o $OUTPUT -l $DIR_LIB$LIBRARY -m $MODE -c $CPU
conda deactivate

echo 'Done ヽ(^O^)ノ'
