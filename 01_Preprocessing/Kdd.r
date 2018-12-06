setwd('/home/lucas/Dev/git/mlclass/01_Preprocessing')
diaInfo <- read.csv(file = 'diabetes_dataset.csv')
diaAva <- read.csv(file = 'diabetes_app.csv')
diaMean <- c()
diaNonMean <- c()
maxValue <- c()
for(categ in 1:8){
diaMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 1),categ],na.rm=TRUE))
diaNonMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 0),categ],na.rm=TRUE))
maxValue[categ] = max(diaInfo[,categ],na.rm = TRUE)
}

for(i in 1:572){
  actual <- diaInfo[i,]
  for(categ in 1:8){
    if(is.na(actual[categ])|| is.null(actual[categ]))
      {
      if(actual[9]==1) {
        actual[categ] = diaMean[categ]
        }
      else {
        actual[categ] = diaNonMean[categ]
        }
      diaInfo[i,categ] = actual[categ]
      }
  }
}

normalizeData = function(df) {
  for(i in 1:8){
    df[,i] <- df[,i]/maxValue[i]
    print("test")
  } 
  return(df)
}

dfAva <- normalizeData(diaAva)
dfInfo <- normalizeData(diaInfo)

write.csv(dfAva, file = 'Valuator.csv')
write.csv(dfInfo, file = 'Output.csv')