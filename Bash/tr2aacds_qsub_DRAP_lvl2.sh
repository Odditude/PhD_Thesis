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

Flower_159b=DRAP_159b_Flower.okay.cds
Leaf_159b=DRAP_159b_Leaf.okay.cds
Pod_159b=DRAP_159b_Pod.okay.cds
Seed_159b=DRAP_159b_Seed.okay.cds

Flower_2378=DRAP_2378_Flower.okay.cds
Leaf_2378=DRAP_2378_Leaf.okay.cds
Pod_2378=DRAP_2378_Pod.okay.cds
Seed_2378=DRAP_2378_Seed.okay.cds

Flower_Hiv=DRAP_Hiv_Flower.okay.cds
Leaf_Hiv=DRAP_Hiv_Leaf.okay.cds
Pod_Hiv=DRAP_Hiv_Pod.okay.cds
Seed_Hiv=DRAP_Hiv_Seed.okay.cds

Evg159b=DRAP_159b_Evg.tr
Evg2378=DRAP_2378_Evg.tr
EvgHiv=DRAP_Hiv_Evg.tr

trset=(\
$Evg159b \
$Evg2378 \
$EvgHiv \
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


cat $Flower_159b $Leaf_159b $Pod_159b $Seed_159b > $Evg159b
cat $Flower_2378 $Leaf_2378 $Pod_2378 $Seed_2378 > $Evg2378
cat $Flower_Hiv $Leaf_Hiv $Pod_Hiv $Seed_Hiv > $EvgHiv

for (( I = 0; I < $ROUNDS; ++I )); do
        echo $evigene/prot/tr2aacds.pl -debug -NCPU $ncpu -MAXMEM $maxmem -log -cdna ${trset[I]}
        $evigene/prot/tr2aacds.pl -debug -NCPU $ncpu -MAXMEM $maxmem -log -cdna ${trset[I]}
done

echo "つ ◕_◕ つ  Done"

