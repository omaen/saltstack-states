{%- for path, size in pillar.get('dhparams', {}).items() %}

dhparams:
  pkg.installed:
    - pkgs:
      - openssl
      - ssl-cert
  cmd.run:
    - name: openssl dhparam -out {{ path }} {{ size }}
    - unless: test -f {{ path }}
    - require:
      - pkg: dhparams
  file.managed:
    - name: {{ path }}
    - user: root
    - group: ssl-cert
    - mode: 640
    # replace needs to be False as vi do not manage any file content
    - replace: False
    - require:
      - cmd: dhparams

{%- endfor %}
