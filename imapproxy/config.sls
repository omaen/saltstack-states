{% from 'imapproxy/map.jinja' import imapproxy with context %}

imapproxy_conf:
  file.managed:
    - name: {{ imapproxy.imapproxy_conf }}
    - source: salt://imapproxy/files/imapproxy.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - context:
        config: {{ imapproxy.config }}
    - watch_in:
      - service: imapproxy
