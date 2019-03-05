motd:
{% if grains['oscodename'] == 'buster' %}
  file.managed:
    - name: /etc/motd
    - source: salt://motd/files/motd
    - user: root
    - group: root
    - mode: 644

20-motd:
  file.absent:
    - name: /etc/update-motd.d/20-motd

30-systeminfo:
  file.absent:
    - name: /etc/update-motd.d/30-systeminfo
{% else %}
  {% if grains['oscodename'] == 'jessie' %}
  file.symlink:
    - name: /etc/motd
    - target: /var/run/motd
    - force: True
  {% else %}
  file.rename:
    - name: /etc/motd.bak
    - source: /etc/motd
  {% endif %}

10-uname:
  file.managed:
    - name: /etc/update-motd.d/10-uname
    - source: salt://motd/files/10-uname
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

20-motd:
  file.managed:
    - name: /etc/update-motd.d/20-motd
    - source: salt://motd/files/20-motd
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

30-systeminfo:
  file.managed:
    - name: /etc/update-motd.d/30-systeminfo
    - source: salt://motd/files/30-systeminfo
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - pkg: motd_requirements
{% endif %}
