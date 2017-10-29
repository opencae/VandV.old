plotOrder <- read.csv("plotOrder.csv")
order <- plotOrder[,"Order"]
no <- 1:length(order)

out <- file("xtics.gp","w")
writeLines("set xtics (",out,sep="")
writeLines(sprintf("\"%d\" %d",order,no),out,sep=",")
writeLines("\"\" 0) rotate nomirror",out,sep="\n")
close(out)
