# Depends on mysql-user, mysql-grant, mysql-database, and mysql begin run prior
# within the deployment.

{% set wordpress_domain = salt['pillar.get']('wordpress:domain', 'example.com') %}
{% set wordpress_user = salt['pillar.get']('wordpress:user', 'wp_user') %}
{% set wordpress_pass = salt['pillar.get']('wordpress:pass', '1w0rdpr3ss') %}
{% set wordpress_email = salt['pillar.get']('wordpress:email', 'root@example.com') %}

{% set wordpress_db_host = salt['pillar.get']('wordpress:db_host', 'localhost') %}
{% set wordpress_db_name = salt['pillar.get']('wordpress:db_name', 'wordpress') %}
{% set wordpress_db_user = salt['pillar.get']('wordpress:db_user', 'wp_user') %}
{% set wordpress_db_pass = salt['pillar.get']('wordpress:db_pass', 'wp_dbPass') %}

install-wordpress-dependencies:
  pkg.installed:
    - pkgs:
      - curl
      - php5-cli
      - php5
      - php5-mysql
      - php5-xmlrpc
      - php5-gd
      - php5-json
      - php5-apcu

wp-cli-install:
  cmd.run:
    - name: |
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
        mv wp-cli.phar /usr/local/bin/wp
    - creates: /usr/local/bin/wp

wp-cli-wordpress-install:
  cmd.run:
    - name: |
        mkdir -p /var/www/{{wordpress_domain}}
        cd /var/www/{{wordpress_domain}}
        wp core download --allow-root
        chown -R www-data:www-data /var/www/{{wordpress_domain}}
    - creates: /var/www/{{wordpress_domain}}/index.php

wp-cli-wordpress-configure:
  cmd.run:
    - name: |
        wp core config --allow-root \
          --dbname={{wordpress_db_name}} \
          --dbuser={{wordpress_db_user}} \
          --dbpass={{wordpress_db_pass}} \
          --dbname={{wordpress_db_name}}
        chown -R www-data:www-data * .*
        wp user create --allow-root {{wordpress_user}} {{wordpress_email}} --user_pass="{{wordpress_pass}}"
    - creates: /var/www/{{wordpress_domain}}/wp-config.php

write-wordpress-varnish-template:
  file.managed:
    - name: /etc/varnish/default.vcl
    - source: salt://wordpress/default.vcl.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
