#!/bin/bash

# Version 1.0
# Script of finding how many of the SNPs that maps back to the assembly.
# This is done with bowtie 2.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/
# Introduced blanklines() function, and change a blank line into a line of "---"

##################
# Directionaries #
##################

DIR_INDEX=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Index/
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Output/
READS=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/TE/All_Assemblies_AI.filtered.01.fa
INDEX=All_Assemblies_AI.filtered.01.fa
OUTPUT=All_Assemblies_AI.filtered.01.fa_align_stats.txt
A=Deepti_variant_GBS.fasta
B=SNP_variant_GBS.fasta

# Here A is an array of the left reads, whereas B is an array of the right reads.

echo "Files loaded"

#############
# Functions #
#############

# This creates a blank line and puts it into the output file
blankline()
{
        echo | tee -a $DIR_OUTPUT$OUTPUT
}

##########
# Source #
##########

source /com/extra/bowtie2/2.2.8/load.sh
source /com/extra/express/1.3.1/load.sh
source /com/extra/samtools/1.6.0/load.sh
echo "Sourced: Bowtie2, eXpress and samTOOLS"

#######
# Run #
#######

#echo "Creating the directionary for the index"
#mkdir $DIR_INDEX$INDEX

#echo "Bowtie2 will now build the index"

#bowtie2-build $INPUT $DIR_INDEX${INDEX}/$INDEX

echo "Bowtie2 will now map the reads back to the assembly they created"


blankline
echo "This is how many of the Deepti's Chips are found in the $INDEX assembly"
echo "-----------------------------------------------------------------------------------------------------"
bowtie2 -p 10 -f -x $DIR_INDEX${INDEX}/$INDEX -U $READS$A | samtools view -bSh | samtools sort > $DIR_OUTPUT${INDEX}.{A}.bam
blankline
echo "How many unique genes?"
samtools view $DIR_OUTPUT${INDEX}.{A}.bam | cut -f 3 | sort | uniq | wc -l
blankline

echo "This is how many of the Deepti's Chips are found in the $INDEX assembly with 1 mismatches allowed in the seed"
echo "-----------------------------------------------------------------------------------------------------"
bowtie2 -p 10 -f -x $DIR_INDEX${INDEX}/$INDEX -U $READS$A | samtools view -bSh | samtools sort > $DIR_OUTPUT${INDEX}.{A}.mis.bam
blankline
echo "How many unique genes?"
samtools view $DIR_OUTPUT${INDEX}.{A}.mis.bam | cut -f 3 | sort | uniq | wc -l
blankline

echo "This is how many of the SNPs are found in the $INDEX assembly"
echo "-----------------------------------------------------------------------------------------------------"
bowtie2 -p 10 -f -x $DIR_INDEX${INDEX}/$INDEX -U $READS$B | samtools view -bSh | samtools sort > $DIR_OUTPUT${INDEX}.{B}.bam
blankline
echo "How many unique genes?"
samtools view $DIR_OUTPUT${INDEX}.{B}.bam | cut -f 3 | sort | uniq | wc -l
blankline

echo "This is how many of the SNPs are found in the $INDEX assembly with 1 mismatches allowed in the seed"
echo "-----------------------------------------------------------------------------------------------------"
bowtie2 -p 10 -f -x $DIR_INDEX${INDEX}/$INDEX -U $READS$B | samtools view -bSh | samtools sort > $DIR_OUTPUT${INDEX}.{B}.mis.bam
blankline
echo "How many unique genes?"
samtools view $DIR_OUTPUT${INDEX}.{B}.mis.bam | cut -f 3 | sort | uniq | wc -l


echo "Done :)"

