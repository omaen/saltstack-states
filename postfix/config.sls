{% from 'postfix/map.jinja' import postfix with context %}

postfix_main_cf:
  file.managed:
    - name: {{ postfix.main_cf }}
    - source: salt://postfix/files/main.cf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ postfix.config|tojson }}
    - watch_in:
      - service: postfix
