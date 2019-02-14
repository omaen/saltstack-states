{% from 'foxit-diode/map.jinja' import foxit_diode with context %}

foxit_licence:
  file.managed:
    - name: {{ foxit_diode.licence_file }}
    - contents_pillar: foxit_diode:licence
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - service: foxit_diode

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
