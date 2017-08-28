{% if grains['os'] == 'Debian' %}

{% set master = salt['pillar.get']('icinga2:master', salt['pillar.get']('icinga2:lookup:master')) %}
{% set ticket = salt['pillar.get']('icinga2:ticket') %}

icinga2-client-setup:
  cmd.script:
    - source: salt://icinga2/files/icinga2-client-setup.sh {{ master }} {{ ticket }}
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.key
    - require:
      - pkg: icinga2
    - watch_in:
      - service: icinga2

{% endif %}
