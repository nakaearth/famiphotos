## Elasticsearch6
FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.5 AS es6
RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
# ADD elasticsearch-example-plugin-6.5.4.zip /usr/share/elasticsearch/elasticsearch-example-plugin-6.5.4.zip
# RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///usr/share/elasticsearch/elasticsearch-example-plugin-6.5.4.zip
# COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

## Elasticsearch7
FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.0 AS es7
RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
