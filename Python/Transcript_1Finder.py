infile = open('Z:/Work/NorfabShare/Transcriptomics/mag.flat.clust')
newopen = open('./newfile.txt', 'w')
transcripts = open('Z:/Work/NorfabShare/Transcriptomics/RNames_T02_salmon_hedin_08022019.txt')

dic_transcripts = dict()
for transcript in transcripts:
    transcript = transcript.strip()
    dic_transcripts[transcript] = 0

print(len(dic_transcripts))

for line in infile:
    gene = line.split("\t")[-1].strip()
    if gene in dic_transcripts:
        newopen.write(line)



infile.close()
newopen.close()
transcripts.close()
