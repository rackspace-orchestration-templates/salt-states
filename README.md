# salt-states
Salt States for use in the local salt-call configuration method.

## States
States exist in the root of this repository. Each state will be listed
in `top.sls` for testing purposes.

## Pillar
Pillar data for each state should be placed in `.pillar`.

## TODO
 * Writing out the pillar data in a secure manner using the str\_replace feature.
 * Target Ubuntu first, and then write in CentOS and other distro support later.
 * Swift Signal state that pulls the URL from pillar. Also logs somehow.

## Resources
 * [Masterless Salt Quickstart](http://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html)
 * [Cloud Config Examples](http://cloudinit.readthedocs.org/en/latest/topics/examples.html)
