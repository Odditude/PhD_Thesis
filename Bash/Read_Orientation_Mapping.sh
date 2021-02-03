#!/bin/bash

# Version 1.0
# This Script helps finding the read orientation for strand specific reads. 
# This Script prepares the files for IGV.   
# This is done with bowtie 2. 
# The reads are mapped to an assembly that has previously been created.  
# How many nodes, cores and amount of time is set in the terminal and not here. 
# This Script is designed to be run where ever. 

##################
# Directionaries #
##################

DIR_INDEX=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Index_Bowtie/
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Read_Orientation/All_Assemblies_AI.okay.cds/
READS=/faststorage/project/norfab/20181023_INRA/

echo "Directionaries are loaded"

#########
# Files #
#########

FASTA=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Overassemblies/All_Assemblies_AI.okay.cds
INDEX=All_Assemblies_AI.okay_Index
OUTPUT=159b-Feu-1-reads
LEFT=159b-Feu-1_ATCACG_L003_BFC_R1_paired.fastq.gz
RIGHT=159b-Feu-1_ATCACG_L003_BFC_R2_paired.fastq.gz

echo "Files loaded"

##########
# Source #
##########

source /com/extra/bowtie2/2.2.8/load.sh
source /com/extra/samtools/1.6.0/load.sh
echo "Sourced: Bowtie2 and Samtools"

#######
# Run #
#######

echo "For mapping we used the already established assembly index $INDEX "
bowtie2 -q -p 10 -x $DIR_INDEX$INDEX -1 $READS$LEFT -2 $READS$RIGHT -S $DIR_OUTPUT${OUTPUT}.sam

echo "Converting the output from sam to the bam format."
samtools view -bS $DIR_OUTPUT${OUTPUT}.sam > $DIR_OUTPUT${OUTPUT}.bam

echo "Sort the bam file according to the left most coordinate"
samtools sort $DIR_OUTPUT${OUTPUT}.sam -o $DIR_OUTPUT${OUTPUT}.sorted.bam

echo "Indexing the sorted bam file"
samtools index $DIR_OUTPUT${OUTPUT}.sorted.bam

echo "Indexing the fasta file from the chosen assembly"
samtools faidx $FASTA

echo "Now you have the input files for IGV"
echo "Load genome: index of $FASTA"
echo "Load file: index of index ${OUTPUT}.sorted.bam"
echo

echo "Done :)"
