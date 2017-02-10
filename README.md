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

core@gocd-01 ~ $ systemctl status gocd-server
● gocd-server.service - gocd server
   Loaded: loaded (/etc/systemd/system/gocd-server.service; static; vendor preset: disabled)
   Active: active (running) since Fri 2017-02-10 15:04:42 UTC; 20min ago
  Process: 1803 ExecStartPre=/usr/bin/chown -R 999:rkt-admin /gocd-data/server (code=exited, status=0/SUCCESS)
  Process: 1800 ExecStartPre=/usr/bin/cp -r /home/core/shared/gocd-data/conf /gocd-data/server/ (code=exited, status=0/SUCCESS)
  Process: 1796 ExecStartPre=/usr/bin/mkdir -p /gocd-data/server/data (code=exited, status=0/SUCCESS)
  Process: 1792 ExecStartPre=/usr/bin/docker rm %n (code=exited, status=1/FAILURE)
  Process: 1585 ExecStartPre=/usr/bin/docker pull gocd/gocd-server:16.5.0-3305 (code=exited, status=0/SUCCESS)
  Process: 1569 ExecStartPre=/usr/bin/bash -c /usr/bin/systemctl set-environment HOSTNAME=$(hostname -i) (code=exited, status=0/SUCCESS)
 Main PID: 1807 (docker)
    Tasks: 4
   Memory: 5.4M
      CPU: 316ms
   CGroup: /system.slice/gocd-server.service
           └─1807 /usr/bin/docker run --rm --name gocd-server.service -p 8153:8153 -e AGENT_KEY=123456789abcdef -e SERVICE_NAME=gocd-server -v /gocd-data/server/conf:/etc/go -v /gocd-data/server/data:/var

