{%- if pillar.ulogd is defined %}
include:
{%- if pillar.ulogd.server is defined %}
- ulogd.server
{%- endif %}
{%- endif %}
