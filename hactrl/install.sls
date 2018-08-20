{% from 'hactrl/map.jinja' import hactrl with context %}

hactrl:
  file.managed:
    - name: /usr/local/bin/hactrl
    - source: salt://hactrl/files/hactrl
    - template: jinja
    - mode: 750
    - user: root
    - group: staff
    - context:
        config: {{ hactrl.config }}
