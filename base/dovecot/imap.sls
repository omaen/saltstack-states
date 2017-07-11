dovecot-imap:
  pkg.installed:
    - name: dovecot-imapd
  service.running:
    - name: dovecot
