certs_dir:
  file.directory:
    - name: /usr/local/etc/ssl/certs
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

cert_keys_dir:
  file.directory:
    - name: /usr/local/etc/ssl/private
    - user: root
    - group: ssl-cert
    - mode: 750
    - require:
      - file: certs_dir
      - pkg: ssl-cert


{% for name in salt['pillar.get']('certs', {}) %}

cert_{{ name }}:
  file.managed:
    - name: /usr/local/etc/ssl/certs/{{ name }}.crt
    - contents_pillar: certs:{{ name }}:crt
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: certs_dir

cert_key_{{ name }}:
  file.managed:
    - name: /usr/local/etc/ssl/private/{{ name }}.key
    - contents_pillar: certs:{{ name }}:key
    - user: root
    - group: ssl-cert
    - mode: 640
    - require:
      - file: cert_keys_dir

{% endfor %}
