drone-dependencies:
  pkg.installed:
    - pkgs:
      - bc
      - python-setuptools
      - python-dev
      - build-essential
      - libffi-dev
      - libssl-dev

upgrade-pip:
  cmd.run:
    - name: easy_install -U pip
    - reload_modules: True
    - require:
      - pkg: drone-dependencies

docker-py:
  pip.installed:
    - require:
      - pkg: drone-dependencies

pyOpenSSL:
  pip.installed:
    - reload_modules: True
    - require:
      - pkg: drone-dependencies

drone-selfsigned-cert:
  module.run:
    - name: tls.create_self_signed_cert
    - ca.cert_base_path: /etc/pki
    - tls_dir: drone
    - CN: drone
    - require:
      - pip: pyOpenSSL

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
