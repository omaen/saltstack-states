{% from 'sssd/map.jinja' import sssd with context %}

sssd_conf:
  pkg.installed:
    - name: {{ sssd.packages['sssd-common'] }}
  file.managed:
    - name: {{ sssd.sssd_conf }}
    - source: salt://sssd/files/sssd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ sssd.config|tojson }}
    - require:
      - pkg: sssd_conf

#
# This is needed to remove annoing SECURITY mail sent to root everytime you
# use sudo ("problem with defaults entries"). Verified on both jessie and stretch
#
nsswitch-sudoers:
  file.replace:
    - name: /etc/nsswitch.conf
    - pattern: 'sudoers:        files sss'
    - repl: 'sudoers:        files'
    - require:
      - pkg: sssd-ad
  cmd.wait:
    - name: /sbin/ldconfig
    - watch:
      - file: nsswitch-sudoers
