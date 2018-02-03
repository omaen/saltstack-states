{% from 'tc/map.jinja' import tc with context %}

post_commands:
  file.managed:
    - name: {{ tc.post_commands }}
    - source: salt://tc/files/post-commands
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        config: {{ tc.config.post_commands }}
