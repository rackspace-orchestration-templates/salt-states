owncloud-repo:
  pkgrepo.managed:
    - name: deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /
    - key_url: http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key
    - require_in:
      - pkg: owncloud

install-owncloud:
  pkg.installed:
    - name: owncloud
    - refresh: True

write-autoconfig:
  file.managed:
    - name: /var/www/owncloud/config/autoconfig.php
    - source: salt://owncloud/autoconfig.php.jinja
    - user: www-data
    - group: www-data
    - mode: 644
    - template: jinja
