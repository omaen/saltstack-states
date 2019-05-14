{%- from tpldir ~ "/map.jinja" import exabgp with context %}

exabgp-pkg:
  pkg.installed:
    - name: {{ exabgp.pkg }}

exabgp-python-ipaddr:
  pkg.installed:
    - name: python-ipaddr
