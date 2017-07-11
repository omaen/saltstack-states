include:
  - apache2.disable-mod_php

disable-mpm_prefork:
  cmd.run:
    - name: a2dismod mpm_prefork
    - onlyif: apache2ctl -M | grep ' mpm_prefork_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2

mod-mpm_event:
  cmd.run:
    - name: a2enmod mpm_event
    - unless: apache2ctl -M | grep ' mpm_event_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
      - cmd: disable-mpm_prefork
      - pkg: disable-mod_php
