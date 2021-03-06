{% from 'apache2/map.jinja' import apache2 with context %}

common_conf:
  file.managed:
    - name: /etc/apache2/conf-available/common.conf
    - source: salt://apache2/files/common.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # Filter via json to avoid issues with curly brackets in input
        # This is probably related to this: https://github.com/saltstack/salt/issues/7650
        config: {{ apache2|tojson }}
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
  cmd.run:
    - name: a2enconf common
    - unless: test -h /etc/apache2/conf-enabled/common.conf
    - require:
      - file: common_conf
    - watch_in:
      - service: apache2

disable_other_vhosts_access:
  cmd.run:
    - name: a2disconf other-vhosts-access-log
    - onlyif: test -h /etc/apache2/conf-enabled/other-vhosts-access-log.conf
    - require:
      - file: common_conf
    - watch_in:
      - service: apache2
