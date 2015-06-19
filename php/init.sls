install-php5:
  pkg.installed:
    - name: php5

enable-php5-module:
  apache_module.enable:
    - name: php5
