
#FROM alpine
#RUN apk add openjdk8
#RUN apk add maven
#RUN apk add git
FROM ubuntu:18.04
#FROM selenium/standalone-chrome
RUN apt-get update \
    && apt-get install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN  apt-get update \
	 && apt-get -y install curl
RUN  apt-get update && \
	 apt-get install -y openjdk-8-jdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/bin
RUN   apt-get update \
  &&  apt-get install -y wget \
  &&  rm -rf /var/lib/apt/lists/*
RUN apt-get update \
  &&  apt-get install -y gnupg
RUN  curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get -y update \
  && apt-get -y install google-chrome-stable
RUN wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
RUN apt-get update \
  &&  apt-get install -y unzip
RUN unzip chromedriver_linux64.zip
RUN  mv chromedriver /usr/bin/chromedriver \
  && chown root:root /usr/bin/chromedriver \
  && chmod +x /usr/bin/chromedriver
RUN wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
RUN mv selenium-server-standalone-3.141.59.jar /usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/lib/ext/selenium-server-standalone-3.141.59.jar

# Default configuration
ENV DISPLAY :20.0
ENV SCREEN_GEOMETRY "1440x900x24"
ENV CHROMEDRIVER_PORT 4444
ENV CHROMEDRIVER_WHITELISTED_IPS "127.0.0.1"
ENV CHROMEDRIVER_URL_BASE ''
ENV CHROMEDRIVER_EXTRA_ARGS ''

EXPOSE 4444
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

