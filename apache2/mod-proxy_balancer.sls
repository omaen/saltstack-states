mod-proxy_balancer:
  cmd.run:
    - name: a2enmod proxy_balancer
    - unless: apache2ctl -M | grep ' proxy_balancer_module '
    - watch_in:
      - service: apache2
