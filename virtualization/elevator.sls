# The elevator switch is supposedly going away. Reverting changes
grub_elevator_noop:
  file.replace:
    - name: /etc/default/grub
    - pattern: GRUB_CMDLINE_LINUX_DEFAULT="quiet elevator=noop"
    - repl: GRUB_CMDLINE_LINUX_DEFAULT="quiet"
  cmd.wait:
    - name: update-grub
    - watch:
      - file: grub_elevator_noop
