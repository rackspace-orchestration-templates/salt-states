install-php5:
  pkg.installed:
    - pkgs:
      - php5
      - php5-mysql

enable-php5-module:
  apache_module.enable:
    - name: php5
