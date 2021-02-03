# Version 1.0
# This script it used to reduce transcript redundancy
# This is done with "cd-hit-est"
# It might later include the EvidentalGene pipeline
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/
# Includes blanklines() function and it might get removed later on

##################
# Directionaries #
##################

DIR_Work=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20181116_Trinity_v2.8
DIR_CD=CD_HIT_EST_0.95

echo "Directionaries are loaded"

#########
# Files #
#########

In=(\
20181116_cond159bFeu_trinity.Trinity.fasta \
20181116_cond159bFlo_NEW_trinity.Trinity.fasta \
20181116_cond159bGou_trinity.Trinity.fasta \
20181116_cond159bGrL_trinity.Trinity.fasta \
)

CPU=16

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

source /com/extra/cd-hit/454/load.sh
echo "Sourced: CD-HIT"

#######
# Run #
#######

cd $DIR_Work
#mkdir $DIR_CD 
echo "Removing redundant transcripts with CD-HIT-EST"
###EDIT###

for (( f = 0; f < 4; ++f )); do
	cd-hit-est -i ${In[f]} -o $DIR_CD/CD_${In[f]} -c 0.95 -n 8 -p 1 -g 1 -M 600000 -T $CPU \
	-d 40 1>Trinity_cd-hit-est_0.95.log 2>Trinity_cd-hit-est_0.95.err
done
echo "CD-HIT-EST is done"
blankline

echo "Cat all the assemblies together"
cd $DIR_CD 
###EDIT###
cat *.fasta > All_Assemblies_159b.fasta
echo "All the assemblies are cat together"
blankline

###EDIT###
perl -ane 'if(/\>/){$a++;print ">159b_$a\n"}else{print;}' All_Assemblies_159b.fasta > All_Rename_159b.fasta

cd $DIR_Work
###EDIT###
/home/leandro/evigene/scripts/rnaseq/trformat.pl -output Overassemblies/All_Assemblies_159b_20181116.tr -input $DIR_CD/All_Rename_159b.fasta

echo "Done :-)"
