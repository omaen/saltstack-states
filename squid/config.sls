{% from 'squid/map.jinja' import squid with context %}

squid_conf:
  file.managed:
    - name: {{ squid.squid_conf }}
    - source: salt://squid/files/squid.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - context:
        config: {{ squid.config }}
    - watch_in:
      - service: squid
