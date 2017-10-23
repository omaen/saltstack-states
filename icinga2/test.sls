{% from 'icinga2/map.jinja' import icinga2 with context %}

test_conf:
  file.managed:
    - name: /etc/icinga2/test.conf
    - source: salt://icinga2/files/template.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ icinga2.config }}

