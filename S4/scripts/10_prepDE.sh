#!/bin/bash
#SBATCH --job-name="prepDE"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu
#SBATCH --output="slurm-%x-%j.out"


echo "Script started at: "; date
echo "Running on host:"; hostname

module purge
module load Python
module list

#########################################


SAMPLE_LIST=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/S4_sampleList.txt

python prepDE.py3 -i $SAMPLE_LIST

#Sample list is a text file with one merged gtf with a leading sample name on each line using the gtf files
#created by the second run of stringtie using the -e flag
echo "Script finished at: "; date
