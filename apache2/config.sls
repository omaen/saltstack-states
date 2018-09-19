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

apache2_ssl_dir:
  file.directory:
    - name: /etc/apache2/ssl
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: apache2

{% for k in apache2.certificates %}

apache2_public_cert_{{ k }}:
  file.managed:
    - name: /etc/apache2/ssl/{{ k }}.crt
    - contents_pillar: apache2:certificates:{{ k }}:public_cert
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2
    - require:
      - file: apache2_ssl_dir

apache2_private_key_{{ k }}:
  file.managed:
    - name: /etc/apache2/ssl/{{ k }}.key
    - contents_pillar: apache2:certificates:{{ k }}:private_key
    - user: root
    - group: root
    - mode: 600
    - watch_in:
      - service: apache2
    - require:
      - file: apache2_ssl_dir

{% endfor %}
