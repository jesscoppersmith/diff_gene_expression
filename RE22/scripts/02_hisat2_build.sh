#!/bin/bash
#SBATCH --job-name="hisat2-build"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu
#SBATCH --output="slurm-%x-%j.out"

echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "Script started at: "; date
echo "Running on host:"; hostname

module load HISAT2
module list

#########################################

REFERENCE_GENOME=/home/jcoppersmith/data/src/reference_genomes/ncbi-genomes-2023-06-21
INDEXED_GENOME=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/indexed_genome
threads=16

hisat2-build -f -p $threads $REFERENCE_GENOME/*.fna $INDEXED_GENOME/RE22
# -f is for fasta file format -p is for parralization file needs to be unzipped
echo "Script finished at: "; date
