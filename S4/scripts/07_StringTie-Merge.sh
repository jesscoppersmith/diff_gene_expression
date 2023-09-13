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

MERGELIST=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/S4mergelist.txt
OUTPUT=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/stringtie-merge_out/S4_merged.gtf
GFF_IN=/home/jcoppersmith/data/src/reference_genomes/S4Sm_genomic.gff
ABUND_OUT=/home/jcoppersmith/data/src/diff_gene_exp/S4_DGE/stringtie-merge_out/S4_merged_abund.txt

stringtie --merge -A $ABUND_OUT -o $OUTPUT -G $GFF_IN $MERGELIST
#Keep this order!

# -o is for output file
#-G is a flag saying to use the .gff annotation file
#-A here creates a gene table output with genomic locations and compiled information that I will need later to fetch gene sequences
#FROM MANUAL: "If StringTie is run with the -A <gene_abund.tab> option, it returns a file containing gene abundances. "
#-A is not required

#Mergelist is a txt file with the file names and locations of the gtf files created in the previous step.
#I removed the RE22 control files from this list as they are superfulous to this analysis and were causing errors when no transcripts were found

#Transcript merge mode. This is a special usage mode of StringTie, distinct from the assembly usage mode described above.
#In the merge mode, StringTie takes as input a list of GTF/GFF files and merges/assembles these transcripts into a non-redundant set of transcripts.
#This mode is used in the new differential analysis pipeline to generate a global, unified set of transcripts (isoforms) across multiple RNA-Seq samples.
#If the #-G option (reference annotation) is provided, StringTie will assemble the transfrags from the input GTF files with the reference transcripts.

echo "Script finished at: "; date
