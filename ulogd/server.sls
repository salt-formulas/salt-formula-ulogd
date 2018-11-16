{%- from "ulogd/map.jinja" import server with context %}
{%- if server.enabled %}

ulogd_packages:
  pkg.installed:
    - name: ulogd2

{%- if server.sections is defined %}
/etc/ulogd.conf:
  file.managed:
    - name: /etc/ulogd.conf
    - template: jinja
    - source: salt://ulogd/files/ulogd.conf
    - require:
      - pkg: ulogd_packages
{%- endif %}

ulogd_service:
  service.running:
    - enable: true
    - name: ulogd2
    - watch:
      - file: /etc/ulogd.conf

{%- endif %}
