lsyncd:
  confdir: /etc/lsyncd
  logdir: /var/log/lsyncd
  interval: 20
  source_directory: /var/www
  targets:
    - server1
    - server2
  target_directory: /var/www
  rsh_options: /usr/bin/ssh -p 22 -o StrictHostKeyChecking=no
