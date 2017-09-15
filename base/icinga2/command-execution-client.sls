{% from 'icinga2/map.jinja' import icinga2 with context %}

{% if grains['os'] == 'Debian' %}

icinga2-client-setup:
  cmd.script:
    - name: icinga2-client-setup.sh {{ icinga2.config.master }} {{ icinga2.ticket }}
    - source: salt://icinga2/files/icinga2-client-setup.sh
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.key
    - require:
      - pkg: icinga2
    - watch_in:
      - service: icinga2

{% endif %}
