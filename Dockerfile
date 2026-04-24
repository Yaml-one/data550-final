FROM rocker/tidyverse:4.5.2 AS base

# Install vim & curl
RUN apt-get update && apt-get install -y vim && apt-get install -y curl

# Create directory & set working directory for project
RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN Rscript -e "renv::restore(prompt = FALSE)"

###### DO NOT EDIT STAGE 1 BUILD LINES ABOVE ######

# Create second image and copy contents from first image
FROM rocker/tidyverse:4.5.2

RUN mkdir /home/rstudio/project

WORKDIR /home/rstudio/project
COPY --from=base /home/rstudio/project .

# Copy Makefile and Final_Analysis.Rmd
COPY Makefile Makefile
COPY Final_Analysis.Rmd Final_Analysis.Rmd

# Create folders
RUN mkdir -p code output raw_data report

# Copy code
COPY code/00_download_data.R code/00_download_data.R
COPY code/01_table1.R code/01_table1.R
COPY code/02_statistics.R code/02_statistics.R
COPY code/03_graph.R code/03_graph.R
COPY code/04_render_report.R code/04_render_report.R





CMD ["sh", "-c", "make && mv Final_Analysis.html report"]