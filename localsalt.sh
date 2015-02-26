#!/bin/bash

# Install salt-minion using Salt Bootstrap
curl -L https://bootstrap.saltstack.com | sudo sh -s --
salt-minion --versions
# Set salt-minion to only use local resources
echo "file_client: local" > /etc/salt/minion.d/local.conf
# Make Pillar folder
mkdir /srv/pillar
# Clone down States
apt-get install git -y
git clone https://github.com/rackspace-orchestration-templates/salt-states.git /srv/salt
# Write out Pillar top.sls
echo "base:
  '*':
    - localhost" > /srv/pillar/top.sls
# Write out State top.sls
echo "base:
  '*':
    - salt-minion" > /srv/salt/top.sls

#######################################
## Edit this section ##################
#######################################
# Add states to the base (4 spaces)
echo "    - state1
    - state2
    - state3
" >> /srv/salt/top.sls
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
#######################################
## END ################################
#######################################

# Run local highstate
salt-call --local state.highstate
