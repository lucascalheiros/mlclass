#setwd('/home/lucas/Dev/git/mlclass/01_Preprocessing')
diaInfo <- read.csv(file = 'diabetes_dataset.csv')
diaAva <- read.csv(file = 'diabetes_app.csv')
diaMean <- c()
diaNonMean <- c()
maxValue <- c()
sdDia <- c()
sdNonDia <- c()
for(categ in 1:8){
  diaMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 1),categ],na.rm=TRUE))
  diaNonMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 0),categ],na.rm=TRUE))
  maxValue[categ] = max(diaInfo[,categ],na.rm = TRUE)
  sdDia[categ] <- c(sd(diaInfo[which(diaInfo$Outcome == 1),categ],na.rm=TRUE))
  sdNonDia[categ] <- c(sd(diaInfo[which(diaInfo$Outcome == 0),categ],na.rm=TRUE))
}
weight <- c()
weight[1]=2
weight[2]=2
weight[3]=1
weight[4]=1
weight[5]=1
weight[6]=2
weight[7]=0
weight[8]=6

for(i in 1:572){
  actual <- diaInfo[i,]
  for(categ in 1:8){
    if(is.na(actual[categ])|| is.null(actual[categ]))
    {
      randomizer <- runif(1,min=-2,max=2) 
      if(actual[9]==1) {
        actual[categ] = diaMean[categ] + sdDia[categ]*randomizer
      }
      else {
        actual[categ] = diaNonMean[categ] + sdNonDia[categ]*randomizer
      }
      diaInfo[i,categ] = actual[categ]
    }
  }
}

normalizeData = function(df) {
  for(i in 1:8){
    df[,i] <- (df[,i]/maxValue[i])*weight[i]
  } 
  return(df)
}

dfAva <- normalizeData(diaAva)
dfInfo <- normalizeData(diaInfo)

write.csv(dfAva[1:8], file = 'Valuator.csv', row.names = FALSE)
write.csv(dfInfo[1:9], file = 'Output.csv', row.names = FALSE)