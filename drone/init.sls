drone-dependencies:
  pkg.installed:
    - pkgs: {{ salt['pillar.get']('drone:packages') }}

docker-py:
  pip.installed:
    - require:
      - pkg: drone-dependencies

pyOpenSSL:
  pip.installed:
    - require:
      - pkg: drone-dependencies

drone-selfsigned-cert:
  module.run:
    - name: tls.create_self_signed_cert
    - ca.cert_base_path: /etc/pki
    - tls_dir: drone
    - CN: drone

drone-package:
  pkg.installed:
    - sources:
      - drone: {{ salt['pillar.get']('drone:deb_url') }}
  service.running:
    - name: drone
    - watch:
      - file: /etc/drone/drone.toml

/etc/drone/drone.toml:
  file.managed:
    - source: salt://drone/drone.toml.jinja
    - template: jinja
