chrome_domain_policy:
  file.managed:
    - name: /etc/opt/chrome/policies/managed/domain_policy.json
    - source: salt://chrome/files/domain_policy.json
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

chromium_domain_policy:
  file.symlink:
    - name: /etc/chromium
    - target: /etc/opt/chrome
    - require:
      - file: chrome_domain_policy
