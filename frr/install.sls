{% from 'frr/map.jinja' import frr with context %}

frr-repo:
  pkgrepo.managed:
    - name: {{ frr.repo }}
    - key_url: {{ frr.repo_key_url }}
    - file: /etc/apt/sources.list.d/frr.list
    - clean_file: True

frr:
  pkg.installed:
    - pkgs:
      - frr
      - frr-pythontools
  service.running:
    - name: {{ frr.service }}
    # Reload requires frr-pythontools
    - reload: True
    - enable: True
    - watch:
      - pkg: frr
