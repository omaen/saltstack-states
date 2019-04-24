{% from 'strongswan/map.jinja' import strongswan with context %}

ipsec_conf:
  file.managed:
    - name: {{ strongswan.ipsec_conf }}
    - source: salt://strongswan/files/ipsec.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: strongswan
    - context:
        ipsec: {{ strongswan.ipsec|tojson }}

ipsec_secrets_inc:
  file.managed:
    - name: {{ strongswan.ipsec_secrets_inc }}
    - source: salt://strongswan/files/ipsec.secrets.inc
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: strongswan
    - context:
        secrets: {{ strongswan.secrets|tojson }}

local_conf:
  file.managed:
    - name: /etc/strongswan.d/local.conf
    - source: salt://strongswan/files/local.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: strongswan
    - context:
        config: {{ strongswan.config|tojson }}
