{% set lsyncd_confdir = salt['pillar.get']('lsyncd:confdir', '/etc/lsyncd') %}
{% set lsyncd_logdir = salt['pillar.get']('lsyncd:logdir', '/var/log/lsyncd') %}

create-lsyncd-confdir:
  file.directory:
    - name: {{ lsyncd_confdir }}
    - makedirs: True

create-lsyncd-logdir:
  file.directory:
    - name: {{ lsyncd_logdir }}
    - makedirs: True

create-lsyncd-conf:
  file.managed:
    - name: /etc/lsyncd/lsyncd.conf.lua
    - source: salt://lsyncd/lsyncd.conf.lua.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja

install-lsyncd:
  pkg.installed:
    - name: lsyncd
  service.running:
    - name: lsyncd
    - watch:
      - file: /etc/lsyncd/lsyncd.conf.lua
