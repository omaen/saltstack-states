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
        # Filter via json to keep dictionary ordering from pillar.
        # This is not essential, but it is more user friendly.
        config: {{ squid.config|json }}
    - watch_in:
      - service: squid
