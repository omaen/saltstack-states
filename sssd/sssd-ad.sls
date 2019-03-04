{% from 'sssd/map.jinja' import sssd with context %}

include:
  - ad
  - .config
  - .mkhomedir

# sssd uses the static hostname that hostnamectl returns, not the one hostname -f returns
# This breaks dynamic DNS updates for domain joined sssd computers as it only uses
# the non-FQDN hostname. This basically means that /etc/hostname should contain the FQDN
#
# Also note that you might have to set dyndns_server to <ad_dns_server> if you use another
# server as your DNS-resolver on your system, most notably 127.0.0.53 when systemd-resolved
# is in use. Your AD domain name can be used in place of a specific server if all NS records
# in the domain points to dynamically updateable AD servers.
enforce-fqdn-hostname:
  cmd.run:
    - name: hostnamectl set-hostname {{ grains['fqdn'] }}
    - unless: grep -E '^{{ grains['fqdn'] }}$' /etc/hostname

sssd-ad:
  pkg.installed:
    - pkgs:
      - {{ sssd.packages['sssd-ad'] }}
      - {{ sssd.packages['libnss-sss'] }}
      - {{ sssd.packages['libpam-sss'] }}
      - {{ sssd.packages['sssd-tools'] }}
      # nsupdate is needed to be apble to do dynamic dns updates
      - {{ sssd.packages['nsupdate'] }}
    - require:
      - cmd: enforce-fqdn-hostname
  service.running:
    - name: {{ sssd.service }}
    - require:
      - pkg: sssd-ad
      - file: sssd_conf
      - cmd: domain_join
    - watch:
      - file: sssd_conf
