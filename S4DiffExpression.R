#DGE DESeq2 analysis of S4Sm using new reference genome when in competition with RE22

install.packages("devtools")
install.packages("data.table")   
install.packages('ggfortify')

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")


#Load packages
library(DESeq2)
library(data.table)
library(dplyr)
library(tidyr)
library(reshape2)
library(devtools)
library(ggbiplot)
library(ggplot2)
library(ggrepel)
library(ggfortify)
library(cluster)
library(data.table)


#load transcript count matrix and metadatata 
#phenodata.csv file contains metadata on the count table's samples that you create separately
###Make sure PHENODATA is in the same order or these commands will change data to be wrong!!!!###

#Load Phenodata
S4_TranColData <- read.csv("/Users/jess/Documents/Grad_School/Research/diff_gene_expression/S4/phenodata.csv", header=TRUE, sep=",")

#Load transcript count data
S4_TranscriptCountData <- as.data.frame(read.csv("/Users/jess/Documents/Grad_School/Research/diff_gene_expression/S4/S4_transcript_count_matrix.csv", row.names="transcript_id"))
head(S4_TranscriptCountData)

#change rownames to match (check order before doing this)
rownames(S4_TranColData) <- S4_TranColData$sampleID
colnames(S4_TranscriptCountData) <- S4_TranColData$sampleID
head(S4_TranColData)
head(S4_TranscriptCountData)

# Check all sample IDs in S4_TranColData are also in S4_TranscriptCountData and match their orders
all(rownames(S4_TranColData) %in% colnames(S4_TranscriptCountData))  #Should return TRUE
# returns TRUE
all(rownames(S4_TranColData) == colnames(S4_TranscriptCountData))    # should return TRUE
#returns TRUE

#Give the condition column levels
S4_TranColData$condition <- factor(S4_TranColData$condition)
levels(S4_TranColData$condition) #check to see that it has levels 

#Set up the data matrix for S4 sample analysis in DESeq
ddsS4 <- DESeqDataSetFromMatrix(countData = S4_TranscriptCountData, 
                                  colData = S4_TranColData, 
                                  design =  ~ condition)

#Pre filtering out Gene counts that are less than 10, could increase this to a haigher number to cut down on processing time if necessary
keep <- rowSums(counts(ddsS4)) >= 10
ddsS4 <- ddsS4[keep,]

#Making certain that the levels in ddsS4 are in the proper order for analysis
ddsS4$condition <- factor(ddsS4$condition, levels = c("control","treatment"))
levels(ddsS4$condition)

ddsS4$location <- factor(ddsS4$location, levels = c("biofilm","supernatant"))
levels(ddsS4$location)

colData(ddsS4)
colnames(ddsS4)
