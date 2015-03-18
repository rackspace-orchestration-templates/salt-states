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
