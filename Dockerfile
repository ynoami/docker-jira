FROM ynoami/java:java8

MAINTAINER ynoami<nyata100@gmail.com>

RUN apt-get install -y wget
RUN useradd --create-home --comment "Account for running JIRA" --shell /bin/bash jira
RUN mkdir -p /opt/atlassian

RUN wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz \
    && tar -zxvf atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz -C /opt/atlassian \
    && rm atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz \
    && chown -R jira /opt/atlassian/atlassian-jira-software-7.1.7-standalone/ \
    && chgrp -R jira /opt/atlassian/atlassian-jira-software-7.1.7-standalone/

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JIRA_HOME /var/atlassian/application-data/jira

ENTRYPOINT ["/opt/atlassian/atlassian-jira-software-7.1.7-standalone/bin/start-jira.sh", "-fg"]
