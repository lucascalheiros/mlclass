# A ideia desse código é encontrar o nível de correlação da feature skin com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [skin x other]
skin_insulin_noNA <- subset(diabetsData, diabetsData$SkinThickness != 'NA' & diabetsData$Insulin != 'NA', select = c("SkinThickness","Insulin"))
skin_bmi_noNA <- subset(diabetsData, diabetsData$SkinThickness != 'NA' & diabetsData$BMI != 'NA', select = c("SkinThickness","BMI"))
skin_Pedigree_noNA <- subset(diabetsData, diabetsData$SkinThickness != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("SkinThickness","DiabetesPedigreeFunction"))
skin_age_noNA <- subset(diabetsData, diabetsData$SkinThickness != 'NA' & diabetsData$Age != 'NA', select = c("SkinThickness","Age"))
skin_outcome_noNA <- subset(diabetsData, diabetsData$SkinThickness != 'NA' & diabetsData$Outcome != 'NA', select = c("SkinThickness","Outcome"))

# Correlação da feature skin com insulin
x_s_insulin <- cor(skin_insulin_noNA, method = "pearson")
x_s_insulin <- x_s_insulin[1,2]

# Correlação da feature skin com bmi
x_s_bmi <- cor(skin_bmi_noNA, method = "pearson")
x_s_bmi <- x_s_bmi[1,2]

# Correlação da feature skin com pedrigree
x_s_pedigree <- cor(skin_Pedigree_noNA, method = "pearson")
x_s_pedigree <- x_s_pedigree[1,2]

# Correlação da feature skin com age
x_s_age <- cor(skin_age_noNA, method = "pearson")
x_s_age <- x_s_age[1,2]

# Correlação da feature skin com outcome
x_s_outcome <- cor(skin_outcome_noNA, method = "pearson")
x_s_outcome <- x_s_outcome[1,2]