{% from 'borgbackup/map.jinja' import borgbackup with context %}
{% set client_path = borgbackup.server.config.backup_dir %}

include:
  - .package

borg_user:
  user.present:
    - name: {{ borgbackup.server.config.user }}
    - gid: {{ borgbackup.server.config.group }}
    - shell: /bin/bash
    - system: True

borg_backup_dir:
  file.directory:
    - name: {{ borgbackup.server.config.backup_dir }}
    - user: {{ borgbackup.server.config.user }}
    - group: {{ borgbackup.server.config.group }}
    - mode: 755
    - require:
      - user: borg_user


{% if borgbackup.server.config.symlink is defined %}
{% set client_path = borgbackup.server.config.symlink %}

borgbackup_backup_dir_symlink:
  file.symlink:
    - name: {{ borgbackup.server.config.symlink }}
    - target: {{ borgbackup.server.config.backup_dir }}
    - require:
      - file: borg_backup_dir

{% endif %}

# This is used for reactor setups where the client ssh key is automatically added
{% if borgbackup.orchestrate.server.new_client and borgbackup.orchestrate.server.auto_add_allowed %}
borgbackup_new_client:
  ssh_auth.present:
    - name: {{ borgbackup.orchestrate.server.new_client.public_key }}
    - user: {{ borgbackup.server.config.user }}
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
