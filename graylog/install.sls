{%- from tpldir ~ "/map.jinja" import graylog with context %}

graylog-repo:
  pkg.installed:
    - sources:
      - {{ graylog.repo_package }}: {{ graylog.repo_package_url }}
  cmd.run:
    - name: apt-get update
    - onchanges:
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
      - cmd: graylog-repo
  service.running:
    - name: {{ graylog.service }}
    - enable: True
    - require:
      - pkg: graylog
