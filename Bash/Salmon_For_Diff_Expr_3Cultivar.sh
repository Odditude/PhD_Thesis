#!/bin/bash

# Version 1.0
# This script it used to map the Salmon reads for Differential Expression
# How many nodes, cores and amount of time is set in the terminal and not here.
# This Script is designed to be run in any directionary: /home/leandro/

#~~~~~~~~~~~~~#
# Run command #
#~~~~~~~~~~~~~#

# qx --no-scratch -c 16 -t 10:00:00 -A norfab '/home/leandro/Scripts/Rarely_Used/Salmon_For_Diff_Expr_3Cultivar.sh'

#================#
# Directionaries #
#================#

DIR_IND=/faststorage/project/norfab/20190903_Transcriptomics/Salmon/Index
DIR_REA=/faststorage/project/norfab/20180126_Allans_data/Variant_Calling/faba_HIM_18072018/Reads
DIR_ASS=/faststorage/project/norfab/20190903_Transcriptomics/Fasta/SuperTranscript
DIR_OUT=/faststorage/project/norfab/20190903_Transcriptomics/Salmon/Output/M09_SuperTranscript

echo "Directionaries are loaded"

#========#
# Source #
#========#

echo "Salmon is already installed"

#=======#
# Files #
#=======#

CORES=16

i=M09_SuperTranscript
#T=M09_SuperDuper.fasta

j=(\
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

k=(\
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

NAME=(\
159b-Feu-01_quant \
159b-Feu-02_quant \
159b-Feu-03_quant \
159b-Flo-01_quant \
159b-Flo-02_quant \
159b-Flo-03_quant \
159b-Gou-01_quant \
159b-Gou-02_quant \
159b-Gou-03_quant \
159b-GrL-01_quant \
159b-GrL-02_quant \
159b-GrL-03_quant \
2378-Feu-01_quant \
2378-Feu-02_quant \
2378-Feu-03_quant \
2378-Flo-01_quant \
2378-Flo-02_quant \
2378-Flo-03_quant \
2378-Gou-01_quant \
2378-Gou-02_quant \
2378-Gou-03_quant \
2378-GrL-01_quant \
2378-GrL-02_quant \
2378-GrL-03_quant \
Hiv-Feu-01_quant \
Hiv-Feu-02_quant \
Hiv-Feu-03_quant \
Hiv-Flo-01_quant \
Hiv-Flo-02_quant \
Hiv-Flo-03_quant \
Hiv-Gou-01_quant \
Hiv-Gou-02_quant \
Hiv-Gou-03_quant \
Hiv-GrL-01_quant \
Hiv-GrL-02_quant \
Hiv-GrL-03_quant \
)

#=====#
# Run #
#=====#

echo "Now creating the Index"
#salmon index -t $DIR_ASS/$T -i $DIR_IND/$i

echo "Now commencing mapping"

for (( I = 0; I < 29; ++I )); do
        echo "Quantifying ${NAME[I]}"
        salmon quant -l A --gcBias --validateMappings -p $CORES -i $DIR_IND/$i -1 $DIR_REA/${j[I]} -2 $DIR_REA/${k[I]} -o $DIR_OUT/${NAME[I]}
        echo "Done"
done

echo "Done ヽ(^O^)ノ"
