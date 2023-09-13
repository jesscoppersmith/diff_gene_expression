#!/bin/bash
#SBATCH --job-name="trimmomatic"
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

module load Trimmomatic
module list

#########################################

INPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/2021_transcriptome_reads
OUTPUT_DIR=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/trimmed-reads
trimlog=/home/jcoppersmith/data/src/diff_gene_exp/RE22_DGE/trimmomatic_logs/trimlog
threads=16

file=`ls $INPUT_DIR/*/*.fastq.gz | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
base=`echo $file | sed 's/_R1_001.fastq.gz//g' | cut -c 88-`
#the cut option did not work perfectly here
#- trimming some files one character too short due to not having a double digit number identifer

echo ".....processing file $base at"

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar SE -threads ${threads} -trimlog $trimlog.$base".txt" \
$file $OUTPUT_DIR/$base"_trimmed.fq.gz" ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36
# Single End parameters taken from: http://www.usadellab.org/cms/?page=trimmomatic

echo "Script finished at: "; date
