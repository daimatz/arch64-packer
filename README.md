# Packer template for Arch Linux Vagrant box

- http://www.packer.io/
- http://www.vagrantup.com/

```sh
packer build template.json
vagrant box remove arch64 # for update
vagrant box add arch64 packer_virtualbox_virtualbox.box
cd /path/to/vagrant-vm
vagrant init arch64
vagrant up
vagrant ssh
# username: vagrant, password: vagrant
```
