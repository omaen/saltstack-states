{% from 'ntp/map.jinja' import ntp with context %}

ntp_purged:
  pkg.purged:
    - name: {{ ntp.package }}
