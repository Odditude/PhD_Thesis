#!/bin/bash

# Version 1.0
# This Script is set out to test the quality of the assemblies.
# Maps the reads that correspond to that assembly.
# It uses BWA-mem and samTools.
# It uses 8 threads.
# It is set to work in any directory.

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 8 -t 15:00:00 -A norfab 'Scripts/Rarely_Used/BWA-mem_Quality_Testing_159b.sh'

#~~~~~~~~~~~~~~~~#
# Directionaries #
#~~~~~~~~~~~~~~~~#

DIR_REA=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reads
DIR_ASS=/faststorage/project/norfab/20180727_INRA/Assembly/
DIR_OUT=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/BWA-Results_Nov2020
echo 'Directories are loaded'

#~~~~~~~#
# Files #
#~~~~~~~#

NAME=0_159b

#NAME_1=1_Trinity_ExpansionPod
#NAME_2a=2a_DRAP_ExpansionPod
#NAME_3a=3a_Evigene_Hedin
#NAME_4a=4a_AllAccessions
#NAME_2b=2b_DRAP_ExpansionPod
#NAME_3b=3b_Evigene_Hedin
#NAME_4b=4b_AllAccessions
#NAME_2c=2c_DRAP_ExpansionPod
#NAME_3c=3c_Evigene_Hedin
#NAME_4c=4c_AllAccessions

#~~~ Assemblies ~~~#

ASS=159b-finalAssembly.fa

#ASS_1=20181116_condE_trinity.Trinity.fasta
#ASS_2a=DRAP-original/hedin_expansionPod.fa
#ASS_3a=Evigene/evgDRAP/DRAP_Hedin.okay.cds
#ASS_4a=Evigene/MODES/M01/MODE01_aalen.fasta
#ASS_2b=List-EU/ListEU-DRAP_Hedin_ExpansionPods.fasta
#ASS_3b=Evigene/evgListEU/ListEU_Hedin.okay.cds
#ASS_4b=Evigene/MODES/M05/MODE05_aalen.fasta
#ASS_2c=SoftFilter/SF_hedin_expansionPod.fa
#ASS_3c=Evigene/evgSoftfilter/SF_Evi_Hedin.okay.cds
#ASS_4c=Evigene/MODES/ModeSF/ModeSF_aalen.fa

