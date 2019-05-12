{%- from tpldir ~ "/map.jinja" import google_authenticator with context %}

google-authenticator:
  pkg.installed:
    - name: {{ google_authenticator.package }}
  file.managed:
    - name: /usr/share/pam-configs/google-authenticator
    - source: salt://google-authenticator/files/pam-config
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: google-authenticator
  cmd.wait:
    - name: /usr/sbin/pam-auth-update --package
    - watch:
      - file: google-authenticator

# Note that kerberos SSO bypasses 2FA regardless of these exceptions
google-authenticator-exceptions:
  file.managed:
    - name: {{ google_authenticator.exceptions_file }}
    - source: salt://google-authenticator/files/google-authenticator-2fa.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ google_authenticator.exceptions }}
    - require_in:
      - file: google-authenticator
