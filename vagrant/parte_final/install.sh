#!/bin/bash
sudo dnf -y install openldap-servers openldap-clients 
sudo ulimit -n 1024
sudo rm -rf /etc/openldap/slapd.d/*
sudo rm -rf /var/lib/ldap/*
sudo cp /vagrant/ldap/DB_CONFIG /var/lib/ldap/.
sudo slaptest -f /vagrant/ldap/slapd.conf -F /etc/openldap/slapd.d
#sudo slapadd -F /etc/openldap/slapd.d -l /vagrant/ldap/edt.org.ldif
#sudo chown -R ldap.ldap /etc/openldap/slapd.d
#sudo chown -R ldap.ldap /var/lib/ldap
#sudo cp /vagrant/ldap/ldap.conf /etc/openldap/ldap.conf
#sudo /sbin/slapd -d0
