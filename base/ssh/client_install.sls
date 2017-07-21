{% from 'ssh/map.jinja' import ssh with context %}

ssh-client:
  pkg.installed:
    - name: {{ ssh.client.package }}
