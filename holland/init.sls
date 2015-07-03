holland-repo:
  pkgrepo.managed:
    - name: deb http://download.opensuse.org/repositories/home:/holland-backup/xUbuntu_14.04/ /
    - key_url: http://download.opensuse.org/repositories/home:/holland-backup/xUbuntu_14.04/Release.key
    - require_in:
      - pkg: holland

install-holland:
  pkg.installed:
    - name: holland
    - refresh: True

{% for backupset, configuration in salt['pillar.get']('holland:backupsets', '').items() %}
write-{{ backupset }}-backupset:
  file.managed:
    - name: /etc/holland/backupsets/{{ backupset }}.conf
    - source: salt://holland/default.conf.jinja
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - defaults:
        configuration: {{ configuration }}
{% endfor %}

cron-daily-holland-backup:
  file.managed:
    - name: /etc/cron.daily/holland
    - source: salt://holland/holland
    - user: root
    - group: root
    - mode: 755
