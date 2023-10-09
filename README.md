# diff_gene_expression
 Differential Gene Expression Pipeline

# Contents

### [Scripts](S4/Scripts/)
01_trimmomatic-[01_trimmomatic_array.sh](S4/scripts/01_trimmomatic_array.sh) \
02_hisat2_build-[02_hisat2_build.sh](S4/scripts/02_hisat2_build.sh) \
03_hisat2_align-[03_hisat2_align_array.sh](S4/scripts/03_hisat2_align_array.sh) \
04_samtools-sort-[04_samtools-sort_array.sh](S4/scripts/04_samtools-sort_array.sh) \
05_samtools-stat-[05_samtools-stat_array.sh](S4/scripts/05_samtools-stat_array.sh) \
06_StringTie-[06_StringTie_array.sh](S4/scripts/06_StringTie_array.sh) \
07_StringTie-Merge-[07_StringTie-Merge.sh](S4/scripts/07_StringTie-Merge.sh) \
08_gffCompare-[08_gffCompare.sh](S4/scripts/08_gffCompare.sh) \
09_StringTie-e-[09_StringTie-e_array.sh](S4/scripts/09_StringTie-e_array.sh) \
10_prepDE-[10_prepDE.sh](S4/scripts/10_prepDE.sh)


------------------------------------------------------------------------------------------------------------------------------

# Overall pipeline

Work based on the Ballgown suite https://github.com/alyssafrazee/ballgown and DESeq2 http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

**Steps:**
1. Quality Control (FastQC)
2. Trimming (Trimmomatic)
3. Index Reference Genome (HISAT2 build)
4. Align Trimmed reads to indexed reference (HISAT2 align)
5. Sort aligned reads by starting position (Samtools Sort)
6. Stats on aligned reads (Samtools stats)
7. Assemble aligned reads into potential transcripts (StringTie)
8. Create a non-redundant transcript list (StringTie merge)
9. Create merged GTF file for all non-redundant transcripts (gffCompare)
10. Estimate coverage of merged GTF file (stringTie -e)
11. Prep for differential expression (python script)

__________________________________________________________________________________________________________________________

### [Output](output/)
