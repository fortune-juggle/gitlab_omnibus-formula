# vim: ft=sls
# Init gitlab_omnibus
{%- from "gitlab_omnibus/map.jinja" import gitlab_omnibus with context %}
{% if salt['pillar.get']('gitlab_omnibus', False) %}
include:
  - gitlab_omnibus.install
{% endif %}


