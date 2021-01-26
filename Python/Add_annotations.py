import sys


def annotate_the_genes(a, b, c):
    """
    Prepares a file of unwanted genes, these genes does not have the approved  taxi.
    :param a: Regulated genes
    :param b: Gene Annotations - file with two columns: Gene, taxi
    :param c: Output file, see return
    :return: File with the upregulated or downregulated files with the added annotation.
    """
    gene_regulated_file = open(a)
    gene_regulated_lines = gene_regulated_file.readlines()
    wanted_annotation = open(b)
    wanted_annotation_lines = wanted_annotation.readlines()
    annotated_regulation = open(c, 'w+')
    counter = 0
    new_counter = 0

    for gene_taxi in gene_regulated_lines:
        counter += 1
        gene = gene_taxi.split("\t")[0]
        stripped_gene = gene.strip('\"')
        for anno_gene in wanted_annotation_lines:
            gene_regulation = anno_gene.split("\t")[0]
            if gene_regulation == stripped_gene:
                anno = anno_gene.split("\t")[1]
                new_counter += 1
                newline = gene_taxi.strip('\n') + "\t" + anno + '\n'
                annotated_regulation.write(newline)
                break
    print("Sequences in total: " + str(counter))
    print("Annotated sequences: " + str(new_counter))
    gene_regulated_file.close()
    annotated_regulation.close()



#=========#
# The run #
#=========#

regulated_genes_list = "/path/to/file/HL48_downregulated.txt"
wanted_annotation = "/path/to/file/Faba_transcriptome01_annotation.txt"
annotated_genes = "/path/to/file/Annotation_test.txt"

annotate_the_genes(regulated_genes_list, wanted_annotation, annotated_genes)
