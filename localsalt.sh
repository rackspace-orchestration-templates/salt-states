#!/bin/bash

# Install salt-minion
curl -L https://bootstrap.saltstack.com | sudo sh -s -- -U

# Set salt-minion to only use local resources
echo "file_client: local" > /etc/salt/minion.d/local.conf

# Build file structure
mkdir -p /srv/salt /srv/pillar

# Run local highstate
salt-call --local state.highstate
