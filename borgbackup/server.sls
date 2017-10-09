{% from 'borgbackup/map.jinja' import borgbackup with context %}
{% set client_path = borgbackup.config.server.backup_dir %}

include:
  - .package

borg_user:
  user.present:
    - name: {{ borgbackup.config.server.user }}
    - gid: {{ borgbackup.config.server.group }}
    - shell: /bin/bash
    - system: True

borg_backup_dir:
  file.directory:
    - name: {{ borgbackup.config.server.backup_dir }}
    - user: {{ borgbackup.config.server.user }}
    - group: {{ borgbackup.config.server.group }}
    - mode: 755
    - require:
      - user: borg_user


{% if borgbackup.config.server.symlink is defined %}
{% set client_path = borgbackup.config.server.symlink %}

borgbackup_backup_dir_symlink:
  file.symlink:
    - name: {{ borgbackup.config.server.symlink }}
    - target: {{ borgbackup.config.server.backup_dir }}
    - require:
      - file: borg_backup_dir
{% endif %}

# This is used for reactor setups where the client ssh key is automatically added
{% if borgbackup.orchestrate.server.new_client and borgbackup.orchestrate.server.auto_add_allowed %}
borgbackup_new_client:
  ssh_auth.present:
    - name: {{ borgbackup.orchestrate.server.new_client.public_key }}
    - user: {{ borgbackup.config.server.user }}
    - options:
      - command="borg serve --restrict-to-path {{ client_path }}/{{ borgbackup.orchestrate.server.new_client.id }}"
      - no-pty
      - no-agent-forwarding
      - no-port-forwarding
      - no-X11-forwarding
      - no-user-rc
    - require:
      - user: borg_user
{% endif %}
