FROM phusion/baseimage:0.9.16

MAINTAINER Vladimir Shulyak "vladimir@shulyak.net" (prev: Deni Bertovic "me@denibertovic.com")

ENV DEBIAN_FRONTEND noninteractive

# we could use elastic.co deb repo actually...

RUN apt-get update && apt-get install -y ca-certificates wget openjdk-7-jre
RUN wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.tar.gz -O /tmp/elasticsearch.tar.gz 2> /dev/null

RUN tar zxvf /tmp/elasticsearch.tar.gz -C /opt \
    && mv /opt/elasticsearch-1.5.2 /opt/elasticsearch \
    && rm -rf /tmp/elasticsearch.tar.gz

ADD start_elasticsearch.sh /etc/service/elasticsearch/run
RUN chmod 755 /etc/service/elasticsearch/run

VOLUME ["/opt/elasticsearch/config", "/opt/elasticsearch/data", "/opt/elasticsearch/logs"]

EXPOSE 9200
EXPOSE 9300