{%- from tpldir ~ "/map.jinja" import elasticsearch with context %}

include:
  - .cluster-health

reboot-elasticsearch-node:
  module.run:
    - name: system.reboot
    - require:
      - cmd: cluster-health-ok
