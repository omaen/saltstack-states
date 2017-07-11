include:
  - salt

{% if salt['pillar.get']('saltstack:salt-call_cronjob', True) %}
cron_salt-call:
  file.managed:
    - name: /etc/cron.daily/salt-call
    - source: salt://salt/files/salt-call
    - user: root
    - group: root
    - mode: 755
  require:
    - pkg: salt-minion
{% else %}
remove_cron_salt-call:
  file.missing:
    - name: /etc/cron.daily/salt-call
{% endif %}
