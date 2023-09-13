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

module purge
module load HISAT2
module list

#########################################

REFERENCE_GENOME=/home/jcoppersmith/data/src/reference_genomes/S4Sm_GCF_030060455.1_ASM3006045v1_genomic.fna
INDEXED_GENOME=/home/jcoppersmith/data/src/reference_genomes/indexed_genomes
threads=16

hisat2-build -f -p $threads $REFERENCE_GENOME $INDEXED_GENOME/S4
# -f is for fasta file format -p is for parralization file needs to be unzipped
#hisat2-build can index reference genomes of any size. For genomes less than about 4 billion nucleotides in length,
#Will be using trimmed reads from RE22 DGE
echo "Script finished at: "; date
