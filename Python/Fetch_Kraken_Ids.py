import sys


def get_kraken_ids(a, b, c):
    """
    """

    gene_ID_file = open(a)
    gene_ID_lines = gene_ID_file.readlines()
    gene_taxi_file = open(b)
    gene_taxi_lines = gene_taxi_file.readlines()
    wanted_taxi = open(c, 'w+')
    counter = 0
    new_counter = 0

    for gene_ID in gene_ID_lines:
        counter += 1
        stripped_gene = gene_ID.strip('\n')
        for gene_taxi in gene_taxi_lines:
            gene_unfiltered = gene_taxi.split('\t')[1]
            if gene_unfiltered == stripped_gene:
                taxi = gene_taxi.split('\t')[2]
                new_counter += 1
                newline = gene_unfiltered + '\t' + taxi + '\n'
                wanted_taxi.write(newline)
                break

    print("Sequences in total: " + str(counter))
    print("Wanted sequences: " + str(new_counter))
    gene_ID_file.close()
    gene_taxi_file.close()
    wanted_taxi.close()



#=========#
# The run #
#=========#


#gene_list = sys.argv[1]
#kraken_file = sys.argv[2]
#wanted_taxi = sys.argv[3]

gene_list = "Z:/Work/NorfabShare/Transcriptomics/Kraken/SoftFilter/Results_3193-DRAP_Hedin_YoungLeaf.txt"
kraken_file = "Z:/Work/NorfabShare/Transcriptomics/Kraken/SoftFilter/Results-DRAP_Hedin_YoungLeaf.txt"
wanted_taxi = "Z:/Work/NorfabShare/Transcriptomics/Kraken/SoftFilter/Full_IDs-DRAP_Hedin_YoungLeaf.txt"

get_kraken_ids(gene_list, kraken_file, wanted_taxi)
