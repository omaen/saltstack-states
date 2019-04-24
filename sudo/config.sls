{% from 'sudo/map.jinja' import sudo with context %}

sudoers_local:
  file.managed:
    - name: /etc/sudoers.d/local
    - source: salt://sudo/files/local
    - template: jinja
    - user: root
    - group: root
    - mode: 440
    - makedirs: True
    - context:
        # Filter via json to avoid \ being escaped as \\
        config: {{ sudo.config|tojson }}
    - require:
      - pkg: sudo
