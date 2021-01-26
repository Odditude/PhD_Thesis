#===============#
# The functions #
#===============#


def get_meta_cluster(a, b):
    """
    Prepares a file of only meta clusters, no sub cluster to be worked at in R. Here it will be used to find the
    clusters with only one member.
    :param a: Default a Corset file, if Grouper the columns needs to be switched.
    :param b: Output file, a text file with only the clusters in them. No genes.
    :return: Output a file with only the meta clusters, to be used in the R script for further processing.
    """
    corset_grouper_file = open(a)
    cluster_only = open(b, 'w+')


    for string in corset_grouper_file:
        cluster = string.split()[1]
        newline = cluster + '\n'
        cluster_only.write(newline)

    corset_grouper_file.close()
    cluster_only.close()

    print("It's done")

###############################


def find_cluster_members(j, k, l):
    """
    Only works if keys are unigue, so one cluster members. Gives our a list of 1-member clusters and their
    belonging genes.

    :param j: File with genes and their meta clusters.
    :param k: File with list of clusters with only one gene.
    :param l: Output file, gives out the clusters and their belonging genes.
    :return:
    """
    meta_cluster = open(j)
    one_member_cluster = open(k)
    one_member_genes = open(l, 'w+')

    dic_transcripts = dict()
    for transcript in meta_cluster:
        key_transcript = transcript.split()[1]
        value_transcript = transcript.split()[0]
        dic_transcripts[key_transcript] = value_transcript

    for member in one_member_cluster:
        member = member.strip()
        if member in dic_transcripts:
            line = member.strip("\n") + '\t' + dic_transcripts[member] + '\n'
            one_member_genes.write(line)

    one_member_genes.close()
    meta_cluster.close()
    one_member_cluster.close()

    print("It's done")

###############################


def tissue_annotation(x,y):
    """
    Gives an annotated list that includes: genes, cluster, species and tissue.
    :param x: The list of one member genes, could technically any list of genes
    :param y: The output list.
    :return: An annotated list which for each gene includes their respective species and the tissues they are from,
    unless they are from Hedin.
    """
    one_member_genes = open(x)
    cluster_tissues = open(y, "w+")

    def tissue_specifier(transcripts, species):
        if species == '159b':
            if transcripts.split()[1].startswith(('159bFlower', 'evg159bFlower')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '159b' + '\t' + 'Flower' + '\n')
            elif transcripts.split()[1].startswith(('159bLeaf','evg159bLeaf')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '159b' + '\t' + 'Leaf' + '\n')
            elif transcripts.split()[1].startswith(('159bPod', 'evg159bPod')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '159b' + '\t' + 'Pod' + '\n')
            elif transcripts.split()[1].startswith(('159bSeed', 'evg159bSeed')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '159b' + '\t' + 'Seed' + '\n')
        if species == '2378':
            if transcripts.split()[1].startswith(('Flower', 'evgFlower')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '2378' + '\t' + 'Flower' + '\n')
            elif transcripts.split()[1].startswith(('Leaf', 'evgLeaf')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '2378' + '\t' + 'Leaf' + '\n')
            elif transcripts.split()[1].startswith(('Pod', 'evgPod')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '2378' + '\t' + 'Pod' + '\n')
            elif transcripts.split()[1].startswith(('Seed', 'evgSeed')):
                cluster_tissues.write(gene.strip("\n") + '\t' + '2378' + '\t' + 'Seed' + '\n')
        if species == 'Hiverna':
            if transcripts.split()[1].startswith(('HivFlower', 'evgHivFlower')):
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hiverna' + '\t' + 'Flower' + '\n')
            elif transcripts.split()[1].startswith(('HivLeaf', 'evgHivLeaf')):
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hiverna' + '\t' + 'Leaf' + '\n')
            elif transcripts.split()[1].startswith(('HivPod', 'evgHivPod')):
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hiverna' + '\t' + 'Pod' + '\n')
            elif transcripts.split()[1].startswith(('HivSeed', 'evgHivSeed')):
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hiverna' + '\t' + 'Seed' + '\n')
        if species == 'Hedin':
            transcript_number = gene.split("_")[1]
            transcript_number = int(transcript_number.replace("utrorf", ''))
            if 1 <= transcript_number <= 44115:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Flower' + '\n')
            if 44116 <= transcript_number <= 81682:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Stem' + '\n')
            if 81683 <= transcript_number <= 111227:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Young_Leaf' + '\n')
            if 111228 <= transcript_number <= 142119:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Mature_Leaf' + '\n')
            if 142120 <= transcript_number <= 172893:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'ExpansionPod' + '\n')
            if 172894 <= transcript_number <= 208911:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'ExpansionSeed' + '\n')
            if 208912 <= transcript_number <= 243211:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'FillingPod' + '\n')
            if 243212 <= transcript_number <= 266504:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'FillingSeed' + '\n')
            if 266505 <= transcript_number <= 312747:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Mix' + '\n')
            if 312748 <= transcript_number <= 355026:
                cluster_tissues.write(gene.strip("\n") + '\t' + 'Hedin' + '\t' + 'Roots' + '\n')


    for gene in one_member_genes:
        gene_focus = gene.split()[1]
        if gene_focus.startswith(('Hedin', 'evgHedin', 'evgevgHedin')):
            tissue_specifier(gene, 'Hedin')
        elif gene_focus.startswith(('Hiv', 'evgHiv')):
            tissue_specifier(gene, 'Hiverna')
        elif gene_focus.startswith(('159b', 'evg159b')):
            tissue_specifier(gene, '159b')
        else:
            tissue_specifier(gene, '2378')

    cluster_tissues.close()
    one_member_genes.close()

    print("It's done")



