install-vsftpd-server:
  pkg.installed:
    - name: vsftpd
  service.running:
    - name: vsftpd
    - watch:
      - file: /etc/vsftpd.conf

write-vsftpd-config:
  file.managed:
    - name: /etc/vsftpd.conf
    - source: salt://vsftpd/vsftpd.conf.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
