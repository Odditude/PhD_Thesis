#!/bin/bash

# Script for SNP calling with SAMTools. 
# This Script was designed for variant calling in Hedin, Melodie and ILB938.
# And is now done to include 159b, 2378 & Hiverna
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in every dictionary. 

#================#
# Directionaries #
#================#

DIR_MAP=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Mapping/
DIR_READS=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reads/
DIR_REF=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reference/
DIR_VCF=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Vcf/

echo "Directionaries are loaded"

#=======#
# Files #
#=======#

REFERENCE=All_Assemblies_AI.filtered.nocarriage.01.fa

READS1=(159b-Feu-1_ATCACG_L003_BFC_R1_paired.fastq \
159b-Feu-2_CGATGT_L003_BFC_R1_paired.fastq \
159b-Feu-3_ATCACG_L005_BFC_R1_paired.fastq \
159b-Flo-1_CGATGT_L005_BFC_R1_paired.fastq \
159b-Flo-2_CAGATC_L003_BFC_R1_paired.fastq \
159b-Flo-3_ACTTGA_L003_BFC_R1_paired.fastq \
159b-Gou-1_ACAGTG_L005_BFC_R1_paired.fastq \
159b-Gou-2_GTGGCC_L003_BFC_R1_paired.fastq \
159b-Gou-3_GTTTCG_L003_BFC_R1_paired.fastq \
159b-GrL-1_GCCAAT_L005_BFC_R1_paired.fastq \
159b-GrL-2_AGTCAA_L003_BFC_R1_paired.fastq \
159b-GrL-3_AGTTCC_L003_BFC_R1_paired.fastq \
)

READS2=(159b-Feu-1_ATCACG_L003_BFC_R2_paired.fastq \
159b-Feu-2_CGATGT_L003_BFC_R2_paired.fastq \
159b-Feu-3_ATCACG_L005_BFC_R2_paired.fastq \
159b-Flo-1_CGATGT_L005_BFC_R2_paired.fastq \
159b-Flo-2_CAGATC_L003_BFC_R2_paired.fastq \
159b-Flo-3_ACTTGA_L003_BFC_R2_paired.fastq \
159b-Gou-1_ACAGTG_L005_BFC_R2_paired.fastq \
159b-Gou-2_GTGGCC_L003_BFC_R2_paired.fastq \
159b-Gou-3_GTTTCG_L003_BFC_R2_paired.fastq \
159b-GrL-1_GCCAAT_L005_BFC_R2_paired.fastq \
159b-GrL-2_AGTCAA_L003_BFC_R2_paired.fastq \
159b-GrL-3_AGTTCC_L003_BFC_R2_paired.fastq \
)

SAMPLE=(159b01 \
159b02 \
159b03 \
159b04 \
159b05 \
159b06 \
159b07 \
159b08 \
159b09 \
159b10 \
159b11 \
159b12 \
)

ID=faba_HIM_18072018

echo "Files are loaded"

#========#
# Source #
#========#

source /com/extra/bcftools/1.6.0/load.sh
source /com/extra/bwa/0.7.5a/load.sh
source /com/extra/samtools/1.6.0/load.sh
echo "Sourced: bcftools, BWA and Samtools"

#=====#
# Run #
#=====#

echo "Index the reference transcriptome for BWA"
#bwa index $DIR_REF$REFERENCE

echo "Make tmp folder"
mkdir ${DIR_MAP}tmp

echo "Align all reads seperately" 
echo "--------------------------------"
for (( I = 0; I < 12; ++I )); do
	echo
	echo "Aligning ${SAMPLE[I]}"
	echo "${READS1[I]} and ${READS2[I]}"
	echo 'Align using BWA-mem'
	bwa mem -R '@RG\tID:faba_HIM_18072018\tSM:159b\tLB:All_Assemblies_AI.filtered.nocarriage.01.fa' $DIR_REF$REFERENCE $DIR_READS${READS1[I]} $DIR_READS${READS2[I]} > $DIR_MAP${SAMPLE[I]}.sam
	
	echo 'SAM-to-BAM'
	samtools fixmate -O bam $DIR_MAP${SAMPLE[I]}.sam $DIR_MAP${SAMPLE[I]}.bam
	
	echo 'Sort BAM'
	samtools sort -O bam -o $DIR_MAP${SAMPLE[I]}_sorted.bam -T ${DIR_MAP}tmp/${SAMPLE[I]}_temp $DIR_MAP${SAMPLE[I]}.bam
done

echo "Merge the BAM files"
echo "Merge 159b"
samtools merge ${DIR_MAP}merged_159b.bam ${DIR_MAP}159b01_sorted.bam ${DIR_MAP}159b02_sorted.bam ${DIR_MAP}159b03_sorted.bam \
${DIR_MAP}159b04_sorted.bam ${DIR_MAP}159b05_sorted.bam ${DIR_MAP}159b06_sorted.bam ${DIR_MAP}159b07_sorted.bam ${DIR_MAP}159b08_sorted.bam \
${DIR_MAP}159b09_sorted.bam ${DIR_MAP}159b10_sorted.bam ${DIR_MAP}159b11_sorted.bam ${DIR_MAP}159b12_sorted.bam

echo "Index BAM files"
samtools index ${DIR_MAP}merged_159b.bam

echo
echo "Done ヽ(^O^)ノ"
