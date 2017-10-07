{% from 'sysctl/map.jinja' import sysctl with context %}

sysctl_conf:
  file.managed:
    - name: {{ sysctl.config_file }}
    - source: salt://sysctl/files/sysctl.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ sysctl.config }}
  cmd.wait:
    - name: sysctl -p {{ sysctl.config_file }}
    - watch:
      - file: sysctl_conf
