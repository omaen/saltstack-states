{%- from tpldir ~ "/map.jinja" import exabgp with context %}

include:
  - .install

{{ exabgp.exabgp_conf }}:
  {% if exabgp.config %}
  file.managed:
    - source: salt://exabgp/files/exabgp.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: exabgp-pkg
    - context:
        config: {{ exabgp.config|tojson }}
  {% else %}
  file.absent
  {% endif %}

exabgp-service:
  {% if exabgp.service_enable %}
  service.running:
    - name: {{ exabgp.service }}
    - enable: True
    - require:
      - pkg: exabgp-pkg
    - watch:
      - file: {{ exabgp.exabgp_conf }}
  {% else %}
  service.dead:
    - name: {{ exabgp.service }}
    - enable: False
  {% endif %}
