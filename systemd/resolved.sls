{%- if grains['oscodename'] != 'jessie' %}
systemd_resolved:
  pkg.installed:
    - name: libnss-resolve
  service.running:
    - name: systemd-resolved
    - enable: True
    - require:
      - pkg: systemd_resolved
{%- endif %}
