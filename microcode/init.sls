{% if grains['virtual'] | lower == 'physical' %}

include:
  - apt.repo-backports

intel_microcode:
  pkg.installed:
    - name: intel-microcode
    - onlyif:
      - lscpu | grep -E "^Vendor ID:\s+GenuineIntel$"
    - fromrepo: {{ grains['oscodename'] }}-backports
    - require:
      - pkgrepo: repo-backports

amd_microcode:
  pkg.installed:
    - name: amd64-microcode
    - onlyif:
      - lscpu | grep -E "^Vendor ID:\s+AuthenticAMD$"
    - fromrepo: {{ grains['oscodename'] }}-backports
    - require:
      - pkgrepo: repo-backports

{% endif %}
