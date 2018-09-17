{% from 'frr/map.jinja' import frr with context %}

frr_daemons:
  file.managed:
    - name: /etc/frr/daemons
    - source: salt://frr/files/daemons
    - template: jinja
    - user: frr
    - group: frr
    - mode: 644
    - context:
        config: {{ frr.daemons }}
    - watch_in:
      - service: frr

frr.conf:
  file.managed:
    - name: /etc/frr/frr.conf
    - source: salt://frr/files/frr.conf
    - template: jinja
    - user: frr
    - group: frr
    - mode: 640
    - context:
       config: {{ frr.config }}
    - watch_in:
      - service: frr
