# Imputation to 1000 Genomes phase 3 panel

1. Convert a chromosome to vcf format with [plink](https://www.cog-genomics.org/plink2/)

```bash
plink --bfile mygenotypes --chr 22 --recode vcf-iid --out chr22 
```
2. Phase chromosome with [shapeit](https://odelaneau.github.io/shapeit4/) using [genetic maps](https://github.com/odelaneau/shapeit4/tree/master/maps)

```bash
shapeit4.2 --input chr22.vcf.gz --map maps/chr22.b37.gmap.gz --region 22 --output chr22_phased.bcf --thread 4
```

3. Download the 1000 genomes phase3 phased genotypes to use as the imputation reference panel
```bash
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr{1..22}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.{gz,gz.tbi}
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chrX.phase3_shapeit2_mvncall_integrated_v1c.20130502.genotypes.vcf.{gz,gz.tbi}
```

4. Create the list of chunks to impute over using [IMPUTE5](https://jmarchini.org/software/#impute-5)

```bash
./impute5_v1.1.5/imp5Chunker_1.1.5_static --h ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz --g chr22_phased.bcf --r 22 --o chr22_coordinates.txt
```
this creates a file listing the imputation and buffer regions of the chunks to impute:
```bash
0	22	22:16050075-26981240	22:16050075-26729972	10672530	2399	310082
1	22	22:26476063-36313111	22:26729973-36015192	9284555	2398	278305
2	22	22:35764919-45369086	22:36015193-45099646	9083636	2399	282447
3	22	22:44848451-51244237	22:45099647-51244237	6124383	2397	232078
```

5. Impute each chunk taking the output chunk number, "--buffer" and "--r" arguments from columns 1, 3 & 4 of the co-ordinates file respectively.
```bash
./impute5_v1.1.5/impute5_1.1.5_static --h ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.imp5 --g chr22_phased.bcf --m maps/chr22.b37.gmap.gz --buffer 22:16050075-26981240 --r 22:16050075-26729972 --threads 4 --o chr22_0.bgen --l chr22_0.log

./impute5_v1.1.5/impute5_1.1.5_static --h ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.imp5 --g chr22_phased.bcf --m maps/chr22.b37.gmap.gz --buffer 22:26476063-36313111 --r 22:26729973-36015192 --threads 4 --o chr22_1.bgen --l chr22_1.log

./impute5_v1.1.5/impute5_1.1.5_static --h ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.imp5 --g chr22_phased.bcf --m maps/chr22.b37.gmap.gz --buffer 22:35764919-45369086 --r 22:36015193-45099646 --threads 4 --o chr22_2.bgen --l chr22_2.log

./impute5_v1.1.5/impute5_1.1.5_static --h ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.imp5 --g chr22_phased.bcf --m maps/chr22.b37.gmap.gz --buffer 22:44848451-51244237 --r 22:45099647-51244237 --threads 4 --o chr22_3.bgen --l chr22_3.log
```
I have written a [PBS array job script](run_imputation.sh) to run all chunks as an array job with PBS scheduler thus:
```bash
qsub -t 1-4 run_imputation.sh
```

6. Join the chunks together using cat-bgen from [bgen_v1.1.4](https://www.well.ox.ac.uk/~gav/resources/)
```bash
cat-bgen -g chr22_{0..3}.bgen -og chr22_imputed.bgen
```

7. Obtain the corresponding .sample file for the imputed genotypes using [qctool](https://www.well.ox.ac.uk/~gav/qctool_v2/)
```bash
qctool -g chr22_imputed.bgen -os chr22_imputed.sample
```

8. Calculate SNP statistics
```bash
qctool -g chr22_imputed.bgen -snp-stats -osnp chr22_imputed.snpstats
```
