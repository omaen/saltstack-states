{% for user, keys in salt['pillar.get']('ssh:server:authorized_keys', {}).items() %}

authorized_keys_{{ user }}:
  ssh_auth.present:
    - user: {{ user }}
    - names:
      {% for name, key in keys.items() %}
      - {{ key }}
      {% endfor %}

{% endfor %}
