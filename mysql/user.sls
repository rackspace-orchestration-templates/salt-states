{% set mysql_user = salt['pillar.get']('mysql-user:user', 'user') %}
{% set mysql_pass = salt['pillar.get']('mysql-user:pass', 'mysql_password') %}
{% set mysql_host = salt['pillar.get']('mysql-user:host', 'localhost') %}

install-mysql-user-dependencies:
  pkg.installed:
    - pkgs:
      - python-mysqldb

mysql-user-creation:
  mysql_user.present:
    - host: {{ mysql_host }}
    - name: {{ mysql_user }}
    - password: "{{ mysql_pass }}"
