FROM rocker/rstudio

ARG RHUB_EMAIL
ARG RHUB_TOKEN
ENV RHUB_EMAIL ${RHUB_EMAIL}
ENV RHUB_TOKEN ${RHUB_TOKEN}

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
RUN Rscript -e "install.packages(c('highcharter', 'ggplot2'))"

# R Hub for GH Actions
RUN Rscript -e "install.packages('rhub')"
RUN mkdir -p /home/rstudio/.local/share/rhub/ \
  && mkdir -p /root/.local/share/rhub/ \
  && echo ${RHUB_EMAIL},${RHUB_TOKEN} > /home/rstudio/.local/share/rhub/validated_emails.csv \
  && echo ${RHUB_EMAIL},${RHUB_TOKEN} > /root/.local/share/rhub/validated_emails.csv

# Clone the repo for fast development
RUN git clone \
      https://github.com/jozefhajnala/nhlapi.git \
      /home/rstudio/nhlapi \
 && chown rstudio:rstudio /home/rstudio/nhlapi -R
