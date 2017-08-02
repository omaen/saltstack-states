{% from 'fwgen/map.jinja' import fwgen with context %}
fwgen:
  pkg.installed:
    - pkgs:
      - ipset
      - python-pip  # Only included to stop pip salt module from complaining
      - python3-pip
      - python3-yaml
  pip.installed:
    {% if fwgen.version %}
    - name: fwgen{{ fwgen.version }}
    {% else %}
    - name: fwgen
    {% endif %}
    - bin_env: /usr/bin/pip3
    - require:
      - pkg: fwgen

restore-fw:
  cmd.script:
    - source: salt://fwgen/files/post-install.sh
    - unless: readlink -f /etc/network/if-pre-up.d/restore-fw | grep '/fwgen/sbin/restore-fw'
    - require:
      - pip: fwgen
