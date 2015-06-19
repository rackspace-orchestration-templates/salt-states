application-dependencies:
  pkg.installed:
    - pkgs: {{ salt['pillar.get']('application:packages', '') }}

write-application-deploy-key:
  file.managed:
    - name: /root/.ssh/application_id_rsa
    - user: root
    - group: root
    - mode: 0500
    - contents_pillar: application:deploy_key

application-repo-fingerprint:
  ssh_known_hosts:
    - name: gitlab.example.com
    - present
    - user: root
    - enc: ecdsa
    - fingerprint: 4e:94:b0:54:c1:5b:29:a2:70:0e:e1:a3:51:ee:ee:e3

checkout-application:
  git.latest:
    - name: {{ salt['pillar.get']('application:repo', '') }}
    - rev: {{ salt['pillar.get']('application:revision', 'master') }}
    - target: {{ salt['pillar.get']('application:destination', '') }}
    - identity: /root/.ssh/application_id_rsa
