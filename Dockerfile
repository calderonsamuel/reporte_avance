FROM rocker/shiny:4.2.0

RUN apt update
RUN apt install -y libmysqlclient21
RUN apt install -y libxml2-dev

RUN R -e "install.packages('pak', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rlang', repos='http://cran.rstudio.com/')"
RUN R -e "pak::pak('calderonsamuel/appReporteAvance', ask = FALSE)"

WORKDIR /srv/shiny-server/app

COPY app.R app.R
COPY .Renviron .Renviron

RUN rm /etc/shiny-server/shiny-server.conf
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

EXPOSE 3838

CMD ["/init"]
