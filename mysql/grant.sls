{% set mysql_user = salt['pillar.get']('mysql-grant:user', 'user') %}
{% set mysql_db = salt['pillar.get']('mysql-grant:database', 'mysql_database') %}
{% set mysql_host = salt['pillar.get']('mysql-grant:host', 'localhost') %}
{% set mysql_grants = salt['pillar.get']('mysql-grant:grants', 'all privileges') %}

install-mysql-grant-dependencies:
  pkg.installed:
    - pkgs:
      - python-mysqldb

mysql-grant-creation:
  mysql_grants.present:
    - grant: {{ mysql_grants }}
    - database: {{ mysql_db }}
    - user: {{ mysql_user }}
    - host: {{ mysql_host }}
