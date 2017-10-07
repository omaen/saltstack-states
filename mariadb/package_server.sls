mariadb-server:
  pkg.installed:
    - name: mariadb-server
  service.running:
    - name: mariadb
    - require:
      - pkg: mariadb-server