#===========#
# The files #
#===========#

# get_meta_clusters
a = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/clusters_M02.txt'  # Corset or Grouper file, default Corset
b = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/Cluster_Only_M02.txt'  # Output file, only meta clusters no genes. Used by R-script to creare 1_member_Clusters.txt

#Then run:
#Cluster_preparion_python_compagnion.r

# find_cluster_members
j = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/clusters_M02.txt'  # File with genes and their meta clusters.
k = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/1_Member_Clusters_M02.txt'  # List of 1-clusters.
# Created by R-Script
l = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/One_Member_Genes_M02.txt'  # Output file, gives out the cluster and their belonging genes.

# tissue_annotation
x = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/One_Member_Genes_M02.txt'  # List of genes, here one member genes.
y = 'Z:/Work/NorfabShare/Transcriptomics/Clusters/Cluster_Tissue_Specificity_M02.txt'  #Output file, gene list with annotations i.e. species and tissue.


#=========#
# The run #
#=========#

print("What function would you like to use?" '\n')
print("1. get_meta clusters " '\n'
                "2. find_cluster_members " '\n'
                "3. tissue_annotation " '\n'
                "4. Information about the functions" '\n')
try:
    val = int(input("Choose: "))
    if val == 1:
        get_meta_cluster(a, b)
    elif val == 2:
        find_cluster_members(j, k, l)
    elif val == 3:
        tissue_annotation(x, y)
    elif val == 4:
        print('\n' "###########################################" '\n')
        print(
            "get_meta_cluster:" + '\n' + "Prepares a file of only meta clusters, no sub cluster to be worked at in R. "
                                         "Here it will be used to find the clusters with only one member.")
        print('\n' + "find_cluster_members" '\n' + "Gives a list of 1-member clusters and their belonging genes.")
        print('\n' + "tissue_annotation" + '\n' + "Gives an annotated list that includes: genes, "
                                                  "cluster, species and tissue.")
    else:
        print("Nah ah ah, Rune")
        print("Try again")
except ValueError:
    print("That was not a number, Rune")


'''
def get_meta_cluster(a, b, c):
    """
    Prepares a file of only meta clusters, no sub cluster to be worked at in R. Here it will be used to find the
    clusters with only one member.
    :param a: Default a Corset file, if Grouper the columns needs to be switched.
    :param b: Output file, removes last digits of the cluster, so only meta clusters remains
    :param c: Output file, a text file with only the clusters in them. No genes.
    :return: Output a file with only the meta clusters, to be used in the R script for further processing.
    """
    corset_grouper_file = open(a)
    meta_cluster = open(b, 'w+')
    cluster_only = open(c, 'w+')


    sep = '.'

    for line in corset_grouper_file:
        print(line)
        rest = line.rsplit(sep, 1)[0] # Uses the last .,
        print(rest)
        newline = rest + '\n'
        meta_cluster.write(newline)

    meta_cluster.close()
    meta_cluster = open(b)

    for string in meta_cluster:
        cluster = string.split()[1]
        newline = cluster + '\n'
        cluster_only.write(newline)

    corset_grouper_file.close()
    meta_cluster.close()
    cluster_only.close()

    print("It's done")

###############################
'''
