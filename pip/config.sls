{% from 'pip/map.jinja' import pip with context %}

pip_conf:
{% if pip.config %}
  file.managed:
    - name: /etc/pip.conf
    - source: salt://pip/files/pip.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ pip.config|tojson }}
{% else %}
  file.absent:
    - name: /etc/pip.conf
{% endif %}
