#!/usr/bin/env bash

export DOWNLOAD_KEY='<download_key>'

echo 'deb [signed-by=/usr/share/keyrings/instana-archive-keyring.gpg] https://artifact-public.instana.io/artifactory/rel-debian-public-virtual generic main' > /etc/apt/sources.list.d/instana-product.list

cat << EOF > /etc/apt/auth.conf
machine artifact-public.instana.io
  login _
  password $DOWNLOAD_KEY
EOF

wget -nv -O- --user=_ --password="$DOWNLOAD_KEY" https://artifact-public.instana.io/artifactory/api/security/keypair/public/repositories/rel-debian-public-virtual | gpg --dearmor > /usr/share/keyrings/instana-archive-keyring.gpg

apt update -y
apt install -y stanctl

sysctl vm.swappiness=0
sysctl fs.inotify.max_user_instances=8192

# Disable transparent hugepages
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag

mkfs.xfs /dev/vdb1
mkfs.xfs /dev/vdc1

mkdir -p /mnt/instana/stanctl/{objects,metrics,analytics,data}
mount /dev/vdb1 /mnt/instana/stanctl/metrics
mount /dev/vdc1 /mnt/instana/stanctl/analytics
