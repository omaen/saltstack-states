{% from 'strongswan/map.jinja' import strongswan with context %}

{% set count = 1 %}
{% for name, params in strongswan.certs.items() %}
ipsec_cert_{{ count }}:
  file.managed:
    - name: /etc/ipsec.d/certs/{{ name }}.pem
    - contents_pillar: strongswan:certs:{{ name }}:cert
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: strongswan

ipsec_key_{{ count }}:
  file.managed:
    - name: /etc/ipsec.d/private/{{ name }}.key
    - contents_pillar: strongswan:certs:{{ name }}:key
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: strongswan
    - require_in:
      - file: ipsec_secrets_inc
{% set count = count + 1 %}
{% endfor %}

{% set count = 1 %}
{% for name, params in strongswan.cacerts.items() %}
ipsec_cacert_{{ count }}:
  file.managed:
    - name: /etc/ipsec.d/cacerts/{{ name }}.pem
    - contents_pillar: strongswan:cacerts:{{ name }}:cert
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: strongswan
{% set count = count + 1 %}
{% endfor %}
