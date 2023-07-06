#!/bin/bash
#SBATCH --job-name="samtools-sort"
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

module load SAMtools
module list

#########################################

INPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/hisat2_out
OUTPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/samtools_out
threads=16

file=`ls $INPUT_DIR/*aligned.sam | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
base=`basename ${file} .aligned.sam`

samtools sort -o $OUTPUT_DIR/${base}.aligned.bam -@ $threads $file

# input comes from output of hisat2_align in previous step


echo "Script finished at: "; date
