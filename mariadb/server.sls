mariadb-server:
  pkg.installed:
    - name: mariadb-server
  service.running:
    - name: mariadb
    - require:
      - pkg: mariadb-server

# Requirement for Salt to be able to use mysql_* states
python-mysqldb:
  pkg.installed:
    - name: python-mysqldb
    - require:
      - pkg: mariadb-server
