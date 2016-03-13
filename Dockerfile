FROM ubuntu:14.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
    && echo 'deb [arch=all] http://aptly.benjamin-borbe.de/atlassian default main' > /etc/apt/sources.list.d/atlassian.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-keys A87623C0AADAA6F0 \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends confluence \
    && apt-get clean \
    && echo 'confluence.home = /var/lib/confluence' > /opt/confluence/confluence/WEB-INF/classes/confluence-init.properties

ADD server.xml /opt/confluence/conf/

EXPOSE 8780 8709

CMD ["/opt/confluence/bin/catalina.sh", "run"]
