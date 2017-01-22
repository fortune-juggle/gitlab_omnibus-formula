# vim: ft=sls
# Manage service for service gitlab_omnibus
{%- from "gitlab_omnibus/map.jinja" import gitlab_omnibus with context %}

#'gitlab_omnibus-service not configured, gitlab makes this by itself':
#  test.succeed_without_changes
#adds systemd file

gitlab_omnibus_service:
  service.running:
    - name: gitlab-runsvdir
    - enable: True