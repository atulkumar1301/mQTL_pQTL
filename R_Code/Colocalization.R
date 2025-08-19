#! /Library/Frameworks/R.framework/Versions/4.0/Resources/bin/Rscript
library(coloc)
library(data.table)
library(tidyr)
TABLE<-as.data.frame(matrix(ncol=9, nrow=5))
names(TABLE)<-c("Exposure", "Colocalization Probabilty", "SNPs","nsnps", "PP.H0.abf", "PP.H1.abf", "PP.H2.abf", "PP.H3.abf", "PP.H4.abf" )
df_1 <- fread (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/Colocalization_Analysis/Coloc_Data_succinylcarnitine_15_63131540.txt"))
colnames (df_1) <- c ("CHROM",	"POS",	"ID",	"REF",	"ALT",	"PR", "A1",	"Ommited",	"A1_FREQ",	"TEST",	"OBS_CT",	"BETA",	"SE",	"L95", "U95", "T_STAT",	"P",	"ERRCODE")
df_1 <- df_1 [order (df_1$ID, df_1$P),]
df_1_un <- df_1 [!duplicated (df_1$ID)]
df_2 <- fread (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/Colocalization_Analysis/Coloc_Data_AD_15_63131540.txt"))
colnames (df_2) <- c ("SNP",	"CHR",	"POS",	"rsID",	"Ref_Allele",	"Effect_Allele",	"Beta",	"OR",	"CI_Lower",	"CI_Upper",	"Effect_Allele_Frequency",	"P",	"SE",	"Sample_Size")
#df_2 <- separate(data = df_2, col = snpLocId, into = c("ID", "all_1", "all_2"), sep = "_")
df_2 <- df_2 [order (df_2$SNP, df_2$P),]
df_2_un_1 <- df_2 [!duplicated (df_2$SNP)]
df_2_un <- df_2_un [df_2_un_1$Beta != 0]
co <- coloc.abf(dataset1 = list(snp=df_1_un$ID, beta=df_1_un$BETA, pvalues=df_1_un$P, MAF=df_1_un$A1_FREQ, N=df_1_un$OBS_CT, type="quant"), dataset2 = list(snp=df_2_un$SNP, beta=df_2_un$Beta, pvalues=df_2_un$P, MAF=df_2_un$Effect_Allele_Frequency, N=df_2_un$Sample_Size, s=0.13 , type="cc"), MAF = NULL)
#co_1 <- coloc.abf(dataset1 = list(snp=df_2_un$ID, beta=df_2_un$beta, pvalues=df_2_un$pvalue, MAF=df_2_un$A2freq, N=1433, type="quant"), dataset2 = list(snp=df_2_un$ID, beta=df_2_un$beta, pvalues=df_2_un$pvalue, MAF=df_2_un$A2freq, N=1433, type="quant"), MAF = NULL, p1 = 1e-04, p2 = 1e-04, p12 = 1e-05)
#co_2 <- coloc.abf(dataset1 = list(snp=df_1_un$ID, beta=df_1_un$BETA, pvalues=df_1_un$P, MAF=df_1_un$A1_FREQ, N=df_1_un$OBS_CT, type="quant"), dataset2 = list(snp=df_1_un$ID, beta=df_1_un$BETA, pvalues=df_1_un$P, MAF=df_1_un$A1_FREQ, N=df_1_un$OBS_CT, type="quant"), MAF = NULL, p1 = 1e-04, p2 = 1e-04, p12 = 1e-05)
TABLE[1,1] <- "Succinylcarnitine"
TABLE[1,2] <- "AD"
TABLE[1,3] <- "rs1472631"
TABLE[1,4] <- co$summary [1]
TABLE[1,5] <- co$summary [2]
TABLE[1,6] <- co$summary [3]
TABLE[1,7] <- co$summary [4]
TABLE[1,8] <- co$summary [5]
TABLE[1,9] <- co$summary [6]
write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/Colocalization_Analysis/Coloc_Results.txt",)), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
