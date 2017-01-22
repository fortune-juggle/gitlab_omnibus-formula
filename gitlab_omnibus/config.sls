# vim: ft=sls
# How to configure gitlab_omnibus
{%- from "gitlab_omnibus/map.jinja" import gitlab_omnibus with context %}

/lib/systemd/system/gitlab-runsvdir.service:
  file.managed:
    - source: salt://gitlab_omnibus/files/gitlab-runsvdir.service
    - user: root
    - group: root
    - mode: 0600
    - template: jinja

/etc/systemd/system/default.target.wants/gitlab-runsvdir.service:
  file.symlink:
    - target: /lib/systemd/system/gitlab-runsvdir.service

systemctl_daemon_gitlab_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - unless: ls /etc/systemd/system/default.target.wants/gitlab-runsvdir.service