{% from 'salt/map.jinja' import salt_config with context %}

minion_config:
  file.managed:
    - name: /etc/salt/minion.d/salt.conf
    - source: salt://salt/files/minion
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ salt_config.config.minion }}
    - watch_in:
      - service: salt-minion
