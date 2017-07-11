ssh-server:
  pkg.installed:
    - name: openssh-server
  service.running:
    - name: ssh
    - require:
      - pkg: ssh-server

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
{% if grains['oscodename'] == 'jessie' %}
    - source: salt://ssh/files/sshd_config.jessie
{% else %}
    - source: salt://ssh/files/sshd_config.stretch
{% endif %}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
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
