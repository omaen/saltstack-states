{% from 'gitlab/map.jinja' import gitlab with context %}

gitlab_reconfigure:
  cmd.wait:
    - name: gitlab-ctl reconfigure

{% for k in gitlab.certificates %}
gitlab_public_cert_{{ k }}:
  file.managed:
    - name: /etc/gitlab/ssl/{{ k }}.crt
    - contents_pillar: gitlab:certificates:{{ k }}:public_cert
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: gitlab_reconfigure

gitlab_private_key_{{ k }}:
  file.managed:
    - name: /etc/gitlab/ssl/{{ k }}.key
    - contents_pillar: gitlab:certificates:{{ k }}:private_key
    - user: root
    - group: root
    - mode: 600
    - watch_in:
      - cmd: gitlab_reconfigure
{% endfor %}
