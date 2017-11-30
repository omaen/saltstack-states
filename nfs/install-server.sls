{% from 'nfs/map.jinja' import nfs with context %}

nfs-server:
  pkg.installed:
    - name: {{ nfs.server.package }}
