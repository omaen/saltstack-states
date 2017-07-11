include:
  - certs

dhparams-2048:
  file.managed:
    - name: /etc/ssl/private/dhparams.pem
    - source: salt://dhparams/files/dhparams-2048.pem
    - user: root
    - group: ssl-cert
    - mode: 640
    - require: 
      - pkg: ssl-cert
