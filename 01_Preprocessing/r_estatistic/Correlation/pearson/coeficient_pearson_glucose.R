# A ideia desse código é encontrar o nível de correlação da feature glucose com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")

# Obtendo as duplas(Subsets) de colunas que não possuem NAN e procurando correlação
# entre as features [glucose x other]
glucose_blood_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$BloodPressure != 'NA', select = c("Glucose","BloodPressure"))
glucose_skin_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$SkinThickness != 'NA', select = c("Glucose","SkinThickness"))
glucose_insulin_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$Insulin != 'NA', select = c("Glucose","Insulin"))
glucose_bmi_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$BMI != 'NA', select = c("Glucose","BMI"))
glucose_Pedigree_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("Glucose","DiabetesPedigreeFunction"))
glucose_age_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$Age != 'NA', select = c("Glucose","Age"))
glucose_outcome_noNA <- subset(diabetsData, diabetsData$Glucose != 'NA' & diabetsData$Outcome != 'NA', select = c("Glucose","Outcome"))

# Correlação da feature glucose com blood
x_g_blood <- cor(glucose_blood_noNA, method = "pearson")
x_g_blood <- x_g_blood[1,2]

# Correlação da feature glucose com skin
x_g_skin <- cor(glucose_skin_noNA, method = "pearson")
x_g_skin <- x_g_skin[1,2]

# Correlação da feature glucose com insulin
x_g_insulin <- cor(glucose_insulin_noNA, method = "pearson")
x_g_insulin <- x_g_insulin[1,2]

# Correlação da feature glucose com bmi
x_g_bmi <- cor(glucose_bmi_noNA, method = "pearson")
x_g_bmi <- x_g_bmi[1,2]

# Correlação da feature glucose com pedrigree
x_g_pedigree <- cor(glucose_Pedigree_noNA, method = "pearson")
x_g_pedigree <- x_g_pedigree[1,2]

# Correlação da feature glucose com age
x_g_age <- cor(glucose_age_noNA, method = "pearson")
x_g_age <- x_g_age[1,2]

# Correlação da feature glucose com outcome
x_g_outcome <- cor(glucose_outcome_noNA, method = "pearson")
x_g_outcome <- x_g_outcome[1,2]