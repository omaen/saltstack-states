mod-proxy_balancer:
  cmd.run:
    - name: a2enmod proxy_balancer
    - unless: ls /etc/apache2/mods-enabled/proxy_balancer.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
