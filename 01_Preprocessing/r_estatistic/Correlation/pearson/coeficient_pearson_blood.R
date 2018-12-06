# A ideia desse código é encontrar o nível de correlação da feature blood com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")


# Obtendo as duplas(Subsets) de colunas que não possuem NAN entre as features [blood x other]
blood_skin_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$SkinThickness != 'NA', select = c("BloodPressure","SkinThickness"))
blood_insulin_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$Insulin != 'NA', select = c("BloodPressure","Insulin"))
blood_bmi_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$BMI != 'NA', select = c("BloodPressure","BMI"))
blood_Pedigree_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("BloodPressure","DiabetesPedigreeFunction"))
blood_age_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$Age != 'NA', select = c("BloodPressure","Age"))
blood_outcome_noNA <- subset(diabetsData, diabetsData$BloodPressure != 'NA' & diabetsData$Outcome != 'NA', select = c("BloodPressure","Outcome"))

# Correlação da feature blood com skin
x_b_skin <- cor(blood_skin_noNA, method = "pearson")
x_b_skin <- x_b_skin[1,2]

# Correlação da feature blood com insulin
x_b_insulin <- cor(blood_insulin_noNA, method = "pearson")
x_b_insulin <- x_b_insulin[1,2]

# Correlação da feature blood com bmi
x_b_bmi <- cor(blood_bmi_noNA, method = "pearson")
x_b_bmi <- x_b_bmi[1,2]

# Correlação da feature blood com pedrigree
x_b_pedigree <- cor(blood_Pedigree_noNA, method = "pearson")
x_b_pedigree <- x_b_pedigree[1,2]

# Correlação da feature blood com age
x_b_age <- cor(blood_age_noNA, method = "pearson")
x_b_age <- x_b_age[1,2]

# Correlação da feature blood com outcome
x_b_outcome <- cor(blood_outcome_noNA, method = "pearson")
x_b_outcome <- x_b_outcome[1,2]