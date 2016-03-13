FROM ubuntu:14.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
  && echo 'deb [arch=all] http://aptly.benjamin-borbe.de/atlassian default main' > /etc/apt/sources.list.d/atlassian.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-keys A87623C0AADAA6F0 \
  && echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' > /etc/apt/sources.list.d/java.list \
  && echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/java.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-keys 7B2C3B0889BF5709A105D03AC2518248EEA14886 \
  && echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections; echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections \
  && apt-get update --quiet \
  && apt-get install --quiet --yes --no-install-recommends ca-certificates confluence \
  && apt-get clean

RUN set -x \
  && update-java-alternatives --set /usr/lib/jvm/java-8-oracle \
  && echo 'confluence.home = /var/lib/confluence' > /opt/confluence/confluence/WEB-INF/classes/confluence-init.properties \
  && sed -i 's/file:\/dev\/random/file:\/dev\/urandom/' /usr/lib/jvm/java-8-oracle/jre/lib/security/java.security \
  && sed -i 's/-Xms1024m/-Xms400m/' /opt/confluence/bin/setenv.sh \
  && sed -i 's/-Xmx1024m/-Xmx400m/' /opt/confluence/bin/setenv.sh

ADD server.xml /opt/confluence/conf/

EXPOSE 8780 8709

CMD ["/opt/confluence/bin/catalina.sh", "run"]
