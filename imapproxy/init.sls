include:
  - certs

imapproxy_conf:
  file.managed:
    - name: /etc/imapproxy.conf
    - source: salt://imapproxy/files/imapproxy.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - service: imapproxy

imapproxy:
  pkg.installed:
    - name: imapproxy
    - require:
      - file: imapproxy_conf
  service.running:
    - name: imapproxy
    - require:
      - pkg: imapproxy
