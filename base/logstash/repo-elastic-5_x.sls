{% from 'logstash/map.jinja' import logstash with context %}

repo-elastic-5_x:
  pkgrepo.managed:
    - name: {{ logstash.repo['5_x'] }}
    - key_url: {{ logstash.key_url }}
    - file: /etc/apt/sources.list.d/elastic-5_x.list
    - clean_file: True
