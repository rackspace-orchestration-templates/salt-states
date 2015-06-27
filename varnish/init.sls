install_varnish_dependencies:
  pkg.installed:
    - name: apt-transport-https

varnish_repo_curl:
  pkg.installed:
    - name: curl

varnish_repo:
  pkgrepo.managed:
    - name: deb https://repo.varnish-cache.org/ubuntu/ precise varnish-4.0
    - file: /etc/apt/sources.list.d/varnish-cache.list
    - key_url: https://repo.varnish-cache.org/GPG-key.txt
    - keyserver: keyserver.ubuntu.com
    - keyid: C4DEFFEB
    - require:
      - pkg: varnish_repo_curl
    - require_in:
      - pkg: varnish

install_varnish:
  pkg.installed:
    - name: varnish
  service.running:
    - name: varnish
    - watch:
      - file: /etc/varnish/default.vcl

write-varnish-default:
  file.managed:
    - name: /etc/default/varnish
    - source: salt://varnish/varnish.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
