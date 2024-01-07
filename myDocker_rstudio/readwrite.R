#R file for doing read and write
cat("Reading file......\n")
infile <- readLines("input.txt")

outfile <- append(infile, "\nI'm Dr. Nick!\n(yaml/compose)")

cat("Writing file......\n")
writeLines(outfile, "output.txt")
cat("R version:", R.version[["major"]],".", R.version[["minor"]],"\n")
cat("Done!!\n")