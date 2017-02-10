# Vagrant VirtualBox CoreOS with GoCD
This Repo contains the following Vagrant based CoreOS machine(s):

1. [Coreos GoCD]()



##Coreos GoCD
This machine starts `GoCD Server` and `GoCD agent` via its cloud-config file (`consul-agent/user-data.yml`).
You can access the GoCD server UI from `machine-ip:8153`

######NOTE:
The `shared` directory is mapped inside the vagrant machine to easily share files between the host and vagrant machines.
The `cruise-config.xml` placed in the `shared/gocd-data/conf` directory is mapped inside gocd-server. You can update the cruise config from here or from the GoCD Server UI. If you plan to update the cruise config from this file, make sure you end up with a valid `cruise-config.xml`, else GoCD Server won't start.


##How to Run:

1. Scroll down to [Streamlined setup](#Streamlined setup) and install all dependencies

2. Navigate to the `coreos-gocd` directory and run `vagrant up`. Once the vagrant machine is up, you can access the GoCD Server UI from the server's ip address, by default : `http://172.17.9.101:8153`

Troubleshoot

once you ssh into vagrant machine and you don't see any containers; then you can check status like this:
```
systemctl status gocd-server
```

###### The vagrant machines used in this set up are inspired from: https://github.com/coreos/coreos-vagrant

## Streamlined setup

1) Install dependencies

* [VirtualBox][virtualbox] 4.3.10 or greater.
* [Vagrant][vagrant] 1.6.3 or greater.

2) Clone this project and get it running!

```
git clone https://github.com/stakater/coreos-vagrant-gocd.git
cd coreos-vagrant-gocd
```

3) Startup and SSH

There are two "providers" for Vagrant with slightly different instructions.
Follow one of the following two options:

**VirtualBox Provider**

The VirtualBox provider is the default Vagrant provider. Use this if you are unsure.

```
vagrant up
vagrant ssh
```

**VMware Provider**

The VMware provider is a commercial addon from Hashicorp that offers better stability and speed.
If you use this provider follow these instructions.

VMware Fusion:
```
vagrant up --provider vmware_fusion
vagrant ssh
```

VMware Workstation:
```
vagrant up --provider vmware_workstation
vagrant ssh
```

``vagrant up`` triggers vagrant to download the CoreOS image (if necessary) and (re)launch the instance

``vagrant ssh`` connects you to the virtual machine.
Configuration is stored in the directory so you can always return to this machine by executing vagrant ssh from the directory where the Vagrantfile was located.

4) Get started [using CoreOS][using-coreos]
Check out the [coreos-cloudinit documentation][coreos-cloudinit] to learn about the available features.

[coreos-cloudinit]: https://github.com/coreos/coreos-cloudinit

## New Box Versions

CoreOS is a rolling release distribution and versions that are out of date will automatically update.
If you want to start from the most up to date version you will need to make sure that you have the latest box file of CoreOS. You can do this by running
```
vagrant box update
```


## Docker Forwarding

By setting the `$expose_docker_tcp` configuration value you can forward a local TCP port to docker on
each CoreOS machine that you launch. The first machine will be available on the port that you specify
and each additional machine will increment the port by 1.

Follow the [Enable Remote API instructions][coreos-enabling-port-forwarding] to get the CoreOS VM setup to work with port forwarding.

[coreos-enabling-port-forwarding]: https://coreos.com/docs/launching-containers/building/customizing-docker/#enable-the-remote-api-on-a-new-socket

Then you can then use the `docker` command from your local shell by setting `DOCKER_HOST`:

    export DOCKER_HOST=tcp://localhost:2375
