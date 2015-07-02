holland-repo:
  pkgrepo.managed:
    - name: deb http://download.opensuse.org/repositories/home:/holland-backup/xUbuntu_14.04/ /
    - key_url: http://download.opensuse.org/repositories/home:/holland-backup/xUbuntu_14.04/Release.key
    - require_in:
      - pkg: holland

install-holland:
  pkg.installed:
    - name: holland
    - refresh: True
