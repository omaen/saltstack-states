{% from 'apache2/map.jinja' import apache2 with context %}

{% if apache2.disable_default_site %}
include:
  - .disable-default-site
{% endif %}

# State name can't have dots in them, so numbers is used
# to create unique state names
{% for site in apache2.sites %}
apache2_site_{{ site }}:
  file.managed:
    - name: /etc/apache2/sites-available/{{ site }}.conf
    - contents_pillar: apache2:sites:{{ site }}:config
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
  cmd.run:
    - name: a2ensite {{ site }}
    - unless: ls /etc/apache2/sites-enabled/{{ site }}.conf
    - require:
      - file: apache2_site_{{ site }}
    - watch_in:
      - service: apache2
{% endfor %}
