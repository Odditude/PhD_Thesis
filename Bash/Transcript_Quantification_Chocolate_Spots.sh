#!/bin/bash

# Version 1.1
# Script of quantifying the read counts.
# This is done with bowtie 2.
# The reads you map back are the same reads used to generate the assembly.
# You then count how often reads map to each transcript.
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

##################
# Directionaries #
##################

DIR_INPUT=/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/20170917_Trinity_rep_Pacbio_CondA_I/TE
DIR_OUTPUT=/faststorage/project/norfab/20191204_Chocolate_Spots/RSEM/Transcriptome_Hedin_V1
DIR_SCRIPT=/home/leandro/Scripts/Others
READS=/faststorage/project/norfab/20191204_Chocolate_Spots

echo "Directionaries are loaded"

#########
# Files #
#########

INPUT=All_Assemblies_AI.filtered.nocarriage.01.fa
A=(\
#R_52_1.fq.gz \
#R_53_1.fq.gz \
#R_55_1.fq.gz \
#R_62_1.fq.gz \
#R_64_1.fq.gz \
#R_65_1.fq.gz \
#R_25_1.fq.gz \
#R_27_1.fq.gz \
#R_31_1.fq.gz \
#R_34_1.fq.gz \
#R_38_1.fq.gz \
#R_40_1.fq.gz \
#R_26_1.fq.gz \
#R_30_1.fq.gz \
#R_32_1.fq.gz \
#R_33_1.fq.gz \
#R_35_1.fq.gz \
#R_39_1.fq.gz \
#R_119_1.fq.gz \
#R_120_1.fq.gz \
#R_121_1.fq.gz \
#R_129_1.fq.gz \
#R_130_1.fq.gz \
#R_131_1.fq.gz \
#R_91_1.fq.gz \
#R_93_1.fq.gz \
#R_97_1.fq.gz \
#R_100_1.fq.gz \
#R_104_1.fq.gz \
#R_106_1.fq.gz \
#R_92_1.fq.gz \
#R_96_1.fq.gz \
#R_98_1.fq.gz \
#R_101_1.fq.gz \
#R_103_1.fq.gz \
#R_105_1.fq.gz \
#R_185_1.fq.gz \
#R_186_1.fq.gz \
#R_187_1.fq.gz \
#R_194_1.fq.gz \
#R_196_1.fq.gz \
#R_197_1.fq.gz \
#R_157_1.fq.gz \
#R_159_1.fq.gz \
#R_163_1.fq.gz \
#R_166_1.fq.gz \
#R_170_1.fq.gz \
#R_172_1.fq.gz \
#R_158_1.fq.gz \
#R_162_1.fq.gz \
#R_164_1.fq.gz \
#R_165_1.fq.gz \
#R_167_1.fq.gz \
#R_171_1.fq.gz \
#R_316_1.fq.gz \
#R_317_1.fq.gz \
#R_319_1.fq.gz \
#R_327_1.fq.gz \
#R_328_1.fq.gz \
#R_329_1.fq.gz \
#R_289_1.fq.gz \
#R_291_1.fq.gz \
#R_295_1.fq.gz \
#R_300_1.fq.gz \
#R_302_1.fq.gz \
#R_304_1.fq.gz \
#R_290_1.fq.gz \
R_294_1.fq.gz \
R_296_1.fq.gz \
R_297_1.fq.gz \
R_299_1.fq.gz \
R_303_1.fq.gz \
)

