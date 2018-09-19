apache2:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - reload: True
    - enable: True
    - require:
      - pkg: apache2

apache2-restart:
  service.running:
    - name: apache2
    - require:
      - pkg: apache2
