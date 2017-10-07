gnome-core:
  pkg.installed:
    - name: gnome-core

include:
  - gnome.fonts
{% if grains['virtual'] == 'VMware' %}
  - vmware.vmware-tools-desktop
{% endif %}
