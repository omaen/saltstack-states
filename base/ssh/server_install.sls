{% from 'ssh/map.jinja' import ssh with context %}

ssh-server:
  pkg.installed:
    - name: {{ ssh.server.package }}
  service.running:
    - name: {{ ssh.server.service }}
    - require:
      - pkg: ssh-server
