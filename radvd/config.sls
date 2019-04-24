{% from 'radvd/map.jinja' import radvd with context %}

radvd_conf:
  file.managed:
    - name: {{ radvd.radvd_conf }}
    - source: salt://radvd/files/radvd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - context:
        # Filter via json to avoid unset dict values becoming 'None'
        # and get some sorting for free
        config: {{ radvd.config|tojson }}
    - watch_in:
      - service: radvd
