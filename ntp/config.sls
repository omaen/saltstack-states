{% from 'ntp/map.jinja' import ntp with context %}

ntp_conf:
  file.managed:
    - name: {{ ntp.config_file }}
{% if grains['oscodename'] == 'jessie' %}
    - source: salt://ntp/files/ntp.conf.jessie
{% else %}
    - source: salt://ntp/files/ntp.conf
{% endif %}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ntp
    - require:
      - pkg: ntp
    - context:
        config: {{ ntp.config|tojson }}
