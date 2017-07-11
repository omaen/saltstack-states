{% set environment = salt['pillar.get']('proxy:environment', {}) %}
{% set apt = salt['pillar.get']('proxy:apt', {}) %}

{% for key, value in environment.iteritems() %}
environment_{{ key }}:
  file.replace:
    - name: /etc/environment
    - pattern: ^{{ key }}=.*$
    - repl: '{{ key }}="{{ value }}"'
    - append_if_not_found: True
    - backup: False
{% endfor %}

{% if environment %}
systemd_proxy:
  file.managed:
    - name: /etc/systemd/system.conf.d/proxy.conf
    - source: salt://proxy/files/proxy.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        config: {{ environment }}
{% endif %}

{% if apt %}
apt_proxy:
  file.managed:
    - name: /etc/apt/apt.conf.d/30proxy
    - source: salt://proxy/files/30proxy
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        config: {{ apt }}
{% endif %}
