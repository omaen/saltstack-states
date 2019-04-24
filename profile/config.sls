{% from 'profile/map.jinja' import profile with context %}

profile_conf:
{% if profile.config %}
  file.managed:
    - name: {{ profile.file }}
    - source: salt://profile/files/salt.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ profile.config|tojson }}
{% else %}
  file.absent:
    - name: {{ profile.file }}
{% endif %}
