install-apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-enabled/*
      - file: /etc/apache2/mods-enabled/*

enable-ssl:
  apache_module.enable:
    - name: ssl

enable-default-ssl-site:
  file.symlink:
    - name: /etc/apache2/sites-enabled/default-ssl.conf
    - target: ../sites-available/default-ssl.conf
