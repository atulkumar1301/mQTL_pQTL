from pathlib import Path
from pathlib import PurePath
import sys
import subprocess
plink2 = "/Volumes/ATUL_6TB/Tools/./plink2"
base_file = "/Volumes/ATUL_6TB/Data/Genetic_Data/BioFINDER_2/Imputed_File/VCF_FILES_All_CHR/PLINK_Files/10_QC_GWAS_data"
pwd = "/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proteomics/"
f_m = open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proteomics/pQTL_Results.txt", 'w', 1)
f_m.write ("Protein" + "\t" + "CHROM" + "\t" + "POS" + "\t" + "ID" + "\t" + "REF" + "\t" + "ALT" + "\t" + "PROVISIONAL_REF?" + "\t" + "A1" + "\t" + "OMITTED" + "\t" + "A1_FREQ" + "\t" + "TEST" + "\t" + "OBS_CT" + "\t" + "BETA" + "\t" + "SE" + "\t" + "L95" + "\t" + "U95" + "\t" + "T_STAT" + "\t" + "P" + "\t" + "ERRCODE"  + "\n")
source_dir = Path('/Volumes/ATUL_6TB/Data/mQTL_pQTL_Summary_Statistics/Proteomics/')
files = source_dir.iterdir()
files = source_dir.glob('*.glm.linear')
for file_names in files:
    path_split = PurePath(file_names).parts
    sum_file_name = path_split [6]
    protein_name = sum_file_name.split (".")
    GWAS_Summary = file_names
    print ("Started the Clumping")
    subprocess.run ([plink2, "--pfile", base_file, "--allow-extra-chr", "--clump", GWAS_Summary, "--clump-kb", "1000", "--clump-p1", "1", "--clump-p2", "1", "--clump-r2", "0.1", "--out", "Clumped_File"], cwd = pwd)
    print ("Finished Clumping")
    lead_SNPs = []
    with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proteomics/Clumped_File.clumps", 'r') as clumping:
        clump_line = clumping.readline()
        for clump_line in clumping:
            clump_line_list = clump_line.split ("\t")
            lead_SNPs.append (clump_line_list[2] )
        with open (file_names, 'r') as proteomic_Summary_file:
            summary_line = proteomic_Summary_file.readline ()
            for summary_line in proteomic_Summary_file:
                summary_line_list = summary_line.split ("\t")
                if float (summary_line_list [16]) <= 5e-08:
                    if summary_line_list [2] in lead_SNPs:
                        f_m.write (str (protein_name [1]) + "\t" + summary_line)
        print ("Completed file", protein_name [1])
