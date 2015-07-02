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
