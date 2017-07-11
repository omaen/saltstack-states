{% if grains['os'] == 'Debian' %}
icinga2-client-setup:
  cmd.script:
    - source: salt://icinga2/files/icinga2-client-setup.sh
    - template: jinja
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.key
    - require:
      - pkg: icinga2
    - watch_in:
      - service: icinga2
{% endif %}
