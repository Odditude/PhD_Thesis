import re

infile = open('./Transcript_total.txt')
newopen = open('./Transcript_complete.txt', 'w')
totals = open('Z:/Work/NorfabShare/Transcriptomics/Header_T02_DRAP_Hedin.okay.cds')

newopen.write("Cluster" + '\t' + "Transcript" + '\t' + "Total" + '\t' + "Aalen" + '\t'
              + "Quality%" + '\t' + "CDS_Status" + '\n')
patt = re.compile("[^\t]+")

dic_aalen = dict()
dic_percent = dict()
dic_complete = dict()

for total in totals:
    #gene = patt.findall(total)[0][:1]
    gene = total.split(" ")[0][1:]
    aaq = total.split(";")[1]
    split_aaq = aaq.split(",")
    aalen, percent, complete = split_aaq[0], split_aaq[1], split_aaq[2]
    aalen = aalen.split("=")[1]
    # gene = gene.strip('\"')
    dic_aalen[gene] = aalen
    dic_percent[gene] = percent
    dic_complete[gene] = complete


for line in infile:
    sline = line.split("\t")
    gene = sline[1]
    gene = gene.strip()
    key_aalen = dic_aalen[gene]
    key_percent = dic_percent[gene]
    key_complete = dic_complete[gene]
    line = line.strip('\n') + '\t' + key_aalen + '\t' + key_percent + '\t' + key_complete + '\n'
    newopen.write(line)

infile.close()
newopen.close()
totals.close()

