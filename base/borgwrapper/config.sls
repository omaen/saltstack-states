{% from 'borgwrapper/map.jinja' import borgwrapper with context %}

{% for name, params in borgwrapper.configs.iteritems() %}
{% set config = borgwrapper.config_defaults %}
{% do config.update(params) %}
{% set config_file = [borgwrapper.config_dir, name + '.sh'] | join('/') %}

borgwrapper_{{ name }}_config:
  file.managed:
    - name: {{ config_file }}
    - source: salt://borgwrapper/files/config.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
    - context:
        config: {{ config }}

{% if config.cron_enable %}

borgwrapper_{{ name }}_cron_backup:
  cron.present:
    {% if config.nice %}
    - name: nice {{ borgwrapper.bin }} -c {{ config_file }} backup
    {% else %}
    - name: {{ borgwrapper.bin }} -c {{ config_file }} backup
    {% endif %}
    - identifier: borgwrapper backup ({{ name }})
    - user: root
    - hour: random
    - minute: random

borgwrapper_{{ name }}_cron_verify:
  cron.present:
    {% if config.nice %}
    - name: nice {{ borgwrapper.bin }} -c {{ config_file }} verify
    {% else %}
    - name: {{ borgwrapper.bin }} -c {{ config_file }} verify
    {% endif %}
    - identifier: borgwrapper verify ({{ name }})
    - user: root
    - hour: random
    - minute: random
    - daymonth: random

{% else %}

# It seems like you only have to satisfy a grep-like match on "name", i.e., you can match on
# part of the command in the crontab, as long as the "identifier" also matches the existing cron job.
# It does not seem to work with only one of name or identifier as long as both are in the crontab.
borgwrapper_{{ name }}_cron_backup_remove:
  cron.absent:
    - name: {{ borgwrapper.bin }} -c {{ config_file }} backup
    - identifier: borgwrapper backup ({{ name }})
    - user: root

borgwrapper_{{ name }}_cron_verify_remove:
  cron.absent:
    - name: {{ borgwrapper.bin }} -c {{ config_file }} verify
    - identifier: borgwrapper verify ({{ name }})
    - user: root

{% endif %}
{% endfor %}
