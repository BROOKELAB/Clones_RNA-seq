#!/bin/bash
#SBATCH --mem=40gb
#SBATCH -N 1
#SBATCH -n 6 
#SBATCH --time 12:00:00
#SBATCH --mail-user=ethayer3@illinois.edu
#SBATCH --mail-type=ALL
#SBATCH --array=1-36
#SBATCH --job-name STAR_index 		# Job name
#SBATCH -o STAR-%j.out			# File to which standard out will be written
#SBATCH -e STAR-%j.err 		# File to which standard err will be written


echo "Starting Job!!!!"

module load STAR/2.7.6a-IGB-gcc-8.2.0

set -x
set -e

STAR --version

# 36 unnumbered_raw_files.txt
read_1=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" unnumbered_raw_files.txt)
read_2=$(echo $read_1 | sed -e "s/_R1_/_R2_/g")
sample_name=$(basename $read_1 | sed -Ee "s/_[ATCG]{6}.*//g")

mkdir -p STAR
mkdir -p STAR/${sample_name}

EXTRA_PARAMS="--outSAMunmapped Within 
  --chimSegmentMin 12 \
  --chimJunctionOverhangMin 8 \
  --chimOutJunctionFormat 1 \
  --alignSJDBoverhangMin 10 \
  --alignMatesGapMax 100000 \
  --alignIntronMax 100000 \
  --alignSJstitchMismatchNmax 5 -1 5 5 \
  --chimMultimapScoreRange 3 \
  --chimScoreJunctionNonGTAG -4 \
  --chimMultimapNmax 20 \
  --chimNonchimScoreDropMin 10 \
  --peOverlapNbasesMin 12 \
  --peOverlapMMp 0.1 \
  --alignInsertionFlush Right \
  --alignSplicedMateMapLminOverLmate 0 \
  --alignSplicedMateMapLmin 30"


STAR \
    --quantMode GeneCounts --runThreadN 6 \
    --genomeDir STARgenomes/Human/GRCh38_Ensembl99_sparseD3_sjdbOverhang99 \
    --readFilesIn ${read_1},${read_2} \
    --outFileNamePrefix STAR/${sample_name}/ \
    --twopassMode Basic \
    --readFilesCommand "gunzip -c" ${EXTRA_PARAMS} \
    --limitGenomeGenerateRAM 39000000000 \
    --outTmpDir /scratch/$SLURM_JOB_ID

echo "Finish Star job"
