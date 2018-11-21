{% from 'vlmcsd/map.jinja' import vlmcsd with context %}

include:
  - systemctl.daemon-reload

vlmcsd:
  archive.extracted:
    - name: /opt/vlmcsd
    - source: {{ vlmcsd.archive_url }}
    - source_hash: md5=0b0420b1376a71003d043dd951893bcf
    - user: root
    - group: root
    {% if vlmcsd.upgrade %}
    - overwrite: True
    - clean: True
    {% else %}
    - if_missing: /opt/vlmcsd/binaries
    {% endif %}
  file.symlink:
    - name: /usr/local/bin/vlmcsd
    - target: /opt/vlmcsd/binaries/Linux/intel/static/vlmcsd-x64-musl-static
    - force: True
    - require:
      - archive: vlmcsd

vlmcsd.service:
  file.managed:
    - name: /etc/systemd/system/vlmcsd.service
    - source: salt://vlmcsd/files/vlmcsd.service
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: vlmcsd
    - watch_in:
      - cmd: daemon-reload
  service.running:
    - name: vlmcsd
    - enable: True
    - require:
      - file: vlmcsd.service
