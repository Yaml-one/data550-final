# Report on cardiovascular health of pregnant women in rural Bangladesh

## Report Contents
The final report includes descriptive statistics (Table 1), t-tests comparing
risk groups, a linear regression model of age and blood sugar, and a
scatterplot of age vs. blood sugar.


# Section A: On Local Machine

------------------------------------------------------------------------

### 1. Running automated Docker image to build report

Run `pwd` in bash to ensure you have set your working directory to this project
directory

`make Win-report/Final_Analysis.html`

  - runs Docker container to automatically build report in report folder
    mounted onto your local machine for Windows OS


`make MLin-report/Final_Analysis.html`

  - runs Docker container to automatically build report in report folder
    mounted onto your local machine for Mac or Linux

------------------------------------------------------------------------

### 2. Docker weblink


Link to Docker: https://hub.docker.com/r/yamlone/final-base2


------------------------------------------------------------------------

### 3. Building the Docker image

Here are the Makefile targets for Docker-associated rules to run on your
local machine

`make final-base2`

  - builds Docker image with all necessary code and file structures to run R
    code and build report in containerized environment and uses renv package for
    package management
    
------------------------------------------------------------------------

# Section B: In Docker Containerized Environment

------------------------------------------------------------------------

### 4. Generate the final report (in Docker containerized environment)

To conduct the analysis and generate the final report, run Makefile target:
`make Final_Analysis.html`


------------------------------------------------------------------------

### 5. R Script code description

`code/00_download_data.R`
  - reads dataset in from UC Irvine Machine Learning Repository website
  - saves dataset as a `.csv` object in `raw_data/` folder

`code/01_table1.R`

  - reads data saved by `code/00_download_data.R`
  - creates a 'Table One' of descriptive statistics and saves as
    a `.rds` object in `output/` folder

`code/02_statistics.R`

  - reads data saved by `code/00_download_data.R`
  - creates a t-test table comparing blood pressure and blood sugar
    between low and high mortality risk levels and saves as a `.rds` object in 
    `output/` folder
  - runs a simple linear regression on age and blood sugar and saves as a
    `.rds` object in `output/` folder

`code/03_graph.R`

  - reads data saved by `code/00_download_data.R`
  - creates scatterplot of age and blood sugar and saves as a `.png` object
    in `output/` folder

`code/04_render_report.R`
  
  - renders `Final_Analysis.Rmd`



### Final Report File

`Final_Analysis.Rmd`

  - loads data that `code/00_download_data.R` saved in `output/` folder
  - loads table1 from `code/01_table1.R`
  - loads regression model and t-test table from `code/02_statistics.R`
  - loads graph from `code/03_graph.R`
  - includes comprehensive report of t-tests, regression, descriptive
    statistics, and graph of maternal cardiovascular health in rural Bangladesh


------------------------------------------------------------------------

### 6. Makefile commands to update packages and remove output

`make install`

  - installs and synchronizes the project’s R package environment to match the
    versions specified in the lockfile, ensuring reproducibility and preventing
    dependency mismatches.

`make clean`

  - removes all analysis, table, figure, and report outputs for ease of
    rerunning code 
    
    
------------------------------------------------------------------------






