{% from 'php/map.jinja' import php with context %}

{% for module, module_config in php.config.modules.items() %}

php-{{ module }}:
  pkg.installed:
    - name: {{ php.modules[module].package }}

{% endfor %}
