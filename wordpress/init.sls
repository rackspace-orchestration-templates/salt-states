write-wordpress-varnish-template:
  file.managed:
    - name: /etc/varnish/default.vcl
    - source: salt://wordpress/default.vcl.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
