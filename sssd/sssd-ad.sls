{% from 'sssd/map.jinja' import sssd with context %}

include:
  - ad
  - .config
  - .mkhomedir

# Ensure the static hostname is the FQDN instead of the shortname. That means that /etc/hostname
# should contain the entire FQDN. If this is not the case, which it traditionally
# is _not_ (i.e `hostname` returns the non-fqdn and `hostname -f` the fqdn, instead of both returning the fqdn),
# sssd will fail to dynamically update DNS records in AD. Another approach is to specify `ad_hostname = <fqdn>`in the sssd
# config for the domain, but this means that you need an unique config for each server.
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
      # Needed for dynamic DNS updates
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
