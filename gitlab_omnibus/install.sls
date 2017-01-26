# vim: ft=sls
# How to install gitlab_omnibus
{% from "gitlab_omnibus/map.jinja" import gitlab_omnibus with context %}
{% if grains['os_family'] in ['Debian'] %}
run_script_install:
{% if gitlab_omnibus.enterprise_edition == 'true' %}
  cmd.run:
    - name: curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
    - unless: test -f /etc/apt/sources.list.d/gitlab_gitlab-ee.list
{% else %}
  cmd.run:
    - name: curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
    - unless: test -f /etc/apt/sources.list.d/gitlab_gitlab-ce.list
{% endif %}
gitlab_extra_package_install:
 pkg.latest:
    - pkgs: {{ gitlab_omnibus.extra_pkgs|json }}

gitlab_install:
  cmd.run:
{% if gitlab_omnibus.enterprise_edition == 'true' %}
    - name: sudo apt-get  update && sudo apt-get install gitlab-ee={{ gitlab_omnibus.version }}
{% else %}
    - name: sudo apt-get update && sudo apt-get install gitlab-ce={{ gitlab_omnibus.version }}
{% endif %}
    - unless: dpkg -l | grep -o {{ gitlab_omnibus.version }}
    - requires:
       - pkg: gitlab_extra_package_install


gitlab_reconfigure:
  cmd.wait:
    - name: 'sudo gitlab-ctl reconfigure'
    - require:
       - cmd: gitlab_install
{% endif %}
