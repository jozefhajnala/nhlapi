FROM jozefhajnala/devr

ARG RHUB_EMAIL
ARG RHUB_TOKEN

# Charting
RUN install2.r --repos http://cran.r-project.org \
  igraph \
  highcharter

RUN mkdir -p /home/rstudio/.local/share/rhub/ \
  && mkdir -p /root/.local/share/rhub/ \
  && echo 'nhlapi@jozef.io,37aa6a58c015433a9ffea2235052abbf' > /home/rstudio/.local/share/rhub/validated_emails.csv \
  && echo 'nhlapi@jozef.io,37aa6a58c015433a9ffea2235052abbf' > /root/.local/share/rhub/validated_emails.csv

# Clone the repo for fast development
RUN git clone \
      https://github.com/jozefhajnala/nhlapi.git \
      /home/rstudio/nhlapi \
 && chown rstudio:rstudio /home/rstudio/nhlapi -R \
 && R CMD INSTALL /home/rstudio/nhlapi
