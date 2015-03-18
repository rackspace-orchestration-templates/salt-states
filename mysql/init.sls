{% set mysql_root_password = salt['pillar.get']('mysql:root_password', '') %}
install-debconf-utils:
  pkg.installed:
    - name: debconf-utils

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
