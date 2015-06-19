install_varnish_dependencies:
  pkg.installed:
    - name: apt-transport-https

varnish_repo_curl:
  pkg.installed:
    - name: curl

varnish_repo:
  cmd.run:
    - name: curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
    - unless: /usr/bin/apt-key adv --list-key C4DEFFEB
    - require:
      - pkg: varnish_repo_curl
  pkgrepo.managed:
    - name: deb https://repo.varnish-cache.org/ubuntu/ precise varnish-4.0
    - file: /etc/apt/sources.list.d/varnish-cache.list
    - require:
      - cmd: varnish_repo
    - require_in:
      - pkg: varnish

install_varnish:
  pkg.installed:
    - name: varnish
  service.running:
    - name: varnish
    - watch:
      - file: /etc/varnish/default.vcl
