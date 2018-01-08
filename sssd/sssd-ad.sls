include:
  - sssd.conf
  - sssd.mkhomedir
  - sssd.join-domain

sssd-ad:
  pkg.installed:
    - pkgs:
      - sssd-ad
      - libnss-sss
      - libpam-sss
      - sssd-tools
  service.running:
    - name: sssd
    - require:
      - pkg: sssd-ad
      - file: sssd_conf
      - cmd: net-ads-join
    - watch:
      - file: sssd_conf

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
