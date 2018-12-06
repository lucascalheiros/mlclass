# A ideia desse código é encontrar o nível de correlação da feature insulin com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [insulin x other]
insulin_bmi_noNA <- subset(diabetsData, diabetsData$Insulin != 'NA' & diabetsData$BMI != 'NA', select = c("Insulin","BMI"))
insulin_Pedigree_noNA <- subset(diabetsData, diabetsData$Insulin != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("Insulin","DiabetesPedigreeFunction"))
insulin_age_noNA <- subset(diabetsData, diabetsData$Insulin != 'NA' & diabetsData$Age != 'NA', select = c("Insulin","Age"))
insulin_outcome_noNA <- subset(diabetsData, diabetsData$Insulin != 'NA' & diabetsData$Outcome != 'NA', select = c("Insulin","Outcome"))

# Correlação da feature insulin com bmi
x_i_bmi <- cor(insulin_bmi_noNA, method = "pearson")
x_i_bmi <- x_i_bmi[1,2]

# Correlação da feature insulin com pedrigree
x_i_pedigree <- cor(insulin_Pedigree_noNA, method = "pearson")
x_i_pedigree <- x_i_pedigree[1,2]

# Correlação da feature insulin com age
x_i_age <- cor(insulin_age_noNA, method = "pearson")
x_i_age <- x_i_age[1,2]

# Correlação da feature insulin com outcome
x_i_outcome <- cor(insulin_outcome_noNA, method = "pearson")
x_i_outcome <- x_i_outcome[1,2]