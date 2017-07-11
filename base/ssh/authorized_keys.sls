{% for user, keys in salt['pillar.get']('ssh:authorized_keys', {}).iteritems() %}
{% set gid = salt['user.info'](user).gid %}
{% set ssh_dir = salt['user.info'](user).home + '/.ssh' %}
{% set auth_file = ssh_dir + '/authorized_keys' %}

ssh_dir_{{ user }}:
  file.directory:
    - name: {{ ssh_dir }}
    - user: {{ user }}
    - group: {{ gid }}
    - dir_mode: 700

authorized_keys_{{ user }}:
  file.managed:
    - name: {{ auth_file }}
    - source: salt://ssh/files/authorized_keys
    - template: jinja
    - user: {{ user }}
    - group: {{ gid }}
    - mode: 600
    - context:
        keys: {{ keys }}
    - require:
      - pkg: ssh-server
      - file: ssh_dir_{{ user }}

{% endfor %}
