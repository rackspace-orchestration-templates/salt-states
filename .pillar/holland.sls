holland:
  backupsets:
    default:
      "holland:backup":
        plugin: mysqldump
        backups-to-keep: 5
        auto-purge-failures: yes
        purge-policy: after-backup
        estimated-size-factor: 1.0
      mysqldump:
        file-per-database: yes
      compression:
        method: gzip
        inline: yes
        level: 1
      "mysql:client":
        user: root
        password: r00tp4ssword
    wordpress:
      "holland:backup":
        plugin: mysqldump
        backups-to-keep: 1
        auto-purge-failures: yes
        purge-policy: after-backup
        estimated-size-factor: 1.0
      mysqldump:
        file-per-database: yes
      "mysql:client":
        user: wp_user
        password: wp_password
