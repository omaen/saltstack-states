{% set environment = salt['pillar.get']('proxy:environment', {}) %}
{% set apt = salt['pillar.get']('proxy:apt', {}) %}

{% for key in ['http_proxy', 'https_proxy', 'no_proxy'] %}
environment_{{ key }}:
  # file.line mode=delete is unusable without content defined
  # so use this ugly workaround
  cmd.run:
    - name: sed -i '/^{{ key }}=.*$/d' /etc/environment
    - onlyif: grep -E '^{{ key }}=.*$' /etc/environment
{% endfor %}

{% if environment %}
systemd_proxy:
  file.absent:
    - name: /etc/systemd/system.conf.d/proxy.conf
{% endif %}

{% if apt %}
apt_proxy:
  file.absent:
    - name: /etc/apt/apt.conf.d/30proxy
{% endif %}
