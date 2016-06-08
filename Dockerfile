FROM ubuntu:latest

MAINTAINER ynoami<nyata100@gmail.com>

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer 

RUN apt-get install -y wget
RUN wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz

RUN mkdir -p /opt/atlassian
RUN tar -zxvf atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz -C /opt/atlassian
RUN rm atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz

RUN useradd --create-home --comment "Account for running JIRA" --shell /bin/bash jira

RUN chown -R jira /opt/atlassian/atlassian-jira-software-7.1.7-standalone/
RUN chgrp -R jira /opt/atlassian/atlassian-jira-software-7.1.7-standalone/

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JIRA_HOME /var/atlassian/application-data/jira

ENTRYPOINT ["/opt/atlassian/atlassian-jira-software-7.1.7-standalone/bin/start-jira.sh", "-fg"]
