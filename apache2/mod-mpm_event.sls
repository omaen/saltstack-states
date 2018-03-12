disable-mpm_prefork:
  cmd.run:
    - name: a2dismod mpm_prefork
    - onlyif: apache2ctl -M | grep ' mpm_prefork_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2

# This only works if libapache2-mod-php is not enabled, but as this package
# may be required by other packages leave that deconflicting up to a human
mod-mpm_event:
  cmd.run:
    - name: a2enmod mpm_event
    - unless: apache2ctl -M | grep ' mpm_event_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
      - cmd: disable-mpm_prefork
