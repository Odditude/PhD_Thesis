#!/bin/bash

# Version 1.2
# Script of finding how many of the reads that maps back to the assembly.
# This is done with bowtie 2.
# The reads you map back are the same reads used to generate the assembly.
# This is used as a quality measure. Ideally we want atleast 80 % to be mapped back.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/
# Introduced blanklines() function, and change a blank line into a line of "---"

##################
# Directionaries #
##################

DIR_INDEX=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Index/
DIR_OUTPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/RNA_Seq_Read_Representation/Output/
READS=/faststorage/project/norfab/20180621_Marcin_complexity_reduction/C101HW18051514/raw_data/Reads/

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/Overassemblies/20171020_Cond_all.okay.cds.fa
INDEX=20171012_Cond_all
OUTPUT=CondAll_Complex_align_stats.txt
A=(D1_160_DSFP07947-V_HMY5GCCXY_L3_1.fq D1_1_DSFP07951-V_HN2MCCCXY_L5_1.fq D2_DSFP07946-V_HMY5GCCXY_L7_1.fq D3_DSFP07948-V_HMY5GCCXY_L3_1.fq D4_DSFP07949-V_HMY5GCCXY_L3_1.fq \
D5_DSFP07952-V_HMY5GCCXY_L3_1.fq D6_DSFP07950-V_HMY5GCCXY_L3_1.fq D7_DSFP07953-V_HN2MCCCXY_L5_1.fq)
B=(D1_160_DSFP07947-V_HMY5GCCXY_L3_2.fq D1_1_DSFP07951-V_HN2MCCCXY_L5_2.fq D2_DSFP07946-V_HMY5GCCXY_L7_2.fq D3_DSFP07948-V_HMY5GCCXY_L3_2.fq D4_DSFP07949-V_HMY5GCCXY_L3_2.fq \
D5_DSFP07952-V_HMY5GCCXY_L3_2.fq D6_DSFP07950-V_HMY5GCCXY_L3_2.fq D7_DSFP07953-V_HN2MCCCXY_L5_2.fq)

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
echo "Sourced: Bowtie2"

#######
# Run #
#######

echo "Creating the directionary for the index"
mkdir $DIR_INDEX$INDEX

echo "Bowtie2 will now build the index"

bowtie2-build $INPUT $DIR_INDEX${INDEX}/$INDEX

echo "Bowtie2 will now map the reads back to the assembly they created"


for (( I = 0; I < 8; ++I )); do
        blankline
        echo "This is the RNA-seq read representation from ${A[I]} and ${B[I]} of the $INDEX assembly" | tee -a $DIR_OUTPUT$OUTPUT
        echo "-------------------------------------------------------------------------------------------" | tee -a $DIR_OUTPUT$OUTPUT
        bowtie2 -p 10 -q -x $DIR_INDEX${INDEX}/$INDEX -1 $READS${A[I]} -2 $READS${B[I]}  \
                2>&1 1> /dev/null | tee -a $DIR_OUTPUT$OUTPUT
        blankline
done

echo "Done :)"

