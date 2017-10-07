{%- if salt['pillar.get']('rsync:modules') %}
rsyncd_conf:
  file.managed:
    - name: /etc/rsyncd.conf
    - source: salt://rsync/files/rsyncd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: rsync

extend:
  rsync:
    service.running:
      - name: rsync
      - require:
        - pkg: rsync
        - file: rsyncd_conf
{%- else %}
rsyncd_conf:
  file.absent:
    - name: /etc/rsyncd.conf

extend:
  rsync:
    service.dead:
      - name: rsync
      - require:
        - pkg: rsync
        - file: rsyncd_conf
{%- endif %}
