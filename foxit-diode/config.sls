{% from 'foxit-diode/map.jinja' import foxit_diode with context %}

foxit_config_json:
  file.managed:
    - name: {{ foxit_diode.config_json }}
    - source: salt://foxit-diode/files/configuration.json
    - template: jinja
    - context:
        config: {{ foxit_diode.config }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: foxit_diode
