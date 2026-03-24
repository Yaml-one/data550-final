# Code to create table one

# Set working directory
here::i_am("code/01_table1.R") 

data <- read.csv(
  file = here::here("raw_data/raw_data.csv") # Read data in
)

# Load packages
library(gtsummary) 
library(labelled)

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

# Create table of descriptive statistics
table_one <- data |>
  tbl_summary(by = RiskLevel,
              type = BodyTemp ~ "continuous",
              statistic = list(
                all_continuous() ~ "{mean} ({sd})",
                Age ~ "{median} ({p25}, {p75})"),
              digits = BodyTemp ~ 1) |>
  modify_spanning_header(c("stat_1", "stat_2", "stat_3") ~ "**Maternal Mortality Risk Level**") |>
  add_overall()


# Save table1
saveRDS(
  table_one,
  file = here::here("output", "table_one.rds")
)