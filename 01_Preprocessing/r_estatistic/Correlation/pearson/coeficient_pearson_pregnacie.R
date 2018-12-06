# A ideia desse código é encontrar o nível de correlação da feature pregnacie com as demais

# Coloquem o diretorio que possui o dataset no seu computador.
setwd("/home/johnomena/mlclass/01_Preprocessing")

# Lendo o dataset em um dataframe
diabetsData <- read.csv("diabetes_dataset.csv")

# Obtendo as duplas(Subsets) de colunas que não possuem NAN e procurando correlação
# entre as features [pregnancies x other]
pregnancies_glucose_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$Glucose != 'NA', select = c("Pregnancies","Glucose"))
pregnancies_blood_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$BloodPressure != 'NA', select = c("Pregnancies","BloodPressure"))
pregnancies_skin_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$SkinThickness != 'NA', select = c("Pregnancies","SkinThickness"))
pregnancies_insulin_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$Insulin != 'NA', select = c("Pregnancies","Insulin"))
pregnancies_bmi_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$BMI != 'NA', select = c("Pregnancies","BMI"))
pregnancies_Pedigree_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$DiabetesPedigreeFunction != 'NA', select = c("Pregnancies","DiabetesPedigreeFunction"))
pregnancies_age_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$Age != 'NA', select = c("Pregnancies","Age"))
pregnancies_outcome_noNA <- subset(diabetsData, diabetsData$Pregnancies != 'NA' & diabetsData$Outcome != 'NA', select = c("Pregnancies","Outcome"))

# Correlação da feature pregnancie com glucose
x_p_glucose <- cor(pregnancies_glucose_noNA, method = "pearson")
x_p_glucose <- x_p_glucose[1,2]

# Correlação da feature pregnancie com blood
x_p_blood <- cor(pregnancies_blood_noNA, method = "pearson")
x_p_blood <- x_p_blood[1,2]

# Correlação da feature pregnancie com skin
x_p_skin <- cor(pregnancies_skin_noNA, method = "pearson")
x_p_skin <- x_p_skin[1,2]

# Correlação da feature pregnancie com insulin
x_p_insulin <- cor(pregnancies_insulin_noNA, method = "pearson")
x_p_insulin <- x_p_insulin[1,2]

# Correlação da feature pregnancie com bmi
x_p_bmi <- cor(pregnancies_bmi_noNA, method = "pearson")
x_p_bmi <- x_p_bmi[1,2]

# Correlação da feature pregnancie com pedrigree
x_p_pedigree <- cor(pregnancies_Pedigree_noNA, method = "pearson")
x_p_pedigree <- x_p_pedigree[1,2]

# Correlação da feature pregnancie com age
x_p_age <- cor(pregnancies_age_noNA, method = "pearson")
x_p_age <- x_p_age[1,2]

# Correlação da feature pregnancie com outcome
x_p_outcome <- cor(pregnancies_outcome_noNA, method = "pearson")
x_p_outcome <- x_p_outcome[1,2]