#~~~ Reads ~~~#
# 159b
READS1_159b=(\
159b-Feu-1_ATCACG_L003_BFC_R1_paired.fastq \
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

READS2_159b=(\
159b-Feu-1_ATCACG_L003_BFC_R2_paired.fastq \
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

BAM_159b=(\
159b-Feu-01 \
159b-Feu-02 \
159b-Feu-03 \
159b-Flo-01 \
159b-Flo-02 \
159b-Flo-03 \
159b-Gou-01 \
159b-Gou-02 \
159b-Gou-03 \
159b-GrL-01 \
159b-GrL-02 \
159b-GrL-03 \
)

# 2378
READS1_2378=(\
2378-Feu-1_TTAGGC_L003_BFC_R1_paired.fastq \
2378-Feu-2_TGACCA_L003_BFC_R1_paired.fastq \
2378-Feu-3_CAGATC_L005_BFC_R1_paired.fastq \
2378-Flo-1_ACTTGA_L005_BFC_R1_paired.fastq \
2378-Flo-2_GATCAG_L003_BFC_R1_paired.fastq \
2378-Flo-3_TAGCTT_L003_BFC_R1_paired.fastq \
2378-Gou-1_CGTACG_L003_BFC_R1_paired.fastq \
2378-Gou-2_GAGTGG_L003_BFC_R1_paired.fastq \
2378-Gou-3_GATCAG_L005_BFC_R1_paired.fastq \
2378-GrL-1_ATGTCA_L003_BFC_R1_paired.fastq \
2378-GrL-2_TAGCTT_L005_BFC_R1_paired.fastq \
2378-GrL-3_CCGTCC_L003_BFC_R1_paired.fastq \
)

READS2_2378=(\
2378-Feu-1_TTAGGC_L003_BFC_R2_paired.fastq \
2378-Feu-2_TGACCA_L003_BFC_R2_paired.fastq \
2378-Feu-3_CAGATC_L005_BFC_R2_paired.fastq \
2378-Flo-1_ACTTGA_L005_BFC_R2_paired.fastq \
2378-Flo-2_GATCAG_L003_BFC_R2_paired.fastq \
2378-Flo-3_TAGCTT_L003_BFC_R2_paired.fastq \
2378-Gou-1_CGTACG_L003_BFC_R2_paired.fastq \
2378-Gou-2_GAGTGG_L003_BFC_R2_paired.fastq \
2378-Gou-3_GATCAG_L005_BFC_R2_paired.fastq \
2378-GrL-1_ATGTCA_L003_BFC_R2_paired.fastq \
2378-GrL-2_TAGCTT_L005_BFC_R2_paired.fastq \
2378-GrL-3_CCGTCC_L003_BFC_R2_paired.fastq \
)

BAM_2378=(\
2378-Feu-01 \
2378-Feu-02 \
2378-Feu-03 \
2378-Flo-01 \
2378-Flo-02 \
2378-Flo-03 \
2378-Gou-01 \
2378-Gou-02 \
2378-Gou-03 \
2378-GrL-01 \
2378-GrL-02 \
2378-GrL-03 \
)

# Hiverna
READS1_Hiv=(\
Hiv-Feu-1_ACAGTG_L003_BFC_R1_paired.fastq \
Hiv-Feu-2_GCCAAT_L003_BFC_R1_paired.fastq \
Hiv-Feu-3_GGCTAC_L005_BFC_R1_paired.fastq \
Hiv-Flo-1_GGCTAC_L003_BFC_R1_paired.fastq \
Hiv-Flo-2_CTTGTA_L003_BFC_R1_paired.fastq \
Hiv-Flo-3_ATGTCA_L005_BFC_R1_paired.fastq \
Hiv-Gou-1_ACTGAT_L003_BFC_R1_paired.fastq \
Hiv-Gou-2_GTCCGC_L005_BFC_R1_paired.fastq \
Hiv-Gou-3_ATTCCT_L003_BFC_R1_paired.fastq \
Hiv-GrL-1_GTCCGC_L003_BFC_R1_paired.fastq \
Hiv-GrL-2_GTGGCC_L005_BFC_R1_paired.fastq \
Hiv-GrL-3_GTGAAA_L003_BFC_R1_paired.fastq \
)

READS2_Hiv=(\
Hiv-Feu-1_ACAGTG_L003_BFC_R2_paired.fastq \
Hiv-Feu-2_GCCAAT_L003_BFC_R2_paired.fastq \
Hiv-Feu-3_GGCTAC_L005_BFC_R2_paired.fastq \
Hiv-Flo-1_GGCTAC_L003_BFC_R2_paired.fastq \
Hiv-Flo-2_CTTGTA_L003_BFC_R2_paired.fastq \
Hiv-Flo-3_ATGTCA_L005_BFC_R2_paired.fastq \
Hiv-Gou-1_ACTGAT_L003_BFC_R2_paired.fastq \
Hiv-Gou-2_GTCCGC_L005_BFC_R2_paired.fastq \
Hiv-Gou-3_ATTCCT_L003_BFC_R2_paired.fastq \
Hiv-GrL-1_GTCCGC_L003_BFC_R2_paired.fastq \
Hiv-GrL-2_GTGGCC_L005_BFC_R2_paired.fastq \
Hiv-GrL-3_GTGAAA_L003_BFC_R2_paired.fastq \
)

BAM_Hiv=(\
Hiv-Feu-01 \
Hiv-Feu-02 \
Hiv-Feu-03 \
Hiv-Flo-01 \
Hiv-Flo-02 \
Hiv-Flo-03 \
Hiv-Gou-01 \
Hiv-Gou-02 \
Hiv-Gou-03 \
Hiv-GrL-01 \
Hiv-GrL-02 \
Hiv-GrL-03 \
)

# Hedin
READS1_Hedin=(\
R1_1.fq \
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
R27_1.fq \
R28_1.fq \
R29_1.fq \
)


READS2_Hedin=(\
R1_2.fq \
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
R27_2.fq \
R28_2.fq \
R29_2.fq \
)

BAM_Hedin=(R01 R02 R03 R04 R05 R06 R07 R08 R09 R10 R11 R12 R13 R14 R15 \
R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28 R29)
ROUNDS=12
ROUNDS_Hedin=29
CORES=8


echo "Files are loaded"

#~~~~~~~~#
# Source #
#~~~~~~~~#

source /com/extra/bwa/0.7.5a/load.sh
source /com/extra/samtools/1.6.0/load.sh

echo "Sourced: BWA and Samtools"

#~~~~~#
# Run #
#~~~~~#

echo "Checking if index's exist"
if [ -f "${DIR_ASS}/${ASS}.bwt" ]; then
    echo "Index for $ASS exist"
else
    echo "Index for $ASS does not exist"
    bwa index ${DIR_ASS}/$ASS

fi


# 159b
for (( I = 0; I < $ROUNDS; ++I )); do
        echo
        echo "Aligning ${ASS} with ${READS1_159b[I]} and ${READS2_159b[I]}"
        bwa mem -t $CORES $DIR_ASS/$ASS $DIR_REA/${READS1_159b[I]} $DIR_REA/${READS2_159b[I]} | samtools sort -@$CORES -o $DIR_OUT/${NAME}_${BAM_159b[I]}.bam -
        echo "Calculating mapping statistics"
        samtools flagstat $DIR_OUT/${NAME}_${BAM_159b[I]}.bam > $DIR_OUT/${NAME}_${BAM_159b[I]}_flagstat.log
        echo "Done ヽ(^O^)ノ"
done

# 2378
for (( I = 0; I < $ROUNDS; ++I )); do
        echo
        echo "Aligning ${ASS} with ${READS1_2378[I]} and ${READS2_2378[I]}"
        bwa mem -t $CORES $DIR_ASS/$ASS $DIR_REA/${READS1_2378[I]} $DIR_REA/${READS2_2378[I]} | samtools sort -@$CORES -o $DIR_OUT/${NAME}_${BAM_2378[I]}.bam -
        echo "Calculating mapping statistics"
        samtools flagstat $DIR_OUT/${NAME}_${BAM_2378[I]}.bam > $DIR_OUT/${NAME}_${BAM_2378[I]}_flagstat.log
        echo "Done ヽ(^O^)ノ"
done

# Hiv
for (( I = 0; I < $ROUNDS; ++I )); do
        echo
        echo "Aligning ${ASS} with ${READS1_Hiv[I]} and ${READS2_Hiv[I]}"
        bwa mem -t $CORES $DIR_ASS/$ASS $DIR_REA/${READS1_Hiv[I]} $DIR_REA/${READS2_Hiv[I]} | samtools sort -@$CORES -o $DIR_OUT/${NAME}_${BAM_Hiv[I]}.bam -
        echo "Calculating mapping statistics"
        samtools flagstat $DIR_OUT/${NAME}_${BAM_Hiv[I]}.bam > $DIR_OUT/${NAME}_${BAM_Hiv[I]}_flagstat.log
        echo "Done ヽ(^O^)ノ"
done

# Hedin
for (( I = 0; I < $ROUNDS_Hedin; ++I )); do
        echo
        echo "Aligning ${ASS} with ${READS1_Hedin[I]} and ${READS2_Hedin[I]}"
        bwa mem -t $CORES $DIR_ASS/$ASS $DIR_REA/${READS1_Hedin[I]} $DIR_REA/${READS2_Hedin[I]} | samtools sort -@$CORES -o $DIR_OUT/${NAME}_${BAM_Hedin[I]}.bam -
        echo "Calculating mapping statistics"
        samtools flagstat $DIR_OUT/${NAME}_${BAM_Hedin[I]}.bam > $DIR_OUT/${NAME}_${BAM_Hedin[I]}_flagstat.log
        echo "Done ヽ(^O^)ノ"
done


echo 'つ ◕_◕ つ  Done'
