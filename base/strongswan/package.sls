{% from 'strongswan/map.jinja' import strongswan with context %}

strongswan:
  pkg.installed:
    - names: 
      - {{ strongswan.strongswan }}
