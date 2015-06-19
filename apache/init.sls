install-apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-enabled/*
      - file: /etc/apache2/mods-enabled/*
      - file: /etc/apache2/ports.conf

configure-apache-ports:
  file.managed:
    - name: /etc/apache2/ports.conf
    - source: salt://apache/ports.conf.jinja
    - user: root
    - group: root
    - mode: 0644
    - template: jinja

enable-ssl:
  apache_module.enable:
    - name: ssl

enable-default-ssl-site:
  file.symlink:
    - name: /etc/apache2/sites-enabled/default-ssl.conf
    - target: ../sites-available/default-ssl.conf

{% for vhost in salt['pillar.get']('apache:vhosts', '') %}
write-{{ vhost.domain }}-vhost:
  file.managed:
    - name: /etc/apache2/sites-available/{{ vhost.domain }}.conf
    - source: salt://apache/vhost.conf.jinja
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - defaults:
        domain: {{ vhost.domain }}
	docroot: {{ vhost.docroot }}

enable-{{ vhost.domain }}-vhost:
  file.symlink:
    - name: /etc/apache2/sites-enabled/{{ vhost.domain }}.conf
    - target: ../sites-available/{{ vhost.domain }}.conf
{% endfor %}
