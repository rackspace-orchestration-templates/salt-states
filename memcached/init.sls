install-memcached:
  pkg.installed:
    - name: memcached
  service.running:
    - name: memcached
    - watch:
      - file: /etc/memcached.conf

write-memcached-config-file:
  file.managed:
    - name: /etc/memcached.conf
    - source: salt://memcached/memcached.conf.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
