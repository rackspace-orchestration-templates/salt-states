drush-dependencies:
  pkg.installed:
    - pkgs:
      - php5-mysql

# Requires composer
drush-install:
  cmd.run:
    - name: COMPOSER_HOME=/usr/share/drush composer global require drush/drush:7.*

/usr/local/bin/drush:
  file.symlink:
    - target: /usr/share/drush/drush/drush
