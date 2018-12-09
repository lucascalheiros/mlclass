#Preenchimento com Regrssão
setwd('/home/lucas/Dev/git/mlclass-private/01_Preprocessing')
diaInfo <- read.csv(file = 'diabetes_dataset.csv')
diaAva <- read.csv(file = 'diabetes_app.csv')
meanDia1 <- c()
meanDia0 <- c()
maxValue <- c()
minValue <- c()
sdDia0 <- c()
sdDia1 <- c()
medianDia0 <- c()
medianDia1 <- c()

setDia1 <- diaInfo[which(diaInfo$Outcome == 1),]
setDia0 <- diaInfo[which(diaInfo$Outcome == 0),]
corDia1 <- c()
corDia0 <- c()
corDia1 <- cor(setDia1,use="complete.obs")
corDia0 <- cor(setDia0,use="complete.obs")
lm(setDia1[,2] ~ setDia1[,5], data=setDia1)
pairs(setDia1)
# pairs(setDia0)


for(categ in 1:8){
  meanDia1[categ] <- mean(setDia1[,categ],na.rm = TRUE)
  meanDia0[categ] <- mean(setDia0[,categ],na.rm = TRUE)
  maxValue[categ] <- max (diaInfo[,categ],na.rm = TRUE)
  minValue[categ] <- min (diaInfo[,categ],na.rm = TRUE)
  sdDia1  [categ] <- sd  (setDia1[,categ],na.rm = TRUE)
  sdDia0  [categ] <- sd  (setDia0[,categ],na.rm = TRUE)
  medianDia1[categ] <- median(setDia1[,categ],na.rm = TRUE)
  medianDia0[categ] <- median(setDia0[,categ],na.rm = TRUE)
}
weight <- c()
weight[1]<-2        #Pregnancies
weight[2]<-2        #Glucose
weight[3]<-1        #BloodPressure
weight[4]<-1        #SkinThickness
weight[5]<-1        #Insulin
weight[6]<-2        #BMI
weight[7]<-0       #Pedigree
weight[8]<-5        #Age


for(i in 1:572){
  actual <- diaInfo[i,]
  if(actual[9] == 1){
    if(is.na(actual[5])){
      diaInfo[i,5] = -52.162 + actual[2]*1.769
      print(diaInfo[i,5])
    }
    
  }
  for(categ in 1:8){
    if(is.na(actual[categ])|| is.null(actual[categ]))
    {
      if(actual[9]==1) {
        actual[categ] = meanDia1[categ]#rnorm(1, mean = meanDia1[categ], sd = sdDia1[categ])
      }
      else {
        actual[categ] = meanDia0[categ]#rnorm(1, mean = meanDia0[categ], sd = sdDia0[categ])
      }
      diaInfo[i,categ] = actual[categ]
    }
    if(actual[9]==0)
    {
      # if(!is.na(actual[2])&&actual[2]>170.0) {
      #   diaInfo[i,2]=actual[2]-30
      # }
      # if(!is.na(actual[7])&&actual[7]>1.5) {
      #   diaInfo[i,7] = diaInfo[i,7] - 1
      # }
      # if(!is.na(actual[5])&&actual[5]>400) {
      #   diaInfo[i,5] = diaInfo[i,5] - 200
      # }
    } else {
      
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
