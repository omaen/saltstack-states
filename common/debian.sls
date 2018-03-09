include:
  - network
{%- if grains['oscodename'] == 'jessie' %}
  - resolvconf
  - rdnssd
{%- else %}
  - resolvconf.remove
  - rdnssd.remove
  - systemd-resolved
{%- endif %}
  - profile
  - salt.cron_salt-call
  - users
  - rsyslog
  - virtualization.guest-tools
  - timesyncd
  - ifenslave
  - apt
  - less
  - vim
  - bash-completion
  - sudo
  - man-db
  - ssh
  - unattended-upgrades
  - motd
  - rsync
  - sysctl
  - certs
  - autofs
  - fstrim
  - kernel
  - iptables
  - fwgen
  - udev
  - pip
  - logrotate
  - microcode
