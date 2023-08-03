# diff_gene_expression
 Differential Gene Expression Pipeline

# Contents

### [Scripts](Scripts/)
01_trimmomatic-[01_trimmomatic_array.sh](scripts/01_trimmomatic_array.sh) \
02_hisat2_build-[02_hisat2_build.sh](scripts/02_hisat2_build.sh) \
03_hisat2_align-[03_hisat2_align_array.sh](scripts/03_hisat2_align_array.sh) \
04_samtools-sort-[04_samtools-sort_array.sh](scripts/04_samtools-sort_array.sh) \
05_samtools-stat-[05_samtools-stat_array.sh](scripts/05_samtools-stat_array.sh) \
06_StringTie-[06_StringTie_array.sh](scripts/06_StringTie_array.sh) \
07_StringTie-Merge-[07_StringTie-Merge.sh](scripts/07_StringTie-Merge.sh) \
08_gffCompare-[08_gffCompare.sh](scripts/08_gffCompare.sh) \
09_StringTie-e-[09_StringTie-e_array.sh](scripts/09_StringTie-e_array.sh) \
10_prepDE-[10_prepDE.sh](scripts/10_prepDE.sh)

### [Output](output/)
------------------------------------------------------------------------------------------------------------------------------

# Overall pipeline

Work based on the Ballgown suite https://github.com/alyssafrazee/ballgown and DESeq2 http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
