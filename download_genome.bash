#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH -p normal
#SBATCH -n 4
#SBATCH --mem=16g
#SBATCH -N 1


set -x
set -e


# http://labshare.cshl.edu/shares/gingeraslab/www-data/dobin/STAR/STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99/
wget --no-parent -r  http://labshare.cshl.edu/shares/gingeraslab/www-data/dobin/STAR/STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99/
mv ./labshare.cshl.edu/shares/gingeraslab/www-data/dobin/STAR/STARgenomes/ .

