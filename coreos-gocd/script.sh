#!/bin/bash
#add key to gocd-agent
docker exec -it -u go gocd-agent /bin/bash -c "mkdir -p /var/go/.ssh/"
docker cp ./shared/key/id_rsa gocd-agent:/var/go/.ssh/
docker exec -it gocd-agent /bin/bash -c "chown go:go /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-agent /bin/bash -c "chmod 400 /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-agent /bin/bash -c 'eval "$(ssh-agent -s)" && ssh-add /var/go/.ssh/id_rsa'
docker exec -it -u go gocd-agent /bin/bash -c "cd /var/go/.ssh && ssh-keyscan github.com >> /var/go/.ssh/known_hosts"
docker exec -it -u go gocd-agent /bin/bash -c 'mkdir -p /var/go/.git'
docker exec -it -u go gocd-agent /bin/bash -c 'git config --global core.sshCommand "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /var/go/.ssh/id_rsa -F /dev/null"'
#add key to gocd-server
docker exec -it -u go gocd-server /bin/bash -c "mkdir -p /var/go/.ssh/"
docker cp ./shared/key/id_rsa gocd-server:/var/go/.ssh/
docker exec -it gocd-server /bin/bash -c "chown go:go /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-server /bin/bash -c "chmod 400 /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-server /bin/bash -c 'eval "$(ssh-agent -s)" && ssh-add /var/go/.ssh/id_rsa'
docker exec -it -u go gocd-server /bin/bash -c "cd /var/go/.ssh && ssh-keyscan github.com >> /var/go/.ssh/known_hosts"
docker exec -it -u go gocd-server /bin/bash -c 'mkdir -p /var/go/.git'
docker exec -it -u go gocd-server /bin/bash -c 'git config --global core.sshCommand "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /var/go/.ssh/id_rsa -F /dev/null"'
