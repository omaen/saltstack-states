{% from 'postfix/map.jinja' import postfix with context %}

postfix:
  debconf.set:
    - name: {{ postfix.package }}
    - data:
        postfix/mailname:
          type: string
          value: {{ grains['fqdn'] }}
        postfix/main_mailer_type:
          type: string
          value: Satellite system
        postfix/relayhost:
          type: string
          value: {{ postfix.config.relayhost }}
  pkg.installed:
    - pkgs:
      - {{ postfix.package }}
      - mailutils
    - require:
      - debconf: postfix
  service.running:
    - name: {{ postfix.service }}
    - require:
      - pkg: postfix
