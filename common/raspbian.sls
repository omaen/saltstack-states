include:
  - network
{%- if grains['oscodename'] == 'jessie' %}
  - resolvconf
  - rdnssd
{%- else %}
  - systemd-resolved
{%- endif %}
  - profile
  #- salt.cron_salt-call
  - users
  - rsyslog
  - timesyncd
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
  #- kernel
  - iptables
  - fwgen
  #- udev
  - pip
  - logrotate
