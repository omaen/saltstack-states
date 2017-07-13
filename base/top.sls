base:
  'roles:keepalived:prod':
    - match: pillar
    - keepalived

  'roles:standalone-host:prod':
    - match: pillar
    - common

  'roles:domain-member:prod':
    - match: pillar
    - common
    - ad.member

  'roles:mail-server:prod':
    - match: pillar
    - exim4.mail-server
    - mailx
    - aliases

  'roles:router:prod':
    - match: pillar
    - bird

  'roles:postfix-mta:prod':
    - match: pillar
    - postfix
    - mailx
    - aliases

  'roles:mariadb_server:prod':
    - match: pillar
    - mariadb.server
    - mariadb-backup

  'roles:docker:prod':
    - match: pillar
    - docker

  'roles:ssh-server:prod':
    - match: pillar
    - ssh.server
    - fail2ban

  'roles:proxmox_host:prod':
    - match: pillar
    - unattended-upgrades
    - motd
    - sysctl
    - timesyncd
    - fstrim

  'roles:ntp_server:prod':
    - match: pillar
    - ntp

  'roles:logstash:prod':
    - match: pillar
    - logstash
