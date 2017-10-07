ca-certificates:
  pkg.installed:
    - name: ca-certificates

update-ca-certificates:
  cmd.wait:
    - name: /usr/sbin/update-ca-certificates -f
    - require:
      - pkg: ca-certificates

{% for name in salt['pillar.get']('ca_certs', {}) %}
ca_cert_{{ name }}:
  file.managed:
    - name: /usr/local/share/ca-certificates/{{ name }}.crt
    - contents_pillar: ca_certs:{{ name }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: update-ca-certificates
{% endfor %}
