{% from 'icinga2/map.jinja' import icinga2 with context %}

{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

icinga2:
  pkg.installed:
    - name: {{ icinga2.package }}
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: {{ icinga2.service }}
    - require:
      - pkg: icinga2

check_systemd_service:
  file.absent:
    - name: {{ icinga2.nagios_plugin_dir }}/check_systemd_service
