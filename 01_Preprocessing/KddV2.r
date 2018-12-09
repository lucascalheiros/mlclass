setwd('/home/lucas/Dev/git/mlclass-private/01_Preprocessing')
diaInfo <- read.csv(file = 'diabetes_dataset.csv')
diaAva <- read.csv(file = 'diabetes_app.csv')
diaMean <- c()
diaNonMean <- c()
maxValue <- c()
minValue <- c()
sdDia <- c()
sdNonDia <- c()
for(categ in 1:8){
  diaMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 1),categ],na.rm=TRUE))
  diaNonMean[categ] <- c(mean(diaInfo[which(diaInfo$Outcome == 0),categ],na.rm=TRUE))
  maxValue[categ] = max(diaInfo[,categ],na.rm = TRUE)
  minValue[categ] = min(diaInfo[,categ],na.rm = TRUE)
  sdDia[categ] <- c(sd(diaInfo[which(diaInfo$Outcome == 1),categ],na.rm=TRUE))
  sdNonDia[categ] <- c(sd(diaInfo[which(diaInfo$Outcome == 0),categ],na.rm=TRUE))
}
weight <- c()
weight[1]=2
weight[2]=3
weight[3]=0.5
weight[4]=1
weight[5]=1
weight[6]=2
weight[7]=0.5
weight[8]=3

for(i in 1:572){
  actual <- diaInfo[i,]
  for(categ in 1:8){
    # if(xor(!is.na(actual[4]),!is.na(actual[6]))){
    #   if(is.na(actual[4])){
    #     diaInfo[i,4] = actual[6]*0.351
    #   }else{
    #     diaInfo[i,6] = actual[4]*1/0.351
    #   }
    #   
    # }
    if(is.na(actual[categ])|| is.null(actual[categ]))
    {
      randomizer <- runif(1,min=0.2,max=1) 
      if(actual[9]==1) {
        # actual[categ] = diaMean[categ] + sdDia[categ]*randomizer
        actual[categ] = rnorm(1, mean = diaMean[categ], sd = sdDia[categ])+ sdDia[categ]*randomizer
      }
      else {
        # actual[categ] = diaNonMean[categ] + sdNonDia[categ]*randomizer
        actual[categ] = rnorm(1, mean = diaNonMean[categ], sd = sdNonDia[categ])#+ sdNonDia[categ]*randomizer
      }
      diaInfo[i,categ] = actual[categ]
    }
  }
  if(actual[9]==0) {
    # if(actual[1]>60) {
    #   diaInfo[i,1] = diaInfo[i,1]-10
    # }
    # if(actual[6]>110) {
    #    diaInfo[i,6] = diaInfo[i,6] - 30
    # }
    if(actual[7]>1.5) {
      diaInfo[i,7] = diaInfo[i,7] - 1
    }
    if(actual[2]>170) {
      diaInfo[i,2] = diaInfo[i,2] - 30
    }
    if(actual[5]>300) {
      diaInfo[i,5] = diaInfo[i,5] - 200
    }
  } else {
    
  }
}
for(i in 1:8){
  minValue[i] = min(diaInfo[,i],na.rm = TRUE)
}
normalizeData = function(df) {
  for(i in 1:8){
    if(minValue[i] < 0) {
      df[,i] <- (df[,i]-minValue[i])
    }
    df[,i] <- (df[,i]/maxValue[i])*weight[i]
  } 
  return(df)
}

dfAva <- normalizeData(diaAva)
dfInfo <- normalizeData(diaInfo)

write.csv(dfAva[1:8], file = 'Valuator.csv', row.names = FALSE)
write.csv(dfInfo[1:9], file = 'Output.csv', row.names = FALSE)
