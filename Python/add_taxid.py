import sys
database = sys.argv[1]
wanted_taxid = sys.argv[2]
taxID_database = sys.argv[3]

with open(database, 'r') as fa_in:
    with open(taxID_database, 'w') as fa_out:
        for line in fa_in:
            if line.startswith(">"):
                fa_out.write(("|kraken:taxid|" + str(wanted_taxid) + " ").join(line.split(" ", 1)))
            else:
                fa_out.write(line)

'''
Uses:
python add_taxid.py input taxid output
input is a fasta file
Used to change the fasta header to make it appropriate for Kraken
TaxIDs of note:
* Bacteria    -   2
* Embryophyte -   3193
* Fungi       -   4751
* Insecta     -   50557
'''
