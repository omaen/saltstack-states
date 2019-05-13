# pycurl is needed for pkgrepo states when http_proxy is used in minion config
{% set pyver = grains['pythonversion'][0] %}
pycurl:
  pkg.installed:
    {% if pyver == 3 %}
    - name: python3-pycurl
    {% else %}
    - name: python-pycurl
    {% endif %}
