{% from 'fwgen/map.jinja' import fwgen with context %}
fwgen:
  pkg.installed:
    - pkgs:
      - ipset
      - conntrack
      - python-pip  # Only included to stop pip salt module from complaining
      - python3-pip
      - python3-yaml
  pip.installed:
  {% if fwgen.version %}
    - name: fwgen{{ fwgen.version }}
  {% else %}
    - name: fwgen
    - upgrade: True
  {% endif %}
    - bin_env: /usr/bin/pip3
    - require:
      - pkg: fwgen
