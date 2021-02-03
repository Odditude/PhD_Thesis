#! /bin/bash
### env trset=allshrimpt1.tr datad=`pwd` qsub -q normal tr2aacds_qsub.sh
#PBS -N tr2cds
#PBS -l nodes=1:ppn=32,walltime=18:55:00
#PBS -o tr2cds.$$.out
#PBS -e tr2cds.$$.err
#PBS -V

ncpu=16
maxmem=100000
evigene=/home/leandro/evigene/scripts
datad=/faststorage/project/norfab/20190903_Transcriptomics/DRAP-Fasta/Evigene/evgDRAP

trset=(\
DRAP_159b_Flower.tr \
DRAP_159b_Leaf.tr \
DRAP_159b_Pod.tr \
DRAP_159b_Seed.tr \
DRAP_2378_Flower.tr \
DRAP_2378_Leaf.tr \
DRAP_2378_Pod.tr \
DRAP_2378_Seed.tr \
DRAP_Hedin.tr \
DRAP_Hiv_Flower.tr \
DRAP_Hiv_Leaf.tr \
DRAP_Hiv_Pod.tr \
DRAP_Hiv_Seed.tr \
)


ROUNDS=13

#t2ac: app=cd-hit-est, path= echo MISSING_cd-hit-est
source /com/extra/cd-hit/454/load.sh
#t2ac: app=fastanrdb, path= echo MISSING_fastanrdb
source /com/extra/exonerate/2.2.0/load.sh
#t2ac: app=blastn, path= echo MISSING_blastn
#t2ac: app=LASTZ, path= missing from the descripion
source /com/extra/lastz/1.02/load.sh

if [ "X" = "X$trset" ]; then
  echo "missing env trset=xxxx.tr"; exit -1
fi
if [ "X" = "X$datad" ]; then
  echo "missing env datad=/path/to/data"; exit -1
fi

cd $datad/

for (( I = 0; I < $ROUNDS; ++I )); do
	echo $evigene/prot/tr2aacds.pl -debug -NCPU $ncpu -MAXMEM $maxmem -log -cdna ${trset[I]}
	$evigene/prot/tr2aacds.pl -debug -NCPU $ncpu -MAXMEM $maxmem -log -cdna ${trset[I]}
done

