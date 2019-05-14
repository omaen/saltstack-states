{%- from tpldir ~ "/map.jinja" import graylog with context %}

graylog-repo:
  pkgrepo.managed:
    - name: {{ graylog.repo }}
    - key_url: {{ graylog.key_url }}
    - file: /etc/apt/sources.list.d/graylog.list
    - clean_file: True
    - require:
      - pkg: graylog-repo

graylog-java:
  pkg.installed:
    - name: {{ graylog.java_package }}

graylog:
  pkg.installed:
    - name: {{ graylog.package }}
    - hold: True
    - require:
      - pkg: graylog-java
      - pkgrepo: graylog-repo
  service.running:
    - name: {{ graylog.service }}
    - enable: True
    - require:
      - pkg: graylog
