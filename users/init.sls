{%- from tpldir ~ "/map.jinja" import users with context %}

include:
  - sudo

{% for username, params in users.items() %}
user_{{ username }}:
  user.present:
    - name: {{ username }}
    # Use tojson to avoid issues with ! being interpreted as a YAML tag
    - password: {{ params.get('password', '!')|tojson }}
  {% if params.get('shell') %}
    - shell: {{ params.get('shell') }}
  {% endif %}
    - groups:
  {% for group in params.get('groups', []) %}
      - {{ group }}
  {% endfor %}
    - remove_groups: False
    - require:
      - pkg: sudo
{% endfor %}
