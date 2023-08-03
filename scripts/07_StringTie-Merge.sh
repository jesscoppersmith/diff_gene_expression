#!/bin/bash
#SBATCH --job-name="StringTie-merge"
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
module load StringTie
module list

#########################################

MERGELIST=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/stringtie_out/mergelist.txt
OUTPUT=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/stringtie-merge_out/RE22_merged.gtf
GFF_IN=/home/jcoppersmith/data/src/reference_genomes/ncbi-genomes-2023-06-21/GCF_003391375.1_ASM339137v1_genomic.gff
ABUND_OUT=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/stringtie-merge_out/RE22_merged_abund.txt

stringtie --merge -A $ABUND_OUT -o $OUTPUT -G $GFF_IN $MERGELIST
#Keep this order!

# -o is for output file
#-G is a flag saying to use the .gff annotation file
#-A here creates a gene table output with genomic locations and compiled information that I will need later to fetch gene sequences
#FROM MANUAL: "If StringTie is run with the -A <gene_abund.tab> option, it returns a file containing gene abundances. "
#-A is not required

echo "Script finished at: "; date
