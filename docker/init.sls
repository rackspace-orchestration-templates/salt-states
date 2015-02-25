docker-packages:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb https://get.docker.io/ubuntu docker main
    - keyid: A88D21E9
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/docker.list
    - require_in:
      - pkg: lxc-docker
  pkg.installed:
    - name: lxc-docker
