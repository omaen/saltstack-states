include:
  - .install

icinga2-master-setup:
  cmd.run:
    - name: icinga2 node setup --master
    - unless: test -f /etc/icinga2/pki/{{ grains['fqdn'] }}.crt
    - watch_in:
      - service: icinga2
