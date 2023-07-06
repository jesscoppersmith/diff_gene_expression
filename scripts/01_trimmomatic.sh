#!/bin/bash
#SBATCH --job-name="trimmomatic"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --array=0
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu

####################
# BEFORE YOU BEGIN #
####################
#########
# Setup #
#########

echo "script started running at: "; date
echo "Running on host:"; hostname

threads=16
input=/home/jcoppersmith/data/src/diff_gene_exp/2021_transcriptome_reads/
#output=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/trimmed-reads/
trimlog=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/trimmomatic_log

module load Trimmomatic
module list

for reads in ${input}*;
do
output=$reads\_trimmed.fq.gz
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar SE -threads ${threads} -trimlog ${trimlog} ${reads}/*.fastq.gz ${output} ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36
# Single End parameters taken from: http://www.usadellab.org/cms/?page=trimmomatic
done

echo "script finished running at: "; date
