#!/bin/bash
#SBATCH --job-name="StringTie-merge"
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

INPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/stringtie_out
OUTPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/stringtie-merge_out
GFF_IN=/home/jcoppersmith/data/src/reference_genomes/ncbi-genomes-2023-06-21/GCF_003391375.1_ASM339137v1_genomic.gff
threads=16

file=`ls $INPUT_DIR/*.gtf | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
base=`basename ${file} .gtf`

echo "processing" $base

stringtie --merge -A $file -G $GFF_IN -o $OUTPUT_DIR/${base}_merged.gtf -p $threads
#-G indicates GFF file -o is for output file
#-G is a flag saying to use the .gff annotation file
#-A here creates a gene table output with genomic locations and compiled information that I will need later to fetch gene sequences
#FROM MANUAL: "If StringTie is run with the -A <gene_abund.tab> option, it returns a file containing gene abundances. "
#-A is not required

echo "Script finished at: "; date
