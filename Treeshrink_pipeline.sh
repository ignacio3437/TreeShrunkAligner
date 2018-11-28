#Code to remove treeshrunk seqs
cd /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/alns
#parallel  iqtree -nt 1 -m TEST -s {} ::: *.fasta
cat *.treefile > /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/Treeshrink/genetrees_preshrink.tre
ls *.treefile > /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/Treeshrink/genetrees_list.txt
sed -i -e 's/.treefile//g' /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/Treeshrink/genetrees_list.txt
cd /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/Treeshrink
python ~/Desktop/Gitclones/TreeShrink/run_treeshrink.py -t genetrees_preshrink.tre -o TreeShrink_out -q 0.005 -r ~/Desktop/Gitclones/TreeShrink
#Create csv with gene name in first column, then taxa to remove in onther columns. name it rewritefile.csv

cd /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/
python3 ~/Desktop/git_repos/WorkInProgress/shrunktreesplitter.py --alns alns --ts_csv rewritefile.csv --outdir tsclean

mkdir tsclean_aln
cd tsclean
parallel --jobs 8 mafft --oldgenafpair --leavegappyregion --op 2 --quiet {} ">" ../tsclean_aln/{} ::: *.fasta


iqtree -nt AUTO -m TEST -s xxx -bb 1000

# while read line;do mv ${line}* /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/tsclean/ ;done < /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/genetrees/treeshrink/aln2edit.txt
# cd /Users/josec/Desktop/exoncap/Chromodorididae/TxtmFishing_Chromidae/Union_T2/tsclean
# rm -rf *.fasta.*