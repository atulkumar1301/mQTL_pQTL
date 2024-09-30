f_m = open("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/mQTL-pQTL_Results.txt", 'w', 1)
with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Metabolomics/mQTL_Results.txt", 'r') as mQTLFile:
    line = mQTLFile.readline ()
    for line in mQTLFile:
        line_list = line.split("\t")
        with open ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proteomics/pQTL_Results.txt", 'r') as pQTLFile:
            line_1 = pQTLFile.readline ()
            for line_1 in pQTLFile:
                line_list_1 = line_1.split("\t")
                if (line_list [4] == line_list_1 [3]):
                    f_m.write (line.rstrip ()+ "\t" + line_1)
