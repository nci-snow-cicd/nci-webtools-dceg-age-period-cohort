FROM nrizk83/ubuntu-base-image:8

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y python-dev
RUN apt install -y libreadline-dev
RUN apt install -y python-pip
RUN apt install -y r-base
RUN pip install flask rpy2==2.8.6

RUN R -e "install.packages(c('ggplot2', 'jsonlite'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN cd /opt/ && \
    git clone https://github.com/CBIIT/nci-webtools-dceg-age-period-cohort.git

EXPOSE 10000

WORKDIR "/opt/nci-webtools-dceg-age-period-cohort/apc"
COPY runapc.sh /opt/nci-webtools-dceg-age-period-cohort/apc
RUN chmod 775 -R /opt/nci-webtools-dceg-age-period-cohort/apc/*.sh
ENTRYPOINT ["./runapc.sh"]
