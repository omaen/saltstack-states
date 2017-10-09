{% from 'borgbackup/map.jinja' import borgbackup with context %}

borgbackup_generate_ssh_key:
  cmd.run:
    - name: ssh-keygen -q -N '' -f {{ borgbackup.config.client.ssh_key_name }}
    - runas: root
    - unless: test -f {{ borgbackup.config.client.ssh_key_name }}

{% for server in borgbackup.orchestrate.client.auto_add_servers %}

borgbackup_add_public_key_to_{{ server }}:
  {% if borgbackup.orchestrate.client.force_server_update %}
  cmd.script:
    - source: salt://borgbackup/files/fire_ssh_key_event.py
    - env:
      - SERVER: {{ server }}
      - PUBLIC_KEY: {{ borgbackup.config.client.ssh_key_name }}.pub
    - require:
      - cmd: borgbackup_generate_ssh_key
  {% else %}
  cmd.wait_script:
    - source: salt://borgbackup/files/fire_ssh_key_event.py
    - env:
      - SERVER: {{ server }}
      - PUBLIC_KEY: {{ borgbackup.config.client.ssh_key_name }}.pub
    - watch:
      - cmd: borgbackup_generate_ssh_key
  {% endif %}

{% endfor %}
