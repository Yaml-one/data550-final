# Report on cardiovascular health of pregnant women in rural Bangladesh

------------------------------------------------------------------------

## Code description

`code/01_table1.R`

  - reads dataset in from UC Irvine Machine Learning Repository website
  - saves dataset as a `.csv` object in `raw_data/` folder
  - creates a 'Table One' of descriptive statistics and saves as
    a `.rds` object in `output/` folder

`code/02_statistics.R`

  - reads data saved by `code/01_table1.R`
  - creates a t-test table comparing blood pressure and blood sugar
    between low and high mortality risk levels and saves as a `.rds` object in 
    `output/` folder
  - runs a simple linear regression on age and blood sugar and saves as a
    `.rds` object in `output/` folder

`code/03_graph.R`

  - reads data saved by `code/01_table1.R`
  - creates scatterplot of age and blood sugar and saves as a `.rds` object
    in `output/` folder

`code/04_render_report.R`
  
  - renders `report.Rmd`

`report.Rmd`

  - loads table1 from `code/01_table1.R`
  - loads regression model and t-test table from `code/02_statistics.R`
  - loads graph from `code/03_graph.R`

------------------------------------------------------------------------
