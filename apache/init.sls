install-apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
