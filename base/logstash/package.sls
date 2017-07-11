{% from 'logstash/map.jinja' import logstash with context %}

include:
  - java.java-8-jre
  - .repo-elastic-5_x

logstash:
  pkg.installed:
    - name: {{ logstash.package }}
    - require:
      - pkgrepo: repo-elastic-5_x
      - pkg: java-8-jre
  service.running:
    - name: {{ logstash.service }}
    - require:
      - pkg: logstash

