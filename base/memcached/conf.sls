include:
  - memcached

memcached_conf:
  file.managed:
    - name: /etc/memcached.conf
    - source: salt://memcached/files/memcached.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: memcached
    - watch_in:
      - service: memcached
