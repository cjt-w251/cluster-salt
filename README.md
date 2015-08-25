# cluster-salt
salt scripts for cluster setup ( including Spark, Yarn, HDFS, ElasticSearch, Kibana )

# Bootstrap

```bash
curl -o /tmp/install_salt.sh -L https://bootstrap.saltstack.com && sh /tmp/install_salt.sh -Z -M git v2015.5.3

export PRIVATE_IP1=10.114.77.140
export PRIVATE_IP2=10.114.77.146
export PRIVATE_IP3=10.114.77.152
export PRIVATE_IP4=10.115.7.156
export PRIVATE_IP5=10.115.7.168
export PRIVATE_IP6=10.115.7.176
export PRIVATE_IP7=10.114.133.107
export PRIVATE_IP8=10.114.133.74
export PRIVATE_IP9=10.114.133.75
export PRIVATE_IP10=10.114.172.11
export PRIVATE_IP11=10.114.172.14
export PRIVATE_IP12=10.114.172.22

# ssh-keygen -N '' -f ~/.ssh/id_rsa
export PUBLIC_KEY=`cat ~/.ssh/id_rsa.pub | cut -d ' ' -f 2`

# reuse ssh key used during provisioning
cat > /etc/salt/roster <<EOF
node1:
  host: $PRIVATE_IP1
  priv: /root/.ssh/id_rsa
node2:
  host: $PRIVATE_IP2
  priv: /root/.ssh/id_rsa
node3:
  host: $PRIVATE_IP3
  priv: /root/.ssh/id_rsa
node4:
  host: $PRIVATE_IP4
  priv: /root/.ssh/id_rsa
node5:
  host: $PRIVATE_IP5
  priv: /root/.ssh/id_rsa
node6:
  host: $PRIVATE_IP6
  priv: /root/.ssh/id_rsa
node7:
  host: $PRIVATE_IP7
  priv: /root/.ssh/id_rsa
node8:
  host: $PRIVATE_IP8
  priv: /root/.ssh/id_rsa
node9:
  host: $PRIVATE_IP9
  priv: /root/.ssh/id_rsa
node10:
  host: $PRIVATE_IP10
  priv: /root/.ssh/id_rsa
node11:
  host: $PRIVATE_IP11
  priv: /root/.ssh/id_rsa
node12:
  host: $PRIVATE_IP12
  priv: /root/.ssh/id_rsa
EOF

mv /etc/salt/master /etc/salt/master~orig
cat > /etc/salt/master <<EOF
file_roots:
  base:
    - /srv/salt
fileserver_backend:
  - roots
pillar_roots:
  base:
    - /srv/pillar
EOF

mkdir -p /srv/{salt,pillar} && service salt-master restart

salt-ssh -i '*' cmd.run 'uname -a'

cat > /srv/salt/top.sls <<EOF
base:
 '*':
   - hosts
   - root.ssh
   - root.bash
EOF

cat > /srv/salt/hosts.sls <<EOF
localhost-hosts-entry:
  host.present:
    - ip: 127.0.0.1
    - names:
      - localhost
node1-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP1
    - names:
      - node1.kunicki.net
node2-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP2
    - names:
      - node2.kunicki.net
node3-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP3
    - names:
      - node3.kunicki.net
node4-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP4
    - names:
      - node4.kunicki.net
node5-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP5
    - names:
      - node5.kunicki.net
node6-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP6
    - names:
      - node6.kunicki.net
node7-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP7
    - names:
      - node7.kunicki.net
node8-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP8
    - names:
      - node8.kunicki.net
node9-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP9
    - names:
      - node9.kunicki.net
node10-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP10
    - names:
      - node10.kunicki.net
node11-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP11
    - names:
      - node11.kunicki.net
node12-fqdn-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP12
    - names:
      - node12.kunicki.net
node1-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP1
    - names:
      - node1
node2-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP2
    - names:
      - node2
node3-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP3
    - names:
      - node3
node4-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP4
    - names:
      - node4
node5-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP5
    - names:
      - node5
node6-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP6
    - names:
      - node6
node7-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP7
    - names:
      - node7
node8-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP8
    - names:
      - node8
node9-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP9
    - names:
      - node9
node10-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP10
    - names:
      - node10
node11-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP11
    - names:
      - node11
node12-hosts-entry:
  host.present:
    - ip: $PRIVATE_IP12
    - names:
      - node12
EOF

mkdir /srv/salt/root
cat > /srv/salt/root/ssh.sls <<EOF
$PUBLIC_KEY:
 ssh_auth.present:
   - user: root
   - enc: ssh-rsa
   - comment: root@node5
EOF

cat > /srv/salt/root/bash_profile <<'EOF'
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
 . ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin
EOF

cat > /srv/salt/root/bashrc <<'EOF'
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Java
export JAVA_HOME="$(readlink -f $(which java) | grep -oP '.*(?=/bin)')"

# Spark
export SPARK_HOME="/usr/local/spark"
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Hadoop
export HADOOP_HOME="/usr/local/hadoop"
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Spark (part 2, should come after hadoop setup)
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
EOF

cat > /srv/salt/root/bash.sls <<EOF
/root/.bash_profile:
  file.managed:
    - source: salt://root/bash_profile
    - overwrite: true
/root/.bashrc:
  file.managed:
    - source: salt://root/bashrc
    - overwrite: true
EOF

salt-ssh '*' state.highstate

salt-ssh '*' cmd.run 'yum install -y yum-utils'
salt-ssh '*' cmd.run 'yum install -y epel-release'
salt-ssh '*' cmd.run 'yum update -y'
salt-ssh '*' cmd.run 'yum install -y java-1.7.0-openjdk-headless'

mkdir /srv/salt/spark
cat > /srv/salt/spark/slaves <<EOF
node1.kunicki.net
node2.kunicki.net
node3.kunicki.net
node4.kunicki.net
node5.kunicki.net
node6.kunicki.net
node7.kunicki.net
node8.kunicki.net
node9.kunicki.net
node10.kunicki.net
node11.kunicki.net
node12.kunicki.net
EOF

cat > /srv/salt/spark.sls <<EOF
spark:
  archive.extracted:
    - name: /usr/local/
    - source: http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-without-hadoop.tgz
    - source_hash: md5=e0effe0f2f308029f459fb0bb86ca885
    - archive_format: tar
    - tar_options: -z --transform=s,/*[^/]*,spark,
    - if_missing: /usr/local/spark/
/usr/local/spark/conf/slaves:
  file.managed:
    - source: salt://spark/slaves
    - overwrite: true
EOF

salt-ssh '*' cmd.run 'mkdir -m 777 /data'
salt-ssh '*' cmd.run 'mkfs.ext4 /dev/xvdc'
salt-ssh '*' cmd.run 'echo "/dev/xvdc /data ext4 defaults,noatime 0 0" >> /etc/fstab'
salt-ssh '*' cmd.run 'mount /data'

mkdir /srv/salt/hadoop
cat > /srv/salt/hadoop/masters <<EOF
node5.kunicki.net
EOF

cat > /srv/salt/hadoop/slaves <<EOF
node1.kunicki.net
node2.kunicki.net
node3.kunicki.net
node4.kunicki.net
node5.kunicki.net
node6.kunicki.net
node7.kunicki.net
node8.kunicki.net
node9.kunicki.net
node10.kunicki.net
node11.kunicki.net
node12.kunicki.net
EOF

cat > /srv/salt/hadoop/core-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>fs.default.name</name>
    <value>hdfs://node5.kunicki.net:9000</value>
  </property>
</configuration>
EOF

cat > /srv/salt/hadoop/etc/hadoop/mapred-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
EOF

cat > /srv/salt/hadoop/hdfs-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>3</value>
  </property>
  <property>
    <name>dfs.data.dir</name>
    <value>/data/hdfs</value>
  </property>
</configuration>
EOF

cat > /srv/salt/hadoop/yarn-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
  <property>
    <name>yarn.resourcemanager.resource-tracker.address</name>
    <value>node5.kunicki.net:8025</value>
  </property>
  <property>
    <name>yarn.resourcemanager.scheduler.address</name>
    <value>node5.kunicki.net:8030</value>
  </property>
  <property>
    <name>yarn.resourcemanager.address</name>
    <value>node5.kunicki.net:8050</value>
  </property>
</configuration>
EOF

cat > /srv/salt/hadoop.sls <<EOF
hadoop:
  archive.extracted:
    - name: /usr/local/
    - source: http://apache.claz.org/hadoop/core/hadoop-2.7.1/hadoop-2.7.1.tar.gz
    - source_hash: md5=203e5b4daf1c5658c3386a32c4be5531
    - archive_format: tar
    - tar_options: -z --transform=s,/*[^/]*,hadoop,
    - if_missing: /usr/local/hadoop/
/usr/local/hadoop/etc/hadoop/masters:
  file.managed:
    - source: salt://hadoop/masters
    - overwrite: true 
/usr/local/hadoop/etc/hadoop/slaves:
  file.managed:
    - source: salt://hadoop/slaves
    - overwrite: true 
/usr/local/hadoop/etc/hadoop/core-site.xml:
  file.managed:
    - source: salt://hadoop/core-site.xml
    - overwrite: true 
/usr/local/hadoop/etc/hadoop/mapred-site.xml:
  file.managed:
    - source: salt://hadoop/mapred-site.xml
    - overwrite: true 
/usr/local/hadoop/etc/hadoop/hdfs-site.xml:
  file.managed:
    - source: salt://hadoop/hdfs-site.xml
    - overwrite: true 
/usr/local/hadoop/etc/hadoop/yarn-site.xml:
  file.managed:
    - source: salt://hadoop/yarn-site.xml
    - overwrite: true 
/data/hdfs:
  file.directory
EOF

salt-ssh '*' state.apply spark
salt-ssh '*' state.apply hadoop

hadoop namenode -format
```
