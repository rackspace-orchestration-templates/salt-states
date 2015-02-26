drone:
  deb_url: http://downloads.drone.io/master/drone.deb
  ssl_key: /etc/pki/drone/certs/drone.key
  ssl_cert: /etc/pki/drone/certs/drone.crt
  port: 443
  packages:
    - python-pip
    - bc
    - python-dev
    - build-essential
