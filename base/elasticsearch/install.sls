{% from 'elasticsearch/map.jinja' import elasticsearch with context %}

include:
  - java.java-8-jre

elasticsearch-repo:
  pkgrepo.managed:
    - name: {{ elasticsearch.repo['5_x'] }}
    - key_url: {{ elasticsearch.key_url }}
    - file: /etc/apt/sources.list.d/elastic-5_x.list
    - clean_file: True

elasticsearch:
  pkg.installed:
    - name: {{ elasticsearch.package }}
    - hold: True
    - require:
      - pkgrepo: elasticsearch-repo
      - pkg: java-8-jre
  service.running:
    - name: {{ elasticsearch.service }}
    - require:
      - pkg: elasticsearch