B=(\
#R_52_2.fq.gz \
#R_53_2.fq.gz \
#R_55_2.fq.gz \
#R_62_2.fq.gz \
#R_64_2.fq.gz \
#R_65_2.fq.gz \
#R_25_2.fq.gz \
#R_27_2.fq.gz \
#R_31_2.fq.gz \
#R_34_2.fq.gz \
#R_38_2.fq.gz \
#R_40_2.fq.gz \
#R_26_2.fq.gz \
#R_30_2.fq.gz \
#R_32_2.fq.gz \
#R_33_2.fq.gz \
#R_35_2.fq.gz \
#R_39_2.fq.gz \
#R_119_2.fq.gz \
#R_120_2.fq.gz \
#R_121_2.fq.gz \
#R_129_2.fq.gz \
#R_130_2.fq.gz \
#R_131_2.fq.gz \
#R_91_2.fq.gz \
#R_93_2.fq.gz \
#R_97_2.fq.gz \
#R_100_2.fq.gz \
#R_104_2.fq.gz \
#R_106_2.fq.gz \
#R_92_2.fq.gz \
#R_96_2.fq.gz \
#R_98_2.fq.gz \
#R_101_2.fq.gz \
#R_103_2.fq.gz \
#R_105_2.fq.gz \
#R_185_2.fq.gz \
#R_186_2.fq.gz \
#R_187_2.fq.gz \
#R_194_2.fq.gz \
#R_196_2.fq.gz \
#R_197_2.fq.gz \
#R_157_2.fq.gz \
#R_159_2.fq.gz \
#R_163_2.fq.gz \
#R_166_2.fq.gz \
#R_170_2.fq.gz \
#R_172_2.fq.gz \
#R_158_2.fq.gz \
#R_162_2.fq.gz \
#R_164_2.fq.gz \
#R_165_2.fq.gz \
#R_167_2.fq.gz \
#R_171_2.fq.gz \
#R_316_2.fq.gz \
#R_317_2.fq.gz \
#R_319_2.fq.gz \
#R_327_2.fq.gz \
#R_328_2.fq.gz \
#R_329_2.fq.gz \
#R_289_2.fq.gz \
#R_291_2.fq.gz \
#R_295_2.fq.gz \
#R_300_2.fq.gz \
#R_302_2.fq.gz \
#R_304_2.fq.gz \
#R_290_2.fq.gz \
R_294_2.fq.gz \
R_296_2.fq.gz \
R_297_2.fq.gz \
R_299_2.fq.gz \
R_303_2.fq.gz \
)

#C=(R0_052 R0_053 R0_055 R0_062 R0_064 R0_065 R0_025 R0_027 R0_031 R0_034 \
#R0_038 R0_040 R0_026 R0_030 R0_032 R0_033 R0_035 R0_039 R24_119 R24_120 \
#R24_121 R24_129 R24_130 R24_131 R24_091 R24_093 R24_097 R24_100 R24_104 \
#R24_106 R24_092 R24_096 R24_098 R24_101 R24_103 R24_105 R48_185 R48_186 \
#R48_187 R48_194 R48_196 R48_197 R48_157 R48_159 R48_163 R48_166 R48_170 \
#R48_172 R48_158 R48_162 R48_164 R48_165 R48_167 R48_171 R72_316 R72_317 \
#R72_319 R72_327 R72_328 R72_329 R72_289 R72_291 R72_295 R72_300 R72_302 \
#R72_304 R72_290 R72_294 R72_296 R72_297 R72_299 R72_303)

C=(R72_294 R72_296 R72_297 R72_299 R72_303)

# Here A is an array of the left reads, whereas B is an array of the right reads.
# C is the name of the sample folders. 

echo "Files loaded"


##########
# Source #
##########
source /com/extra/bowtie2/2.2.8/load.sh
source /com/extra/RSEM/1.2.29/load.sh
source /com/extra/samtools/1.6.0/load.sh
source /com/extra/trinityrnaseq/2.4.0/load.sh
echo "Sourced: Bowtie2, RSEM, SAMtools and Trinity"

#######
# Run #
#######

#Remember to set 72 later
echo "Now running the script for Transcript quantification"
for (( I = 0; I < 5; ++I )); do
	echo "Creating the directionary for ${C[I]}"
	mkdir $DIR_OUTPUT/${C[I]}
	echo
	echo "Now calculating the read count of ${A[I]} and ${B[I]} for $INPUT"
	echo "---------------------------------------------------------------------------------"
	$DIR_SCRIPT/align_and_estimate_abundance.pl \
		--seqType fq \
		--left $READS/${A[I]} \
		--right $READS/${B[I]} \
		--transcripts $DIR_INPUT/$INPUT \
		--est_method RSEM \
		--aln_method bowtie2 \
		--coordsort_bam \
		--prep_reference \
		--thread_count 16 \
		--output_dir $DIR_OUTPUT/${C[I]}
	echo
done

echo "Done :)"

