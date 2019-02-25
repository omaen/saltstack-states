{%- from tpldir ~ "/map.jinja" import nftables with context %}

include:
  - nftables.install

nftables-config:
  file.managed:
    - name: {{ nftables.config }}
    - source: salt://nftables/files/etc/nftables.conf.tmpl
    - mode: 640
    - user: root
    - group: root
    - template: jinja
    - context:
        ruleset: {{ nftables.ruleset|yaml(False) }}
