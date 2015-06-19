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

application-repo-fingerprint:
  ssh_known_hosts:
    - name: {{ salt['pillar.get']('application:repo_hostname', '') }}
    - present
    - user: root
    - fingerprint: {{ salt['pillar.get']('application:fingerprint', '') }}

checkout-application:
  git.latest:
    - name: {{ salt['pillar.get']('application:repo', '') }}
    - rev: {{ salt['pillar.get']('application:revision', 'master') }}
    - target: {{ salt['pillar.get']('application:destination', '') }}
    - identity: /root/.ssh/application_id_rsa
