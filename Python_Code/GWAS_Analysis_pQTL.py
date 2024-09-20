#This code perfoms the GWAS analysis using PLINK
import subprocess
plink2 = "/Volumes/ATUL_6TB/Tools/./plink2"
plink = "/Volumes/ATUL_6TB/Tools/plink_mac_20230116/./plink"
base_file = "/Volumes/ATUL_6TB/Data/Genetic_Data/BioFINDER_2/Imputed_File/VCF_FILES_All_CHR/PLINK_Files/10_QC_GWAS_data"
pwd = "/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proteomics/"
#subprocess.run ([plink2, "--pfile", base_file, "--keep", "Keep_Patients_2.txt", "--pca", "--out", "pQTL_PCA_2"], cwd = pwd)
out_file = "/Volumes/ATUL_6TB/Data/mQTL_pQTL_Summary_Statistics/Proteomics/pQTL"
subprocess.run ([plink2, "--pfile", base_file, "--keep", "Keep_Patients.txt", "--maf", "0.05", "--glm" ,"cols=+a1freq", "hide-covar", "--pheno", "Pheno.txt", "--covar", "Covariate.txt", "--covar-variance-standardize", "--ci", "0.95", "--pfilter", "1", "--out", out_file], cwd = pwd)
