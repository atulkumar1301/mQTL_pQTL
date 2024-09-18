import subprocess
plink2 = "/Volumes/ATUL_6TB/Tools/./plink2"
base_file = "/Volumes/ATUL_6TB/Data/Genetic_Data/BioFINDER_2/Imputed_File/VCF_FILES_All_CHR/PLINK_Files/10_QC_GWAS_data"
pwd = "/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/"
f_m = open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/mQTL_Results.txt", 'w', 1)
f_m.write ("ID_1" + "\t" + "Metabolite" + "\t" + "CHROM" + "\t" + "POS" + "\t" + "ID" + "\t" + "REF" + "\t" + "ALT" + "\t" + "PROVISIONAL_REF?" + "\t" + "A1" + "\t" + "OMITTED" + "\t" + "A1_FREQ" + "\t" + "TEST" + "\t" + "OBS_CT" + "\t" + "BETA" + "\t" + "SE" + "\t" + "L95" + "\t" + "U95" + "\t" + "T_STAT" + "\t" + "P" + "\t" + "ERRCODE"  + "\n")
with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/Metabolite_File_Name.txt", 'r') as metabolite_file_name:
    for metabolite_name in metabolite_file_name:
        GWAS_Summary = "Results/" + metabolite_name.strip ()
        metabolite = metabolite_name.split (".")
        with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/Metabolite_Name_Coding.txt", 'r') as metabolite_coded_name_file:
            for line in metabolite_coded_name_file:
                line_list = line.split ("\t")
                if metabolite [1] == line_list [1].strip():
                   meta = line_list [0]
        print ("Started the Clumping")
        subprocess.run ([plink2, "--pfile", base_file, "--allow-extra-chr", "--clump", GWAS_Summary, "--clump-kb", "1000", "--clump-p1", "1", "--clump-p2", "1", "--clump-r2", "0.1", "--out", "Clumped_File"], cwd = pwd)
        print ("Finished Clumping")
        lead_SNPs = []
        with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/Clumped_File.clumps", 'r') as clumping:
            clump_line = clumping.readline()
            for clump_line in clumping:
                clump_line_list = clump_line.split ("\t")
                lead_SNPs.append (clump_line_list[2] )
        with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/Results/" + str (metabolite_name.strip ()), 'r') as metabolite_file:
            summary_line = metabolite_file.readline ()
            for summary_line in metabolite_file:
                summary_line_list = summary_line.split ("\t")
                if float (summary_line_list [16]) <= 5e-08:
                    if summary_line_list [2] in lead_SNPs:
                        f_m.write (str (metabolite [1] ) + "\t" + str (meta) + "\t" + summary_line)
        print ("Completed file", metabolite_name)
