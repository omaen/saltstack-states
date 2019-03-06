{%- from tpldir ~ "/map.jinja" import test_html with context %}

test.html:
  file.managed:
    - name: {{ test_html.path }}
    - source: salt://test-html/files/test.html
    - user: root
    - group: root
    - mode: 644
