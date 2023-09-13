#!/bin/bash
#SBATCH --job-name="StringTie-e"
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

module purge
module load StringTie
module list

#########################################

INPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/samtools_out
GTF_INPUT=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/gffcompare_out/S4_merged.combined.gtf
OUTPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/stringtie_out
threads=16

file=`ls $INPUT_DIR/*trimmed.aligned.bam | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
base=`basename ${file} _trimmed.aligned.bam`

echo "processing" $base

stringtie -o $OUTPUT_DIR/${base}_merged.gtf -e $file -G $GTF_INPUT  -p $threads
#-G indicates GFF file -o is for output file

# input here is the original set of alignment files
	# here -G refers to the merged GTF files
	# -e creates more accurate abundance estimations with input transcripts, needed when converting to DESeq2 tables
echo "Script finished at: "; date
