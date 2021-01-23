
## Scripts that help install tools on CentOS quickly. 

### Git 

```bash
sudo yum --assumeyes install git

which git
git --version
```

For an up-to-date version, execute this [script](./Git.sh). 

### Node.js

Find the official guide [here](https://nodejs.org/en/download/package-manager/#centos-fedora-and-red-hat-enterprise-linux "CentOS, Fedora and Red Hat Enterprise Linux") and find release information [here](https://nodejs.org/en/about/releases/ "Long Term Support (LTS) schedule").

```bash
curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum --assumeyes install nodejs

which node
node --version
```

### Nmap 

Install Network Mapper 
 
```bash
yum --assumeyes install nmap

which nmap
nmap --version
```
 
### PostgreSQL

See intall [script](./postgresql.sh). 
 
A shortcut to enter PostgreSQL can be created as below. 

```bash
cat <<"END_OF_FILE" > '/usr/local/bin/psql'
#!/usr/bin/bash

/usr/bin/psql --username='postgres' "$@"
 
END_OF_FILE

chmod a+x '/usr/local/bin/psql'
```
 
### tcpdump
