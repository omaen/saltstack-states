command-not-found:
  pkg.installed:
    - name: command-not-found

apt-file-update:
  cmd.run:
    - name: apt-file update
    - onchanges:
      - pkg: command-not-found

update-command-not-found:
  cmd.run:
    - name: update-command-not-found
    - onchanges:
      - pkg: command-not-found
