composer-dependencies:
  pkg.installed:
    - pkgs:
      - php5-cli

composer-global-install:
  cmd.run:
    - name: |
        curl -sS https://getcomposer.org/installer | php
        mv /root/composer.phar /usr/local/bin/composer
    - creates: /usr/local/bin/composer
