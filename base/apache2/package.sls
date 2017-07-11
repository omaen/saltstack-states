apache2:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - require:
      - pkg: apache2

apache2-reload:
  service.running:
    - name: apache2
    - reload: True
    - only_if:
      - service: apache2
