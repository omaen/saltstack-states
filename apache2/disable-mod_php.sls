{% from 'apache2/map.jinja' import apache2 with context %}

disable-mod_php:
  pkg.purged:
    - name: {{ apache2.libapache2_mod_php }}
