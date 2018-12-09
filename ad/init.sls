include:
{% if pillar.get('samba', {}) %}
  - .net-ads-join
{% else %}
  - .adcli-join
{% endif %}
