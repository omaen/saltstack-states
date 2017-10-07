host_cert_certs_dir:
  file.directory:
    - name: /usr/local/etc/ssl/certs
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

host_cert_private_dir:
  file.directory:
    - name: /usr/local/etc/ssl/private
    - user: root
    - group: ssl-cert
    - mode: 750
    - require:
      - file: host_cert_certs_dir
      - pkg: ssl-cert

{% set count = 1 %}
{% for name in salt['pillar.get']('certs', {}) %}
host_cert_{{ count }}:
  file.managed:
    - name: /usr/local/etc/ssl/certs/{{ name }}.crt
    - contents_pillar: certs:{{ name }}:crt
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: host_cert_certs_dir

host_cert_key_{{ count }}:
  file.managed:
    - name: /usr/local/etc/ssl/private/{{ name }}.key
    - contents_pillar: certs:{{ name }}:key
    - user: root
    - group: ssl-cert
    - mode: 640
    - require:
      - file: host_cert_private_dir
{% set count = count + 1 %}
{% endfor %}
