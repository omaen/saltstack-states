{%- if pillar['dhparams'] is defined %}

include:
  - certs

dhparams:
  file.managed:
    - name: /etc/ssl/private/dhparams.pem
    - contents_pillar: dhparams
    - user: root
    - group: ssl-cert
    - mode: 640
    - require:
      - pkg: ssl-cert

{%- endif %}
