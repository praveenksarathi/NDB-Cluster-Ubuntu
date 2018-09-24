#disable Firewall
sudo ufw disable
sleep 5
#check Firewall status
sudo ufw status

cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb

sleep 5


sudo dpkg -i mysql-cluster-community-management-server_7.6.6-1ubuntu18.04_amd64.deb

open : vi /etc/sysctl.conf

#Append:
# allow processes to bind to the non-local address
# (necessary for apache/nginx in Amazon EC2)
net.ipv4.ip_nonlocal_bind = 1

#Run:
sysctl -p /etc/sysctl.conf

sudo mkdir /var/lib/mysql-cluster

sudo nano /var/lib/mysql-cluster/config.ini

#Paste below content into config.ini Replace Hostname with appropriate server IPs
#----------------------------------------------------------------------------------------------------
[ndbd default]
# Options affecting ndbd processes on all data nodes:
NoOfReplicas=2  # Number of replicas

[ndb_mgmd]
# Management process options:
hostname=198.51.100.2 # Hostname of the manager
datadir=/var/lib/mysql-cluster  # Directory for the log files

[ndbd]
hostname=198.51.100.0 # Hostname/IP of the first data node
NodeId=2            # Node ID for this data node
datadir=/usr/local/mysql/data   # Remote directory for the data files

[ndbd]
hostname=198.51.100.1 # Hostname/IP of the second data node
NodeId=3            # Node ID for this data node
datadir=/usr/local/mysql/data   # Remote directory for the data files

[mysqld]
# SQL node options:
hostname=198.51.100.2 # In our case the MySQL server/client is on the same Droplet as the cluster manager

#--------------------------------------------------------------------------------------------------------

