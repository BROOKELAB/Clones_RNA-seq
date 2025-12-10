# Clones_RNA-seq
_Bulk RNA-seq analysis for the A549 clonal populations_\
Scripts associated with the bulk RNA-seq data for the unstimulated clones in Single-cell heterogeneity in interferon induction potential is heritable and governed by variation in cell state, Thayer et al. (2025).

## Overview
This repository contains the scripts used to process the bulk RNA-seq data collected from the clonal A549 populations. Our goals for this analysis is to see if we could 1) characterize the transcriptional profiles of each A549 population and 2) determine if there are genes correlating with the _IFNL1_ expression phenotype each clonal population exhibits.

## Preliminary processing
Raw reads were demultiplexed using bclfastq v2.20 Conversion Software (Illumina). The reads were then processed further using the following:
1. Alignment using STAR (v2.7.6a)
   - Input: .fastq files for read1 and read2
   - Output: files for alignment, splice junctions, and per-gene counts (Log.final.out, SJ.out.tab, ReadsPerGene.out.tab)
   - Script: star_align.bash

2. Generating the count matrix
   - Input: ReadsPerGene.out.tab for all files unter STAR/*/
   - Output: .txt file of the count matrix
   - Script: combine.py

## Analysis in R
### Script: et01b28_12.8.25.Rmd
This script performs:\
:white_check_mark: Loads the phenotype data and summarizes the results for each A549 population
:white_check_mark: Loads the count matrix and creates an edgeR object for DE analysis
:white_check_mark: Uses the phenotype data to create a design matrix that uses the increasing _IFNL1_ expression as a trajectory
:white_check_mark: Creates a PCA plot to look at the transcriptional similarities among the populations
:white_check_mark: Performs a Spearman correlation analysis of the gene expression and _IFNL1_ phenotypes

### Requirements
**R (v2.2.2)**
- org.Hs.eg.db (v3.16.0)
- edgeR (3.40.2)
- dplyr (v1.21.4)
- tidyr (v1.3.1)
- ggplot2 (v3.5.1)
- gtools (v3.9.5)
- forcats (v1.0.0)
- tibble (v3.2.1)
