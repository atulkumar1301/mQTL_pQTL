f_m = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/Metabolomics/Colocalization_Analysis/Coloc_Data_homostachydrine_10_113396427.txt", 'w', 1)
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Data/BF/mQTL_pQTL_Summary_Statistics/Metabolomics/mQTL.A_115.glm.linear", 'r') as metabolite_association_file:
#with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Tools/GWAS_Summary_Statistics/Summary_Data_AD_A_beta.txt", 'r') as GWAS_association_file:
    line = metabolite_association_file.readline ()
    for line in metabolite_association_file:
        line_list = line.split("\t")
        try:
            if int (line_list [0]) == 10:
                if (((int (line_list [1])) <=  (113396427 + 1000000)) and ((int (line_list [1])) >= (113396427 - 1000000))):
                #if (((int (line_list [2])) <=  (113396427 + 1000000)) and ((int (line_list [2])) >= (113396427 - 1000000))):
                    if "\n" in line:
                        f_m.write (line)
                    else:
                        f_m.write (line + "\n")
        except:
            print ("Not an integer")
