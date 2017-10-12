{% from 'dovecot/map.jinja' import dovecot with context %}

dovecot:
  pkg.installed:
    - pkgs:
      {% if dovecot.imap %}
      - {{ dovecot.imap.package }}
      {% endif %}
      {% if dovecot.managesieve.enable %}
      - {{ dovecot.managesieve.package }}
      {% endif %}
  service.running:
    - name: {{ dovecot.service }}
