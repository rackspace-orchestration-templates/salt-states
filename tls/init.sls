install-tls-dependencies:
  pkg.installed:
    - name: python-openssl

generate-self-signed-cert:
  module.run:
    - name: tls.create_self_signed_cert
    - ca.cert_base_path: /etc/pki
    - tls_dir: salt
    - CN: localhost
    - require:
      - pkg: python-openssl
