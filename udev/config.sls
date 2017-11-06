{% set config = salt.pillar.get('udev_rules', {}) %}

udev_rules:
  file.managed:
    - name: /etc/udev/rules.d/60-salt.rules
    - source: salt://udev/files/udev.rules
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # Filter via yaml to avoid issue where newlines are mangled to literal \n
        # for multiline strings (https://github.com/saltstack/salt/issues/30690)
        config: {{ config|yaml }}
