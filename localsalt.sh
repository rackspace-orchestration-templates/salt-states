#!/bin/bash

# Install salt-minion using Salt Bootstrap
curl -L https://bootstrap.saltstack.com | sudo sh -s --

# Set salt-minion to only use local resources
echo "file_client: local" > /etc/salt/minion.d/local.conf

# Build file structure
mkdir -p /srv/salt /srv/pillar

# Clone down States
git clone git@github.com:rackspace-orchestration-templates/salt-states.git /srv/salt

# Write out State top.sls
echo "base:
  '*':
    - salt-minion
" > /srv/salt/top.sls

# Write out Pillar top.sls
echo "base:
  '*':
    - localhost
" > /srv/pillar/top.sls

# Example Pillar Data using %value% notation
# See example pillar data from states repository.
echo "
key: %value_from_heat%
key2:
  - %list%
  - %of%
  - %items%
key3:
  nested_key: %nested_value%
" > /srv/pillar/localhost.sls

# Run local highstate
salt-call --local state.highstate
