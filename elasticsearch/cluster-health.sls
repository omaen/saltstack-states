{%- from tpldir ~ "/map.jinja" import elasticsearch with context %}

cluster-health-ok:
  cmd.script:
    - source: salt://elasticsearch/files/healthcheck.sh
    - args: '-u "{{ elasticsearch.healthcheck_url }}"'
    - onlyif: systemctl is-active {{ elasticsearch.service }}.service
