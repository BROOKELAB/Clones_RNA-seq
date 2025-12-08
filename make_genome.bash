#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH -p normal
#SBATCH -n 4
#SBATCH --mem=48g
#SBATCH -N 1

module load STAR/2.7.6a-IGB-gcc-8.2.0

set -x
set -e

STAR --version

STAR --runThreadN 4 \
  --runMode genomeGenerate \
  --genomeDir STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99 \
  --genomeFastaFiles STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
  --sjdbGTFfile STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99/Homo_sapiens.GRCh38.99.gtf \
  --sjdbOverhang 149  --outTmpDir /scratch/$SLURM_JOB_ID
