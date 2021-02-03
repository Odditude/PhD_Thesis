import re

infile = open('./newfile.txt')
newopen = open('./Transcript_total.txt', 'w')
totals = open('Z:/Work/NorfabShare/Transcriptomics/T02_Total_salmon_hedin_08022019.txt')

patt = re.compile("[^\t]+")
dic_total = dict()
for total in totals:
    gene = patt.findall(total)[0]
    expression = patt.findall(total)[1]
    gene = gene.strip('\"')
    dic_total[gene] = expression


for line in infile:
    sline = line.split("\t")
    gene = sline[1]
    gene = gene.strip()
    KeyA = dic_total[gene]
    line = line.strip('\n') + '\t' + KeyA
    newopen.write(line)

infile.close()
newopen.close()
totals.close()


