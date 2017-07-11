{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

java-8-jre:
  pkg.installed:
    - name: openjdk-8-jre-headless
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}

purge-java-7-jre:
  pkg.purged:
    - name: openjdk-7-jre-headless
    - require:
      - pkg: java-8-jre
