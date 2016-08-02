FROM ynoami/java:java8

MAINTAINER ynoami<nyata100@gmail.com>

RUN apt-get install -y wget
RUN useradd --create-home --comment "Account for running JIRA" --shell /bin/bash jira
RUN mkdir -p /opt/atlassian

ENV JIRA_VERSION 7.1.7

RUN wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz \
    && tar -zxvf atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz -C /opt/atlassian \
    && rm atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz \
    && chown -R jira /opt/atlassian/atlassian-jira-software-${JIRA_VERSION}-standalone/ \
    && chgrp -R jira /opt/atlassian/atlassian-jira-software-${JIRA_VERSION}-standalone/

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JIRA_HOME /var/atlassian/application-data/jira

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
