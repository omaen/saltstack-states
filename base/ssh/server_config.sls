{% from 'ssh/map.jinja' import ssh with context %}

sshd_config:
  file.managed:
    - name: {{ ssh.server.config_file }}
    - source: salt://ssh/files/sshd_config
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # Filter via json to avoid backslashes in pillar values being doubled
        config: {{ ssh.server.config|json }}
    - watch_in:
      - service: ssh-server
    - require:
      - pkg: ssh-server

generate-missing-host-keys:
  cmd.wait:
    - name: DEBIAN_FRONTEND="noninteractive" dpkg-reconfigure openssh-server
    - require:
      - pkg: ssh-server
    - watch:
      - file: sshd_config
