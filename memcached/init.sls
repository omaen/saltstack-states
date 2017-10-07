memcached:
  pkg.installed:
    - name: memcached
  service.running:
    - name: memcached
    - require:
      - pkg: memcached
