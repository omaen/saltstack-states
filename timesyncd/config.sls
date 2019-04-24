{% from 'timesyncd/map.jinja' import timesyncd with context %}

{% if timesyncd.enable %}

timesyncd_conf:
  file.managed:
    - name: {{ timesyncd.timesyncd_conf }}
    - source: salt://timesyncd/files/timesyncd.conf
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ timesyncd.config|tojson }}
  service.running:
    - name: {{ timesyncd.service }}
    - watch:
      - file: timesyncd_conf
  cmd.run:
    - name: timedatectl set-ntp true
    - onlyif: "timedatectl status | grep 'NTP enabled: no'"

{% endif %}
