sudoers_local:
  file.managed:
    - name: /etc/sudoers.d/local
    - source: salt://sudo/files/local
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: sudo
