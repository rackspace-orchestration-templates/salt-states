{% set mysql_root_password = salt['pillar.get']('mysql:root_password', '') %}
install-mysql-dependencies:
  pkg.installed:
    - pkgs:
      - debconf-utils
      - python-mysqldb

mysql_debconf:
  debconf.set:
    - name: mysql-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/root_password_again': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/start_on_boot': {'type': 'boolean', 'value': 'true'}

install-mysql-server:
  pkg.installed:
    - name: mysql-server
  service.running:
    - name: mysql

write-defaults-file:
  file.managed:
    - name: /root/.my.cnf
    - source: salt://mysql/my.cnf.jinja
    - user: root
    - group: root
    - mode: 600
    - template: jinja
