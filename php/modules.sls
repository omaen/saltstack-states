{% from 'php/map.jinja' import php with context %}

{% for module in php.config.modules %}

php-{{ module }}:
  pkg.installed:
    - name: {{ php.modules[module].pkg }}

{% endfor %}
