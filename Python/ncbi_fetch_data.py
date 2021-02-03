# Created by Marni Tausen

import urllib3

http = urllib3.PoolManager()

base = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
query = "Bacteria[Organism:exp] srcdb refseq[prop]"
#Embryophyte txid3193[Organism:exp] srcdb refseq[prop]
#Insecta[Organism] srcdb refseq[prop]
#Fungi[Organism] srcdb refseq[prop]

#r = http.request('GET', base+'efetch.fcgi?db=nuccore&id=34577062,24475906&rettype=fasta&retmode=text')

req = http.request('GET', base+'esearch.fcgi?db=nuccore&term='+query+'&usehistory=y')

XML = req.data

def getTAG(XML, query):
    return XML.split("<{}>".format(query),1)[-1].split("</{}>".format(query),1)[0]

print getTAG(XML, "Count")
print getTAG(XML, "QueryKey")
print getTAG(XML, "WebEnv")

Count = int(getTAG(XML, "Count"))
Key = getTAG(XML, "QueryKey")
WebEnv = getTAG(XML, "WebEnv")

retmax = 10000

f = open("Z:/Work/NorfabShare/Transcriptomics/Kraken/nrBacteriaRefSeq.fasta", "a")

for restart in range(0, Count, retmax):
    print restart, restart/float(Count)
    query = base + "efetch.fcgi?db=nuccore&WebEnv={}".format(WebEnv)
    query += "&query_key={}&retstart={}".format(Key, restart)
    query += "&retmax={}&rettype=fasta&retmode=text".format(retmax)
    req = http.request('GET', query)
    f.write(req.data)

f.close()
