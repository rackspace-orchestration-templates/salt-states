install-vsftpd-server:
  pkg.installed:
    - name: vsftpd
  service.running:
    - name: vsftpd
