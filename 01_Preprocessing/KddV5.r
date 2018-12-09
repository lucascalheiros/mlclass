#Preenchimento com Knn
setwd('/home/lucas/Dev/git/mlclass-private/01_Preprocessing')
diaInfo <- read.csv(file = 'diabetes_dataset.csv')
diaAva <- read.csv(file = 'diabetes_app.csv')
diaFilled <- read.csv(file = 'fillKnn.csv')
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
# corDia1 <- c()
# corDia0 <- c()
# corDia1 <- cor(setDia1,use="complete.obs")
# corDia0 <- cor(setDia0,use="complete.obs")
# lm(setDia1[,2] ~ setDia1[,5], data=setDia1)
# pairs(setDia1)
# pairs(setDia0)


distance = function(line1, line2) {
  distVector <- abs(line1 - line2)
  dist <- abs(sum(distVector, na.rm = TRUE))
  return(dist)
}


fillKnn = function(dataSet, number) {
  for(row in 1:nrow(dataSet)) {
    for(col in 1:length(dataSet)) {
      if(is.na(dataSet[row,col])){
        bests <- c()
        for (rowTemp in 1:nrow(dataSet)) {
          if(!is.na(dataSet[rowTemp,col])){
            dist <- distance(dataSet[row,],dataSet[rowTemp,])
            line <- rowTemp
            pair <- c(line, dist)

            if( is.null(bests)||nrow(bests) < number ) {
              bests <- rbind(bests,pair)
            } else {
              for(i in 1:number) {
                if( pair[2] < bests[i,2] ) {
                  bests[i,] <- pair
                  break()
                }
              }
            }
          }
        }
        value <- c()
        for(i in number) {
          value <- cbind(value,dataSet[bests[i,1],col])
        }
        dataSet[row,col] <- mean(value)
      }
    }
  }
  return(dataSet)
}


# setDia1Fill10<-fillKnn(setDia1,10)
# setDia0Fill10<-fillKnn(setDia0,10)

setDia1Fill<-diaFilled[which(diaFilled$Outcome==1),]
setDia0Fill<-diaFilled[which(diaFilled$Outcome==0),]

randomize = function(dataSet,dataVerif) {
  for(i in 1:nrow(dataSet)){
    for(j in 1:8){
      if(is.na(dataVerif[i,j])) {
        if(dataSet[i,9] == 1) {
          dataSet[i,j] = rnorm(1, mean = dataSet[i,j], sd = dataSet[i,j]*0.3)
        } else {
          dataSet[i,j] = rnorm(1, mean = dataSet[i,j], sd = dataSet[i,j]*0.1)
        }
      }
    }
  }
  return(dataSet)
}

test0 = randomize(setDia0Fill, setDia0)
test1 = randomize(setDia1Fill, setDia1)

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
removeOutliers = function(dataSet) {
  for(i in 1:572){
    actual <- dataSet[i,]
    for(categ in 1:8){
      if(is.na(actual[categ])|| is.null(actual[categ]))
      {
        if(actual[9]==1) {
          actual[categ] = meanDia1[categ]#rnorm(1, mean = meanDia1[categ], sd = meanDia1[categ]*0.2)
        }
        else {
          actual[categ] = meanDia0[categ]#rnorm(1, mean = meanDia0[categ], sd = meanDia0[categ]*0.2)
        }
        dataSet[i,categ] = actual[categ]
      }
    }
    if(actual[9]==1)
    {
      # if(!is.na(actual[2])&&actual[2]<100.0) {
      #   dataSet[i,2] = actual[2]+20
      # }
      # if(!is.na(actual[3])&&actual[3]>100.0) {
      #   dataSet[i,3] = actual[3]-20
      # }
      # if(!is.na(actual[7])&&actual[7]>1.5) {
      #   dataSet[i,7] = actual[7] - 1
      # }
      # if(!is.na(actual[5])&&actual[5]>600) {
      #   dataSet[i,5] = actual[5] - 200
      # }
    } else {
      
      
    }
  }
  return(dataSet)
}
{
  weight <- c()
  weight[1]<-3        #Pregnancies
  weight[2]<-2.7        #Glucose
  weight[3]<-0.5        #BloodPressure
  weight[4]<-0.4        #SkinThickness
  weight[5]<-1        #Insulin
  weight[6]<-3.1       #BMI
  weight[7]<-0        #Pedigree
  weight[8]<-6.3        #Age

normalizeData = function(df) {
  for(i in 1:8){
    df[,i] <- (df[,i]/maxValue[i])*weight[i]
  } 
  return(df)
}

dfAva <- normalizeData(diaAva)
# dfInfo <- normalizeData(removeOutliers(diaFilled))
# dfInfo <- normalizeData(rbind(setDia0Fill10,setDia1Fill10))#normalizeData(diaFilled)
dfInfo <- normalizeData(rbind(test0,test1))
write.csv(dfAva[1:8], file = 'Valuator.csv', row.names = FALSE)
write.csv(dfInfo[1:9], file = 'Output.csv', row.names = FALSE)
}

