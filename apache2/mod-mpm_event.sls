disable-mpm_prefork:
  cmd.run:
    - name: a2dismod mpm_prefork
    - onlyif: ls /etc/apache2/mods-enabled/mpm_prefork.load
    - require:
      - pkg: apache2

# This only works if libapache2-mod-php is not enabled, but as this package
# may be required by other packages leave that deconflicting up to a human
mod-mpm_event:
  cmd.run:
    - name: a2enmod mpm_event
    - unless: ls /etc/apache2/mods-enabled/mpm_event.load
    - watch_in:
      - service: apache2-restart
    - require:
      - cmd: disable-mpm_prefork
