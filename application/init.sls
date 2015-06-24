application-dependencies:
  pkg.installed:
    - pkgs: {{ salt['pillar.get']('application:packages', '[]') }}

write-application-deploy-key:
  file.managed:
    - name: /root/.ssh/application_id_rsa.raw
    - user: root
    - group: root
    - mode: 0500
    - contents_pillar: application:deploy_key

fix-deploy-key-newlines:
  cmd.run:
    - name: cat /root/.ssh/application_id_rsa.raw | sed 's/\\n/\n/g' > /root/.ssh/application_id_rsa
    - creates: /root/.ssh/application_id_rsa

fix-deploy-key-permissions:
  file.managed:
    - name: /root/.ssh/application_id_rsa
    - user: root
    - group: root
    - mode: 0500

disable-strict-host-key-check:
  file.managed:
    - name: /root/.ssh/config
    - user: root
    - group: root
    - mode: 0500
    - contents: |
          Host *
              StrictHostKeyChecking no

checkout-application:
  git.latest:
    - name: {{ salt['pillar.get']('application:repo', '') }}
    - rev: {{ salt['pillar.get']('application:revision', 'master') }}
    - target: {{ salt['pillar.get']('application:destination', '') }}
    - identity: /root/.ssh/application_id_rsa

disable-default-ssl-site:
  file.absent:
    - name: /etc/apache2/sites-enabled/default-ssl.conf
    - watch_in:
      - service: install-apache

disable-default-site:
  file.absent:
    - name: /etc/apache2/sites-enabled/default.conf
    - watch_in:
      - service: install-apache
