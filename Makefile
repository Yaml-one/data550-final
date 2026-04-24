# REPORT-ASSOCIATED RULES (run within docker container)
Final_Analysis.html: Final_Analysis.Rmd code/04_render_report.R \
  output/reg1.rds output/scatterplot.png output/table_one.rds \
  output/table_two.rds raw_data/raw_data.csv 
	Rscript code/04_render_report.R

raw_data/raw_data.csv: code/00_download_data.R
	Rscript code/00_download_data.R

output/table_one.rds: code/01_table1.R raw_data/raw_data.csv
	Rscript code/01_table1.R
	
output/table_two.rds: code/02_statistics.R raw_data/raw_data.csv
	Rscript code/02_statistics.R
	
output/reg1.rds: code/02_statistics.R raw_data/raw_data.csv
	Rscript code/02_statistics.R

output/scatterplot.png: code/03_graph.R raw_data/raw_data.csv
	Rscript code/03_graph.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f report/*.html && \
	rm -f raw_data/*.csv && rm -f *.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
# DOCKER-ASSOCIATED RULES (run on our local machine)
PROJECTFILES = Final_Analysis.Rmd code/01_table1.R code/02_statistics.R \
  code/03_graph.R code/04_render_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

# rule to build image
final-base2: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t final-base2 .
	touch $@ 

# rule to build the report automatically in our container (for Windows OS)
Win-report/Final_Analysis.html: 
	docker run -v "/$$(pwd)/report":/home/rstudio/project/report yamlone/final-base2
	
# rule to build the report automatically in our container (for Mac/Linux OX)
