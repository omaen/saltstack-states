{% from 'borgbackup/map.jinja' import borgbackup with context %}

borgbackup_client_ssh_key:
  cmd.run:
    - name: ssh-keygen -q -N '' -f {{ borgbackup.config.client.ssh_key_name }}
    - runas: root
    - unless: test -f {{ borgbackup.config.client.ssh_key_name }}


{% for server in borgbackup.config.client.auto_add_servers %}

borgbackup_add_to_{{ server }}:
  cmd.wait_script:
    - source: salt://borgbackup/files/fire_ssh_key_event.py
    - env:
      - SERVER: {{ server }}
      - PUBLIC_KEY: {{ borgbackup.config.client.ssh_key_name }}.pub
    - watch:
      - cmd: borgbackup_client_ssh_key

{% endfor %}
