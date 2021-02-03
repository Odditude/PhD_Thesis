#!/bin/bash

# Script for SNP calling with SAMTools. 
# This Script is designed for varian calling in Hedin, Melodie and ILB938. 
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

READS1=(R1_1.fq \
R2_1.fq \
R3_1.fq \
R4_1.fq \
R5_1.fq \
R6_1.fq \
R7_1.fq \
R8_1.fq \
R9_1.fq \
R10_1.fq \
R11_1.fq \
R12_1.fq \
R13_1.fq \
R14_1.fq \
R15_1.fq \
R16_1.fq \
R17_1.fq \
R18_1.fq \
R19_1.fq \
R20_1.fq \
R21_1.fq \
R22_1.fq \
R23_1.fq \
R24_1.fq \
R25_1.fq \
R26_1.fq \
A018_pAC_TCCGCGAA_AGGATAGG_run20170523N_S18_R1_001.fastq \
A019_pAT_TCCGCGAA_CTTCGCCT_run20170523N_S19_R1_001.fastq \
A020_pBC_TCCGCGAA_TAAGATTA_run20170523N_S20_R1_001.fastq \
A021_pBT_AGCGATAG_TCAGAGCC_run20170523N_S21_R1_001.fastq \
)

READS2=(R1_2.fq \
R2_2.fq \
R3_2.fq \
R4_2.fq \
R5_2.fq \
R6_2.fq \
R7_2.fq \
R8_2.fq \
R9_2.fq \
R10_2.fq \
R11_2.fq \
R12_2.fq \
R13_2.fq \
R14_2.fq \
R15_2.fq \
R16_2.fq \
R17_2.fq \
R18_2.fq \
R19_2.fq \
R20_2.fq \
R21_2.fq \
R22_2.fq \
R23_2.fq \
R24_2.fq \
R25_2.fq \
R26_2.fq \
A018_pAC_TCCGCGAA_AGGATAGG_run20170523N_S18_R2_001.fastq \
A019_pAT_TCCGCGAA_CTTCGCCT_run20170523N_S19_R2_001.fastq \
A020_pBC_TCCGCGAA_TAAGATTA_run20170523N_S20_R2_001.fastq \
A021_pBT_AGCGATAG_TCAGAGCC_run20170523N_S21_R2_001.fastq \
)

SAMPLE=(Hedin01 \
Hedin02 \
Hedin03 \
Hedin04 \
Hedin05 \
Hedin06 \
Hedin07 \
Hedin08 \
Hedin09 \
Hedin10 \
Hedin11 \
Hedin12 \
Hedin13 \
Hedin14 \
Hedin15 \
Hedin16 \
Hedin17 \
Hedin18 \
Hedin19 \
Hedin20 \
Hedin21 \
Hedin22 \
Hedin23 \
Hedin24 \
Hedin25 \
Hedin26 \
MelodieCore \
MelodieTesta \
ILB938Core \
ILB938Testa \
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

#echo "Index the reference transcriptome for BWA"
##bwa index $DIR_REF$REFERENCE

#echo "Make tmp folder"
#mkdir ${DIR_MAP}tmp

#echo "Align all reads seperately" 
#echo "--------------------------------"
#for (( I = 0; I < 30; ++I )); do
#	echo
#	echo "Aligning ${SAMPLE[I]}"
#	echo "${READS1[I]} and ${READS2[I]}"
#	echo 'Align using BWA-mem'
#	bwa mem -R '@RG\tID:$ID\tSM:$SAMPLE\tLB:$REFERENCE' $DIR_REF$REFERENCE $DIR_READS${READS1[I]} $DIR_READS${READS2[I]} > $DIR_MAP${SAMPLE[I]}.sam
#	
#	echo 'SAM-to-BAM'
#	samtools fixmate -O bam $DIR_MAP${SAMPLE[I]}.sam $DIR_MAP${SAMPLE[I]}.bam
#	
#	echo 'Sort BAM'
#	samtools sort -O bam -o $DIR_MAP${SAMPLE[I]}_sorted.bam -T ${DIR_MAP}tmp/${SAMPLE[I]}_temp $DIR_MAP${SAMPLE[I]}.bam
#done

#echo "Merge the BAM files"
#echo "Merge Hedin"
#samtools merge ${DIR_MAP}merged_Hedin.bam ${DIR_MAP}Hedin01_sorted.bam ${DIR_MAP}Hedin02_sorted.bam ${DIR_MAP}Hedin03_sorted.bam \
#${DIR_MAP}Hedin04_sorted.bam ${DIR_MAP}Hedin05_sorted.bam ${DIR_MAP}Hedin06_sorted.bam ${DIR_MAP}Hedin07_sorted.bam ${DIR_MAP}Hedin08_sorted.bam \
#${DIR_MAP}Hedin09_sorted.bam ${DIR_MAP}Hedin10_sorted.bam ${DIR_MAP}Hedin11_sorted.bam ${DIR_MAP}Hedin12_sorted.bam ${DIR_MAP}Hedin13_sorted.bam \
#${DIR_MAP}Hedin14_sorted.bam ${DIR_MAP}Hedin15_sorted.bam ${DIR_MAP}Hedin16_sorted.bam ${DIR_MAP}Hedin17_sorted.bam ${DIR_MAP}Hedin18_sorted.bam \
#${DIR_MAP}Hedin19_sorted.bam ${DIR_MAP}Hedin20_sorted.bam ${DIR_MAP}Hedin21_sorted.bam ${DIR_MAP}Hedin22_sorted.bam ${DIR_MAP}Hedin23_sorted.bam \
#${DIR_MAP}Hedin24_sorted.bam ${DIR_MAP}Hedin25_sorted.bam ${DIR_MAP}Hedin26_sorted.bam

#echo "Merge ILB938"
#samtools merge ${DIR_MAP}merged_ILB938.bam ${DIR_MAP}ILB938Core_sorted.bam ${DIR_MAP}ILB938Testa_sorted.bam

#echo "Merge Melodie"
#samtools merge ${DIR_MAP}merged_Melodie.bam ${DIR_MAP}MelodieCore_sorted.bam ${DIR_MAP}MelodieTesta_sorted.bam

#echo "Index BAM files"
#samtools index ${DIR_MAP}merged_Hedin.bam
#samtools index ${DIR_MAP}merged_ILB938.bam
#samtools index ${DIR_MAP}merged_Melodie.bam

echo "Running mpileup on all BAM files and calling the SNPs"
bcftools mpileup -Ou -f $DIR_REF$REFERENCE ${DIR_MAP}merged_Hedin.bam ${DIR_MAP}merged_ILB938.bam ${DIR_MAP}merged_Melodie.bam ${DIR_MAP}merged_159b.bam \
${DIR_MAP}merged_2378.bam ${DIR_MAP}merged_Hiv.bam | bcftools call -vmO z -o $DIR_VCF$ID.12H.20190305.vcf.gz

echo "Filter low quality off"
bcftools filter -O z -o $DIR_VCF$ID.12H.filtered.20190305.vcf.gz -s LOWQUAL -i'%QUAL>10' $DIR_VCF$ID.12H.20190305.vcf.gz

echo
echo "Done ヽ(^O^)ノ"
