{% from 'logstash/map.jinja' import logstash with context %}

include:
  - java.java-8-jre

logstash-repo:
  pkgrepo.managed:
    - name: {{ logstash.repo['5_x'] }}
    - key_url: {{ logstash.key_url }}
    - file: /etc/apt/sources.list.d/elastic-5_x.list
    - clean_file: True

logstash:
  pkg.installed:
    - name: {{ logstash.package }}
    - require:
      - pkgrepo: logstash-repo
      - pkg: java-8-jre
  service.running:
    - name: {{ logstash.service }}
    - require:
      - pkg: logstash

