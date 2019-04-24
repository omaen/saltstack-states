{% from 'nfs/map.jinja' import nfs with context %}

exports.d:
  file.directory:
    - name: /etc/exports.d
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: nfs-server

nfs-exports:
  file.managed:
    - name: /etc/exports.d/salt.exports
    - source: salt://nfs/files/exports
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ nfs.server.exports|tojson }}
    - require:
      - file: exports.d
  cmd.wait:
    - name: exportfs -ra
    - watch:
      - file: nfs-exports
