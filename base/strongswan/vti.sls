{% if salt['pillar.get']('strongswan:use_vti') %}
vti-updown:
  file.managed:
    - name: /usr/local/bin/vti-updown.sh
    - source: salt://strongswan/files/vti-updown.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: strongswan
{% else %}
vti-updown:
  file.absent:
    - name: /usr/local/bin/vti-updown.sh
vti_conf:
  file.absent:
    - name: /etc/strongswan.d/vti.conf
{% endif %}
