# A ideia desse código é encontrar o nível de correlação da feature pedigree com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [pedigree x other]
pedigree_age_noNA <- subset(diabetsData, diabetsData$DiabetesPedigreeFunction != 'NA' & diabetsData$Age != 'NA', select = c("DiabetesPedigreeFunction","Age"))
pedigree_outcome_noNA <- subset(diabetsData, diabetsData$DiabetesPedigreeFunction != 'NA' & diabetsData$Outcome != 'NA', select = c("DiabetesPedigreeFunction","Outcome"))

# Correlação da feature pedigree com age
x_p_age <- cor(pedigree_age_noNA, method = "pearson")
x_p_age <- x_p_age[1,2]

# Correlação da feature pedigree com outcome
x_p_outcome <- cor(pedigree_outcome_noNA, method = "pearson")
x_p_outcome <- x_p_outcome[1,2]