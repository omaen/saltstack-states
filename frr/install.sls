{% from 'frr/map.jinja' import frr with context %}

frr:
  pkg.installed:
    - sources:
      - frr: {{ frr.package_urls.frr }}
      - frr-pythontools: {{ frr.package_urls['frr-pythontools'] }}
  service.running:
    - name: {{ frr.service }}
    # Reload requires frr-pythontools
    - reload: True
    - enable: True
    - watch:
      - pkg: frr
