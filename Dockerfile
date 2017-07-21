FROM ubuntu:trusty
MAINTAINER  sy92th <sy92th@gmail.com>
ARG URL_SDK_TOOLS
ARG JAVA_VER
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
    rm -rf /var/cache/oracle-jdk${JAVA_VER}-installer
RUN update-java-alternatives -s java-8-oracle
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ANDROID_HOME /root/Android/Sdk
RUN wget -O sdk-tools-linux.zip ${URL_SDK_TOOLS:-https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip} --no-check-certificate
RUN apt-get update && apt-get install zip gzip tar -y
RUN mkdir /root/Android && mkdir /root/Android/Sdk && unzip sdk-tools-linux.zip -d /root/Android/Sdk && rm -rf sdk-tools-linux.zip
RUN echo "export ANDROID_HOME=/root/Android/Sdk" >> ~/.bashrc
RUN echo "export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools" >> ~/.bashrc
RUN mkdir $ANDROID_HOME/licenses
RUN yes | /root/Android/Sdk/tools/android update sdk --no-ui --all --use-sdk-wrapper --filter platform-tools


ENV ANDROID_BUILD_TOOL_VERSION 25.0.2
ENV ANDROID_VERSION 25
ENV CMD not

ADD docker-entrypoint.sh /root/
RUN chmod +x /root/docker-entrypoint.sh
ENTRYPOINT ["/root/docker-entrypoint.sh"]
