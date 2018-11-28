#!/usr/bin/python

from pathlib import Path
from Bio import SeqIO
import sys

'''
Reads a csv file where first column is the gene and the rest of the columns are the names of the fasta seqs to remove from that file.
The taxa in the csv are removed from the alignment and the new alignent is written to the outdir.
aligments must end in '.fasta'
'''


def rewrite(cleaned_aln_dir,how2edit,aln_dir):
    cleaned_aln_dir.mkdir(exist_ok=True)
    how2edit_lines = Path(how2edit).read_text().split('\n')
    for line in how2edit_lines:
        line_list = line.split(',')
        gene = line_list[0]
        taxa2remove = line_list[1:]
        records2write = []
        for record in SeqIO.parse(str(aln_dir/f"{gene}.fasta"), "fasta"):
            if record.name not in taxa2remove:
                records2write.append(record)
        SeqIO.write(records2write,str(cleaned_aln_dir/f"{gene}.fasta"),"fasta")
    return


def main():
    # Run the pipeline
    args = sys.argv[1:]
    usage = 'usage: python3 shrunktreesplitter.py --alns dir/with/alignmnets --ts_csv rewritefile.csv --outdir dir/for/clean/aln'
    if not args:
        print(usage)
        sys.exit(1)
    if args[0] == '--alns' and args[2] == '--ts_csv' and args[4] == '--outdir':
        aln_dir = Path(args[1])
        how2edit = args[3]
        cleaned_aln_dir = Path(args[5])
    else:
        print(usage)
        sys.exit(1)

    rewrite(cleaned_aln_dir=cleaned_aln_dir,how2edit=how2edit,aln_dir=aln_dir)

if __name__ == "__main__":
    main()