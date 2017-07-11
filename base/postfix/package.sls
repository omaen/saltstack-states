{% from 'postfix/map.jinja' import postfix with context %}

postfix:
  pkg.installed:
    - pkgs:
      - {{ postfix.package }}
      - mailutils
  service.running:
    - name: {{ postfix.service }}
    - require:
      - pkg: postfix
