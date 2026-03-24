# Code to create descriptive graph of Age and Blood Sugar

here::i_am("code/02_statistics.R") # Set working directory

data <- read.csv(
  file = here::here("raw_data/raw_data.csv") # Read data in
)

library(ggplot2) # load packages

# Create scatterplot graph of age and blood sugar
scatterplot <- 
  ggplot(data, aes(x = Age, y = BS)) +
  xlim(5, 75) + 
  geom_point() +
  geom_smooth(method = lm) +
  theme_bw() 


# Add title
scatterplot <- scatterplot + ggtitle("Age (yrs) vs. Blood Sugar (mmol/L) of Pregnant Persons in Rural Bangladesh")


# Save graph as .png object
ggsave(
  here::here("output/scatterplot.png"),
  plot = scatterplot,
  device = "png"
)
