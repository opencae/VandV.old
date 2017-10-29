zRef <- 2./250.
z0 <- 0.005
z1 <- 0.010
U0 <- 0.365
U1 <- 0.390
alpha <- (zRef-z0)/(z1-z0)
URef1 <- ((1-alpha)*U0+alpha*U1)

zRef <- 15.9/250.
z0 <- 0.050
z1 <- 0.100
U0 <- 0.483
U1 <- 0.559
Uboundary <- 7.8
alpha <- (zRef-z0)/(z1-z0)
URef2 <- ((1-alpha)*U0+alpha*U1)

R <- URef2/URef1

dir <- strsplit(getwd(),"/")[[1]]
wd <- dir[length(dir)-1]

plotOrder <- read.csv("../plotOrder.csv")
order <- plotOrder[,"Order"]

U <- read.csv("U_after_construction.csv")
No <- U[,"No"]

U <- U[,wd] * R
out <- file("U.txt","w")
writeLines(sprintf("%d %g",order,U[order]),out,sep="\n")
close(out)
