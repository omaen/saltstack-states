{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .install

{% if icinga2.client.config.ticket %}

icinga2-client-setup:
  cmd.script:
    - name: icinga2-client-setup.sh {{ icinga2.client.config.master }} {{ icinga2.client.config.ticket }}
    - source: salt://icinga2/files/icinga2-client-setup.sh
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.key
    - require:
      - pkg: icinga2
    - watch_in:
      - service: icinga2
    - watch_in:
      - file: api_conf
      - file: icinga2_conf
      - file: zones_conf

{% else %}

icinga2_get_ticket:
  event.send:
    - name: 'icinga2/master/{{ icinga2.client.config.master }}/ticket'
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.key
    - data:
        client: {{ grains['fqdn'] }}
        master: {{ icinga2.client.config.master }}

{% endif %}

icinga2_conf:
  file.managed:
    - name: /etc/icinga2/icinga2.conf
    - source: salt://icinga2/files/icinga2.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: icinga2

zones_conf:
  file.managed:
    - name: /etc/icinga2/zones.conf
    - source: salt://icinga2/files/zones.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ icinga2.client.config }}
    - watch_in:
      - service: icinga2

api_conf:
  file.managed:
    - name: /etc/icinga2/features-available/api.conf
    - source: salt://icinga2/files/api.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: icinga2
