# Code to download data 

# Set working directory
here::i_am("code/00_download_data.R") 


# READ DATASET
# Create a temporary file name
temp <- tempfile() 

# Fetch file into temp file 
download.file("https://archive.ics.uci.edu/static/public/863/maternal+health+risk.zip",
              temp) 

# Extract target file from temp file
data <- read.csv(unz(temp, "Maternal Health Risk Data Set.csv")) 

# Remove temp file
unlink(temp)

# Set path for folder for raw data
rawdata_dir <- here::here("raw_data/") 

# Save data as CSV
write.csv(data,
          file.path(rawdata_dir, "raw_data.csv"),
          row.names = FALSE)