#!/bin/bash

# Version 1.0
# Script of general execution of BLAST-ing for a certain gene. 
# How many nodes, cores and amount of time is set in the terminal and not here.
# To do a local BLAST you need to make a database, and the fasta files needs a distinct header. 
# This Script is designed to be run in any directionary. 

##################
# Directionaries #
##################

#Static
Dir_DB=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/BlastTrinity/DB/
Dir_Output=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/BlastTrinity/Results/
Local=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/BlastTrinity/lcl_Input/
Dir_Query=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/BlastTrinity/Query/

#Dynamic
Fasta=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/BWA-mem/TQ_T01_Orig/
echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=All_Assemblies_AI.filtered.nocarriage.01.fa
OUTPUT=VC1.All_Assemblies_AI.filtered.nocarriage.01.fa.txt
QUERY=VC1.fasta
TYPE=nucl

echo "Files loaded"

##########
# Source #
##########

#source /com/extra/BLAST/2.6.0/load.sh
echo "Blast already in environment"
echo "Sourced: BLAST"

#######
# Run #
#######


echo "Change header to the more appropriate 'lcl|'"
sed 's/>/&lcl|/' <$Fasta$INPUT >${Local}lcl.$INPUT
echo

echo "Make folder for db of $INPUT"
mkdir $Dir_DB$INPUT

echo 'Make the local database of lcl.$INDEX'
makeblastdb -in ${Local}lcl.$INPUT -parse_seqids -dbtype $TYPE -out $Dir_DB$INPUT/lcl.$INPUT
# Omit if allready created. 
echo

echo "And now to BLAST'ing of $INPUT"
tblastx -query $Dir_Query$QUERY -db $Dir_DB$INPUT/lcl.$INPUT -out $Dir_Output$OUTPUT
echo

echo 'Done :)' 

