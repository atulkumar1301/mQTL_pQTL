library(TwoSampleMR)
library(data.table)

### read in exposure data (pQTLs). Default settings and column names shown below, not all of this information is essential in MR, but will need at least SNP, beta, 
#se, effect allele, (eaf ideally for harmonisation).

df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/MR_Study/mQTL_Results_No_Pleiotropy_e-11.txt")

df_1 <- data.frame(df)

Exp_dat_Full <- format_data(df_1,
                            phenotype_col = "Metabolite",
                            snp_col = "ID",
                            beta_col = "BETA",
                            se_col = "SE",
                            eaf_col = "A1_FREQ",
                            effect_allele_col = "ALT",
                            other_allele_col = "REF",
                            pval_col = "P",
                            log_pval = FALSE)

Exposure_List <- unique (Exp_dat_Full$exposure)

edf_All <- data.frame()
edf_single <- data.frame()
het_stat <- data.frame()
hor_plei_stat <- data.frame()

for (metabolites in Exposure_List) {
  sub <- subset (Exp_dat_Full, exposure == metabolites)
  
  
  ### read in and match outcome data to exposure data 
  
  outcome_dat_AD=read_outcome_data (
    filename = "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Tools/GWAS_Summary_Statistics/Summary_Data_AD_p_tau.txt",
    snps = sub$SNP,
    sep = "\t",
    snp_col = "SNP",
    beta_col = "BETA",
    se_col = "SE",
    eaf_col = "effect_allele_frequency",
    effect_allele_col = "EA",
    other_allele_col = "OA",
    pval_col = "p_value",
    samplesize_col = "N",
  )
  
  #### harmonise exposure and outcome i.e. match effect alleles etc.
  dat <- harmonise_data(
    exposure_dat = sub, 
    outcome_dat = outcome_dat_AD
  )
  ### run MR using all IVs, but this function gives
  ## standard MR using default methods (can be amended in function)
  res=mr(dat)
  edf_All <- rbind (edf_All, res)
  
  ## single SNP MR - Wald ratio per IV to look at 
  res_single <- mr_singlesnp(dat)
  edf_single <- rbind (edf_single, res_single)
  
  #Sensitivity analyses
  #Heterogeneity statistics
  het <- mr_heterogeneity(dat)
  het_stat <- rbind (het_stat, het)
  
  #Horizontal pleiotropy
  hor_plei <- mr_pleiotropy_test(dat)
  hor_plei_stat <- rbind (hor_plei_stat, hor_plei)
}

write.table (edf_All, file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/MR_Study/MR_Results_Abeta_All.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

write.table (edf_single, file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/MR_Study/MR_Results_Abeta_Single.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

write.table (het_stat, file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/MR_Study/MR_Results_Heterogeneity_pTau.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

write.table (hor_plei_stat, file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/MR_Study/MR_Results_pleiotropy_pTau.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
