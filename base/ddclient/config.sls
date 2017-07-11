ddclient_conf:
  file.managed:
    - name: /etc/ddclient.conf
    - source: salt://ddclient/files/ddclient.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: ddclient
    - watch_in:
      - service: ddclient
