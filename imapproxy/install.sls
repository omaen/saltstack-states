{% from 'imapproxy/map.jinja' import imapproxy with context %}

imapproxy:
  pkg.installed:
    - name: imapproxy
  service.running:
    - name: imapproxy
    - require:
      - pkg: imapproxy
