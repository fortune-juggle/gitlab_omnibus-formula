# vim: ft=sls
# How to install gitlab_omnibus
{% from "gitlab_omnibus/map.jinja" import gitlab_omnibus with context %}
{% if grains['os_family'] in ['Debian'] %}
run_script_install:
  cmd.run:
    - name: curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
    - unless: test -f /etc/apt/sources.list.d/gitlab_gitlab-ee.list

gitlab_extra_package_install:
 pkg.latest:
    - pkgs: {{ gitlab_omnibus.extra_pkgs|json }}

gitlab_install:
  cmd.run:
    - name: sudo apt-get install gitlab-ce={{ gitlab_omnibus.version }}
    - unless: dpkg -l | grep -o {{ gitlab_omnibus.version }}
    - requires:
       - pkg: gitlab_extra_package_install

gitlab_reconfigure:
  cmd.wait:
    - name: 'sudo gitlab-ctl reconfigure'
    - require:
       - cmd: gitlab_install
{% endif %}