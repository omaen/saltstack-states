{% from 'squid/map.jinja' import squid with context %}

include:
  - .install

squid_conf:
  file.managed:
    - name: {{ squid.squid_conf }}
    - source: salt://squid/files/squid.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - context:
        # Filter via json to keep dictionary ordering from pillar.
        # This is not essential, but it is more user friendly.
        config: {{ squid.config|json }}
    - watch_in:
      - service: squid

{% if squid.keytab.content_base64 is defined %}

squid_keytab:
  file.managed:
    - name: {{ squid.keytab.name }}
    - contents:
    - user: proxy
    - group: proxy
    - mode: 600
    - replace: False
    - watch_in:
      - service: squid

squid_keytab_base64:
  file.decode:
    - name: {{ squid.keytab.name }}
    - contents_pillar: squid:keytab:content_base64
    - encoding_type: base64
    - require:
      - file: squid_keytab
    - watch_in:
      - service: squid

{% endif %}

squid_cert_dir:
  file.directory:
    - name: {{ squid.cert_dir }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - pkg: squid

{% for k in squid.certificates %}

squid_public_cert_{{ k }}:
  file.managed:
    - name: {{ squid.cert_dir}}/{{ k }}.crt
    - contents_pillar: squid:certificates:{{ k }}:public_cert
    - follow_symlinks: False
    - user: proxy
    - group: proxy
    - mode: 644
    - watch_in:
      - service: squid
    - require:
      - file: squid_cert_dir

squid_private_key_{{ k }}:
  file.managed:
    - name: {{ squid.cert_dir }}/{{ k }}.key
    - contents_pillar: squid:certificates:{{ k }}:private_key
    - follow_symlinks: False
    - user: proxy
    - group: proxy
    - mode: 600
    - watch_in:
      - service: squid
    - require:
      - file: squid_cert_dir

{% endfor %}
