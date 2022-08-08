FROM openjdk:11-jdk-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update
RUN apt-get -qq upgrade -y
RUN apt-get -qq install -y git wget
RUN wget -q https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
RUN tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.6.3 /opt/maven
RUN apt-get -qq install gnupg
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get -qq update
RUN apt-get -qq install sbt
RUN apt-get -qq install -y r-base
RUN apt install -y python python-pip
RUN apt install -y python3 python3-pip
# We remove ensurepip since it adds no functionality since pip is
# installed on the image and it just takes up 1.6MB on the image
RUN rm -r /usr/lib/python*/ensurepip
RUN pip install --upgrade pip setuptools

ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${PATH}:${M2_HOME}/bin

