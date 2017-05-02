FROM ubuntu:16.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ARG VERSION

ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
  && DEBIAN_FRONTEND=noninteractive apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade --quiet --yes \
  && DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends apt-transport-https ca-certificates \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove --yes \
  && DEBIAN_FRONTEND=noninteractive apt-get clean

RUN set -x \
  && echo 'deb [arch=all] https://aptly.tools.seibert-media.net/atlassian default main' > /etc/apt/sources.list.d/atlassian.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-keys A87623C0AADAA6F0 \
  && echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' > /etc/apt/sources.list.d/java.list \
  && echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/java.list \
  && apt-key adv --keyserver keys.gnupg.net --recv-keys 7B2C3B0889BF5709A105D03AC2518248EEA14886 \
  && echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections; echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections \
  && DEBIAN_FRONTEND=noninteractive apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade --quiet --yes \
  && DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends java-common oracle-java8-installer atlassian-confluence \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove --yes \
  && DEBIAN_FRONTEND=noninteractive apt-get clean

RUN set -x \
  && update-java-alternatives --set /usr/lib/jvm/java-8-oracle \
  && echo 'confluence.home = /var/lib/confluence' > /opt/confluence/confluence/WEB-INF/classes/confluence-init.properties \
  && sed -i 's/file:\/dev\/random/file:\/dev\/urandom/' /usr/lib/jvm/java-8-oracle/jre/lib/security/java.security \
  && sed -i 's/-Xms1024m/-Xms1024m/' /opt/confluence/bin/setenv.sh \
  && sed -i 's/-Xmx1024m/-Xmx1024m/' /opt/confluence/bin/setenv.sh \
  && sed -i 's/-Djava.awt.headless=true/-Djava.awt.headless=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false/' /opt/confluence/bin/setenv.sh

COPY files/server.xml /opt/confluence/conf/

EXPOSE 8780 8709

CMD ["/opt/confluence/bin/catalina.sh", "run"]
