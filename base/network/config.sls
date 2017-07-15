{% if grains['os'] == 'Debian' %}

interfaces:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://network/files/interfaces
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ pillar['network'] }}

{% endif %}
