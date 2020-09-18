FROM rocker/rstudio

ARG RHUB_EMAIL
ARG RHUB_TOKEN

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    qpdf

# Basics do build and check
RUN Rscript -e "install.packages(c('jsonlite', 'nhlapi', 'knitr'))"

# Full development suite with RStudio
RUN Rscript -e "install.packages(c('roxygen2', 'devtools'))"

# Data handling
RUN Rscript -e "install.packages(c('poorman', 'data.table', 'dplyr'))"

# Charting
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('igraph', repos = 'https://cloud.r-project.org', Ncpus = parallel::detectCores())"
RUN Rscript -e "install.packages('highcharter')"

# R Hub for GH Actions
RUN Rscript -e "install.packages('rhub')"
RUN mkdir -p /home/rstudio/.local/share/rhub/ \
  && mkdir -p /root/.local/share/rhub/ \
  && echo 'nhlapi@jozef.io,37aa6a58c015433a9ffea2235052abbf' > /home/rstudio/.local/share/rhub/validated_emails.csv \
  && echo 'nhlapi@jozef.io,37aa6a58c015433a9ffea2235052abbf' > /root/.local/share/rhub/validated_emails.csv

# Clone the repo for fast development
RUN git clone \
      https://github.com/jozefhajnala/nhlapi.git \
      /home/rstudio/nhlapi \
 && chown rstudio:rstudio /home/rstudio/nhlapi -R
