#!/bin/bash
#SBATCH --job-name="hisat2_align"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu
#SBATCH --output="slurm-%x-%j.out"
#SBATCH --array=1-96%8

echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "Script started at: "; date
echo "Running on host:"; hostname

module load HISAT2
module list

#########################################

HISAT2_INDEXES=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/indexed_genome/RE22
INPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/trimmed-reads
OUTPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/hisat2_out
threads=16

file=`ls $INPUT_DIR/*.fq.gz | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
base=`basename ${file} .fq.gz`

echo "hisat2 -q -x $HISAT2_INDEXES -U $file -S $OUTPUT_DIR/${base}.aligned.sam"
hisat2 -q -x $HISAT2_INDEXES -U $file -S $OUTPUT_DIR/${base}.aligned.sam
# indexes come from hisat-build of reference genome .fna file in previous step
# -q indicates files are fastq -x is index files -U are unpaired reads

echo "Script finished at: "; date
