
from pathlib import Path

OUTPUT_FILE = "counts.txt"
my_files = list(Path(".").glob("STAR/*/ReadsPer*.tab"))

file_handles = [open(x, "r") for x in my_files]

with open(OUTPUT_FILE, "w") as f:
    header = "GeneName\t" + "\t".join([x.parent.stem for x in my_files])
    f.write(header + "\n")
    for my_lines in zip(*file_handles):
        genename = my_lines[0].split("\t")[0]
        counts = [x.split("\t")[1] for x in my_lines]
        out_line = f"{genename}\t" + "\t".join(counts)
        f.write(out_line + "\n")
