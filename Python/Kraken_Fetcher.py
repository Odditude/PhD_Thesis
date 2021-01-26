import sys


def get_unwanted_gene(a, b, c):
    """
    Prepares a file of wanted genes, these genes have the approved  taxies.
    It is a soft filter approach, allowing for gens with minimum 1 k-mer from a wanted taxi. 
    :param a: Kraken file
    :param b: List of allowed taxi
    :param c: Output file, see return
    :return: File with genes with wanted species annotations.
    """
    wanted_fractions = "3193:"
    gene_taxi_file = open(a)
    gene_taxi_lines = gene_taxi_file.readlines()
    wanted_taxi = b
    wanted_reads = open(c, 'w+')
    counter = 0
    new_counter = 0

    for gene_taxi in gene_taxi_lines:
        counter += 1
        taxi = gene_taxi.split("\t")[2]
        if taxi in wanted_taxi:
            new_counter += 1
            gene = gene_taxi.split("\t")[1]
            newline = gene + '\n'
            wanted_reads.write(newline)
        else:
            taxi_fractions = gene_taxi.split("\t")[4]
            if wanted_fractions in taxi_fractions:
                new_counter += 1
                gene = gene_taxi.split("\t")[1]
                newline = gene + '\n'
                wanted_reads.write(newline)

    print("Sequences in total: " + str(counter))
    print("Wanted sequences: " + str(new_counter))
    gene_taxi_file.close()
    wanted_reads.close()



#=========#
# The run #
#=========#

wanted_taxi = ['0', '3193']
kraken_file = sys.argv[1]
output = sys.argv[2]

get_unwanted_gene(kraken_file, wanted_taxi, output)
