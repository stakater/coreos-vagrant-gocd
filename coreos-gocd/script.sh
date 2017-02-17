#!/bin/bash
docker exec -it -u go gocd-agent /bin/bash -c "mkdir -p /var/go/.ssh/"
docker cp ./shared/key/id_rsa gocd-agent:/var/go/.ssh/
docker exec -it gocd-agent /bin/bash -c "chown go:go /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-agent /bin/bash -c "chmod 700 /var/go/.ssh/id_rsa"
docker exec -it -u go gocd-agent /bin/bash -c "cd /var/go/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts"
