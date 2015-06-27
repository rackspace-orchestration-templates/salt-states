install-lsyncd:
  pkg.installed:
    - name: lsyncd
  service.running:
    - name: lsyncd
    - watch:
      - file: /etc/lsyncd/lsyncd.conf.lua
