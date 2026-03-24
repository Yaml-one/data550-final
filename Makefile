R_LIBS_USER := C:/Users/chang/AppData/Local/R/win-library/4.5
export R_LIBS_USER
test:
	Rscript -e ".libPaths()"

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
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html