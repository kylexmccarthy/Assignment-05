ptm <- proc.time()
DF <- read.csv("CPIAUCSL.csv")
CSV_READ_TIME <- (proc.time() - ptm)
CSV_READ_TIME

class(DF)
typeof(DF)
str(DF)

getDTthreads()
getDTthreads(verbose=TRUE)
setDTthreads(0)
getDTthreads()

ptm <- proc.time()
DF <- fread("CPIAUCSL.csv", header="auto", 
            data.table=FALSE)
FREAD_READ_TIME <- (proc.time() - ptm)
FREAD_READ_TIME

class(DF)
typeof(DF)
str(DF)
names(DF)

ptm <- proc.time()
header <- read.table("CPIAUCSL.csv", header = TRUE,
                     sep=",", nrow = 1)
DF <- fread("CPIAUCSL.csv", skip=1, sep=",",
            header=FALSE, data.table=FALSE)
setnames(DF, colnames(header))
rm(header)
FREAD_READ_TIME <- (proc.time() - ptm)
FREAD_READ_TIME

class(DF)
typeof(DF)
str(DF)
names(DF)

for(i in 1:getDTthreads()) {
  setDTthreads(i)
  print(getDTthreads())
  ptm <- proc.time()
  header <- read.table("CPIAUCSL.csv", header = TRUE,
                       sep=",", nrow = 1)
  DF <- fread("CPIAUCSL.csv", skip=1, sep=",",
              header=FALSE, data.table=FALSE,
              showProgress=FALSE)
  setnames(DF, colnames(header))
  rm(header)
  print(proc.time() - ptm)
  gc()
}


