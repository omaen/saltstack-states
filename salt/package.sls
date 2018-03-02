{% from 'salt/map.jinja' import salt_config with context %}

{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

salt-minion:
  pkg.installed:
    - pkgs:
      - salt-minion
# Extra requirement for proxy usage
{% if 'proxy_host' in salt_config.config.minion %}
      - python-pycurl
{% endif %}
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: salt-minion
    - watch:
      - pkg: salt-minion
