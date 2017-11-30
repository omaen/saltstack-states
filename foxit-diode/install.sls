{% from 'foxit-diode/map.jinja' import foxit_diode with context %}

foxit_diode:
  service.running:
    - name: {{ foxit_diode.service }}
    - reload: True
