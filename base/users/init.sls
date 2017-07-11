include:
  - sudo

root_user:
  user.present:
    - name: root
    - password: '!'
    - remove_groups: False

{% for username in salt['pillar.get']('users', []) %}
user_{{ username }}:
  user.present:
    - name: {{ username }}
    - password: {{ salt['pillar.get']('users:%s:password' % username) }}
    - shell: {{ salt['pillar.get']('users:%s:shell' % username, '/bin/bash') }}
    - groups:
{% for group in salt['pillar.get']('users:%s:groups' % username) %}
      - {{ group }}
{% endfor %}
    - remove_groups: False
    - require:
      - pkg: sudo
{% endfor %}