Feb 10 15:07:00 gocd-01 sh[1807]: LOG: 2017-02-10 15:06:52,580  INFO [qtp1044696854-20] CachedFileGoConfig:251 - Finished notifying all listeners
Feb 10 15:07:00 gocd-01 sh[1807]: LOG: 2017-02-10 15:06:52,581  INFO [qtp1044696854-20] CachedFileGoConfig:245 - Finished notifying all listeners
Feb 10 15:07:00 gocd-01 sh[1807]: LOG: 2017-02-10 15:06:52,581  INFO [qtp1044696854-20] GoConfigDao:203 - Config update request by anonymous is completed
Feb 10 15:07:00 gocd-01 sh[1807]: LOG: 2017-02-10 15:06:58,071  INFO [qtp1044696854-25] BuildRepositoryRemoteImpl:133 - [Agent Cookie] Agent [Agent [5449c6e61a21, 172.18.0.3, df83e82c-11b7-428e-8191-a2592
Feb 10 15:23:18 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:18,108  WARN [qtp1044696854-24] PipelineSqlMapDao:484 - No pipelines found in Config, Skipping PIM loading.
Feb 10 15:23:19 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:19,583  INFO [qtp1044696854-22] ServerVersionInfoManager:71 - [Go Update Check] Starting update check at: Fri Feb 10 15:23:19 UTC 2017
Feb 10 15:23:19 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:19,634  INFO [qtp1044696854-23] CachedCommandSnippets:57 - [Command Repository] Reloading command snippets.
Feb 10 15:23:20 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:20,809  INFO [qtp1044696854-28] ServerVersionInfoManager:86 - [Go Update Check] Update check done at: Fri Feb 10 15:23:20 UTC 2017, latest available
Feb 10 15:23:29 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:29,163  WARN [qtp1044696854-30] PipelineSqlMapDao:484 - No pipelines found in Config, Skipping PIM loading.
Feb 10 15:23:46 gocd-01 sh[1807]: LOG: 2017-02-10 15:23:46,746  INFO [qtp1044696854-20] MagicalGoConfigXmlWriter:91 - [Serializing Config] Generating config partial.

```

```
core@gocd-01 ~ $ systemctl status gocd-agent 
● gocd-agent.service - gocd agent
   Loaded: loaded (/etc/systemd/system/gocd-agent.service; static; vendor preset: disabled)
   Active: active (running) since Fri 2017-02-10 15:06:43 UTC; 19min ago
  Process: 2527 ExecStartPre=/usr/bin/cp -r /home/core/shared/gocd-data/sudoers /gocd-data/agent/ (code=exited, status=0/SUCCESS)
  Process: 2523 ExecStartPre=/usr/bin/mkdir -p /gocd-data/agent (code=exited, status=0/SUCCESS)
  Process: 2518 ExecStartPre=/usr/bin/docker rm %n (code=exited, status=1/FAILURE)
  Process: 1827 ExecStartPre=/usr/bin/docker pull stakater/gocd-agent:16.5.0-3305 (code=exited, status=0/SUCCESS)
  Process: 1809 ExecStartPre=/usr/bin/bash -c /usr/bin/systemctl set-environment HOSTNAME=$(hostname -i) (code=exited, status=0/SUCCESS)
 Main PID: 2531 (docker)
    Tasks: 4
   Memory: 4.9M
      CPU: 291ms
   CGroup: /system.slice/gocd-agent.service
           └─2531 /usr/bin/docker run --rm --name gocd-agent.service -e AGENT_KEY=123456789abcdef -e SERVICE_NAME=gocd-agent -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker

Feb 10 15:06:45 gocd-01 sh[2531]: 933 [main] INFO com.thoughtworks.go.agent.launcher.ServerBinaryDownloader  - pipe the stream to admin/agent at Fri Feb 10 15:06:45 UTC 2017
Feb 10 15:06:45 gocd-01 sh[2531]: 935 [main] INFO com.thoughtworks.go.util.PerfTimer  - Performance: Downloading new admin/agent with md5 signature: fz/hrJeCNFIbFznCD2owjw== took 397ms
Feb 10 15:06:45 gocd-01 sh[2531]: 942 [main] INFO com.thoughtworks.go.agent.common.util.JarUtil  - Attempting to load Go-Agent-Bootstrap-Class from agent.jar File:
Feb 10 15:06:45 gocd-01 sh[2531]: 943 [main] INFO com.thoughtworks.go.agent.common.util.JarUtil  - manifestClassKey: Go-Agent-Bootstrap-Class: com.thoughtworks.go.agent.AgentProcessParentImpl
Feb 10 15:06:45 gocd-01 sh[2531]: 951 [main] INFO com.thoughtworks.go.agent.AgentProcessParentImpl  - Agent is version: 16.5.0
Feb 10 15:06:45 gocd-01 sh[2531]: 1089 [main] INFO com.thoughtworks.go.agent.launcher.ServerBinaryDownloader  - download started at Fri Feb 10 15:06:45 UTC 2017
Feb 10 15:06:45 gocd-01 sh[2531]: 1098 [main] INFO com.thoughtworks.go.agent.launcher.ServerBinaryDownloader  - got server response at Fri Feb 10 15:06:45 UTC 2017
Feb 10 15:06:45 gocd-01 sh[2531]: 1135 [main] INFO com.thoughtworks.go.agent.launcher.ServerBinaryDownloader  - pipe the stream to admin/agent-plugins.zip at Fri Feb 10 15:06:45 UTC 2017
Feb 10 15:06:45 gocd-01 sh[2531]: 1138 [main] INFO com.thoughtworks.go.util.PerfTimer  - Performance: Downloading new admin/agent-plugins.zip with md5 signature: cbe245bd7818dcee30cb19716eb6fe80 took 48ms
Feb 10 15:06:45 gocd-01 sh[2531]: 1152 [main] INFO com.thoughtworks.go.agent.AgentProcessParentImpl  - Launching Agent with command: /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java -Dcruise.console.publish

```

```
core@gocd-01 ~ $ docker ps
CONTAINER ID        IMAGE                             COMMAND             CREATED              STATUS              PORTS                              NAMES
5449c6e61a21        stakater/gocd-agent:16.5.0-3305   "/sbin/my_init"     About a minute ago   Up About a minute                                      gocd-agent.service
82872795564d        gocd/gocd-server:16.5.0-3305      "/sbin/my_init"     3 minutes ago        Up 3 minutes        0.0.0.0:8153->8153/tcp, 8154/tcp   gocd-server.service
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
