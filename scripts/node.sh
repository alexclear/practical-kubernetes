#!/bin/bash
#
# Setup for Node servers

set -euxo pipefail

config_path="/vagrant/configs"
NODENAME=$(hostname -s)

sudo -i -u vagrant bash << EOF
whoami
mkdir -p /home/vagrant/.kube
sudo cp -i $config_path/config /home/vagrant/.kube/
sudo chown 1000:1000 /home/vagrant/.kube/config
EOF

# Check if the node is already part of a Kubernetes cluster
if ! sudo -i -u vagrant kubectl get nodes | grep -q $NODENAME; then
    /bin/bash $config_path/join.sh -v
fi

sudo -i -u vagrant bash << EOF
kubectl label node $(hostname -s) node-role.kubernetes.io/worker=worker --overwrite
EOF
