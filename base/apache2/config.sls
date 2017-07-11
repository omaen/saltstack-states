include:
  - .common_conf
  - .ssl_conf
  - .ports_conf
{% if salt['pillar.get']('apache2:remote_ip_internal_proxy', False) %}
  - .mod-remoteip
{% endif %}
{% if salt['pillar.get']('apache2:php-fpm', False) %}
  - php-fpm
  - .mod-mpm_event
  - .mod-proxy_fcgi
{% endif %}
  - .modules
  - .sites
