#!/bin/bash
#SBATCH --job-name="gffCompare"
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
module load GffCompare
module list

#########################################

MERGELIST=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/S4mergelist.txt
OUTPUT=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/gffcompare_out
GFF_IN=/home/jcoppersmith/data/src/reference_genomes/S4Sm_genomic.gff


gffcompare -r $GFF_IN -o $OUTPUT/S4_merged -i $MERGELIST
	# echo "gffcompare complete" $(date)
	# -o specifies prefix to use for output files
	# -r followed by the annotation file to use as a reference
 	# merged.annotation.gtf tells you how well the predicted transcripts track to the reference annotation file
 	# merged.stats file shows the sensitivity and precision statistics and total number for different features (genes, exons, transcripts)

echo "Script finished at: "; date
