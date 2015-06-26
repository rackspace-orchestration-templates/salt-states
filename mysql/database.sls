{% set mysql_db = salt['pillar.get']('mysql-database:name', 'mysql_database') %}

install-mysql-database-dependencies:
  pkg.installed:
    - pkgs:
      - python-mysqldb

mysql-database-creation:
  mysql_database.present:
    - name: {{ mysql_db }}
