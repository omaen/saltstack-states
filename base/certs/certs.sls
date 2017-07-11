{% set count = 1 %}
{% for name in salt['pillar.get']('certs', {}) %}
host_cert_{{ count }}:
  file.managed:
    - name: /usr/local/etc/ssl/certs/{{ name }}.crt
    - contents_pillar: certs:{{ name }}:crt
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

host_cert_key_{{ count }}:
  file.managed:
    - name: /usr/local/etc/ssl/private/{{ name }}.key
    - contents_pillar: certs:{{ name }}:key
    - user: root
    - group: root
    - mode: 640
    - makedirs: True
{% set count = count + 1 %}
{% endfor %}
