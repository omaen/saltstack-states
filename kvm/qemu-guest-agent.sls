qemu-guest-agent:
  pkg.installed:
    - name: qemu-guest-agent
{% if grains['oscodename'] == 'jessie' %}
  file.managed:
    - name: /etc/default/qemu-guest-agent
    - contents: |
        # Hack for /dev/virtio-ports/org.qemu.guest_agent.0 not being available
        # during boot race condition
        sleep 1
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: qemu-guest-agent
  service.running:
    - name: qemu-guest-agent
    - require:
      - pkg: qemu-guest-agent
{% endif %}
