FROM ubuntu:16.04
MAINTAINER stp
RUN mkdir /start/
ADD start.sh /start/start.sh
RUN chmod +x /start/start.sh 
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl python git
RUN curl -sLO https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64.deb
RUN dpkg -i dumb-init_*.deb
RUN rm -rf dumb-init_*.deb
RUN curl -f -s https://getchannels.com/dvr/setup.sh | sh 
VOLUME /config, /dvr
RUN rm -Rf /channels-dvr/data/
RUN mkdir -p /config/data
RUN ln -s /config /channels-dvr/data
EXPOSE 8089
ENTRYPOINT ["dumb-init","/start/start.sh"]
