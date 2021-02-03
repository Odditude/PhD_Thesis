#!/bin/bash
# Version 1.0
# Simple Script to quickly run Evigene
# It is set to work in any directory.


#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 4 -t 01:00:00 -A norfab '/home/leandro/Scripts/Evigene_Solo.sh'
# qx --no-scratch -c 16 -t 24:00:00 -A norfab 'evigene/scripts/prot/tr2aacds_qsub.sh'

#~~~~~~~~~~~~~~~~#
# Directionaries #
#~~~~~~~~~~~~~~~~#

DIR_IND=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/
DIR_OUT=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/Evigene/


echo 'Directories are loaded'

#~~~~~~~#
# Files #
#~~~~~~~#

FASTA=Evigene_4Cultivars_030919.fa
OUTPUT=M10_Evigene.tr

echo 'Files are loaded'

#~~~~~#
# Run #
#~~~~~#

echo 'Now running the script'

/home/leandro/evigene/scripts/rnaseq/trformat.pl -output $DIR_OUT$OUTPUT -input $DIR_IND$FASTA

echo 'Remember to use the tr2aacds_qsub.sh script to finish the job!'

echo 'Done ヽ(^O^)ノ'
