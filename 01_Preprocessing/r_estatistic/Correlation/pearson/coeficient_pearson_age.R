# A ideia desse código é encontrar o nível de correlação da feature age com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd('/home/lucas/Dev/git/mlclass-private/01_Preprocessing')

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [age x other]
age_outcome_noNA <- subset(diabetsData, diabetsData$Age != 'NA' & diabetsData$Outcome != 'NA', select = c("Age","Outcome"))

# Correlação da feature age com outcome
x_a_outcome <- cor(age_outcome_noNA, method = "pearson")
x_a_outcome <- x_a_outcome[1,2]