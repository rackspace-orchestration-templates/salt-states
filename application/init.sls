application-dependencies:
  pkg.installed:
    - pkgs: {{ salt['pillar.get']('application:packages', '[]') }}

write-application-deploy-key:
  file.managed:
    - name: /root/.ssh/application_id_rsa
    - user: root
    - group: root
    - mode: 0500
    - contents_pillar: application:deploy_key

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
