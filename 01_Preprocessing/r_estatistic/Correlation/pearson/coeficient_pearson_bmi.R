# A ideia desse código é encontrar o nível de correlação da feature bmi com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [bmi x other]
bmi_Pedigree_noNA <- subset(diabetsData, diabetsData$BMI != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("BMI","DiabetesPedigreeFunction"))
bmi_age_noNA <- subset(diabetsData, diabetsData$BMI != 'NA' & diabetsData$Age != 'NA', select = c("BMI","Age"))
bmi_outcome_noNA <- subset(diabetsData, diabetsData$BMI != 'NA' & diabetsData$Outcome != 'NA', select = c("BMI","Outcome"))

# Correlação da feature bmi com pedrigree
x_b_pedigree <- cor(bmi_Pedigree_noNA, method = "pearson")
x_b_pedigree <- x_b_pedigree[1,2]

# Correlação da feature bmi com age
x_b_age <- cor(bmi_age_noNA, method = "pearson")
x_b_age <- x_b_age[1,2]

# Correlação da feature bmi com outcome
x_b_outcome <- cor(bmi_outcome_noNA, method = "pearson")
x_b_outcome <- x_b_outcome[1,2]