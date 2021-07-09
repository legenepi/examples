#!/bin/bash

#PBS -l walltime=2:0:0
#PBS -l vmem=12gb
#PBS -l nodes=1:ppn=4
#PBS -d .

CHR=22
i=$PBS_ARRAYID
CHUNK=`awk 'NR == '$i' { print $1 }' chr22_coordinates.txt`
BUFFER=`awk 'NR == '$i' { print $3 }' chr22_coordinates.txt`
IMPUTATION=`awk 'NR == '$i' { print $4 }' chr22_coordinates.txt`

./impute5_v1.1.5/impute5_1.1.5_static \
    --h ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.imp5 \
    --g chr${CHR}_phased.bcf \
    --m maps/chr${CHR}.b37.gmap.gz \
    --buffer $BUFFER \
    --r $IMPUTATION \
    --threads 4 \
    --o chr${CHR}_${CHUNK}.bgen \
    --l chr${CHR}_${CHUNK}.log
