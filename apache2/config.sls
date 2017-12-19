{% from 'apache2/map.jinja' import apache2 with context %}

include:
  - .common_conf
  - .ssl_conf
  - .ports_conf
{% if apache2.remote_ip_internal_proxy %}
  - .mod-remoteip
{% endif %}
{% if apache2.php_fpm %}
  - php.fpm
  - .mod-mpm_event
  - .mod-proxy_fcgi
{% endif %}
  - .modules
  - .sites
