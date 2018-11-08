include:
  - salt

# Use scheduled jobs instead
remove_cron_salt-call:
  file.absent:
    - name: /etc/cron.daily/salt-call
