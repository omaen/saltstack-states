{% if grains['virtual'] == 'physical' %}

ifenslave:
  pkg.installed:
    - name: ifenslave

{% endif %}
