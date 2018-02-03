{% from 'tc/map.jinja' import tc with context %}

{% for if_name, commands in tc.config.post_commands.items() %}

{{ if_name }}_post_commands:
  file.managed:
    - name: {{ tc.config_dir }}/post-commands.{{ if_name }}
    - source: salt://tc/files/post-commands
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        config: {{ commands }}

{% endfor %}
