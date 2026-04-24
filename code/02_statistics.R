# Code to for t-test results table and regression model

here::i_am("code/02_statistics.R") # Set working directory

data <- read.csv(
  file = here::here("raw_data/raw_data.csv") # Read data in
)


library(gtsummary) # load packages
library(labelled)
library(broom)

# Set labels for RiskLevel variable
data$RiskLevel <- factor(data$RiskLevel,
                         levels = c("low risk", "mid risk", "high risk"),
                         labels = c("Low Risk", "Medium Risk", "High Risk"))

# Label variables
var_label(data) <- list(
  Age = "Age (yrs)",
  SystolicBP = "Systolic Blood Pressure (mmHg)",
  DiastolicBP = "Systolic Blood Pressure (mmHg)",
  BS = "Blood Sugar (mmol/L)",
  BodyTemp = "Body Temperature (F)",
  HeartRate = "Heart Rate (bpm)",
  RiskLevel = "Maternal Mortality Risk Level"
)

# Create table with p-value statistics from t-tests comparing blood pressure
# and blood sugar between low and high mortality risk level participants
table_two <- data |> 
  dplyr::filter(RiskLevel == "Low Risk" | 
                  RiskLevel == "High Risk") |>
  droplevels() |> 
  tbl_summary(by = RiskLevel,
              include = c(DiastolicBP, SystolicBP, BS),
              statistic = list(
                all_continuous() ~ "{mean} ({sd})")) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Maternal Mortality Risk Level**") |>
  add_p(test = everything() ~ "t.test")


# Save table as .rds object
saveRDS(
  table_two,
  file = here::here("output", "table_two.rds")
)


# Run simple linear regression on age and blood sugar
reg1 <- lm(BS ~ Age, data = data)

# Save regression model as .rds object
saveRDS(
  reg1,
  file = here::here("output", "reg1.rds")
)

