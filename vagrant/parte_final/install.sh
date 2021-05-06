# Update Packages
apt-get update
# Upgrade Packages
apt-get upgrade

# Basic Linux Stuff
apt-get install -y git

# Apache
apt-get install -y apache2

# Enable Apache Mods
a2enmod rewrite

#Add Onrej PPA Repo
apt-add-repository ppa:ondrej/php -y
apt-get update

# Install PHP
apt-get install -y php7.2

# PHP Apache Mod
apt-get install -y libapache2-mod-php7.2

# Restart Apache
service apache2 restart

# PHP Mods
apt-get install -y php7.2-common
apt-get install -y php7.2-mcrypt
apt-get install -y php7.2-zip

# set slapd pass
debconf-set-selections <<< 'slapd slapd/root_password password jupiter'
debconf-set-selections <<< 'slapd slapd/root_password_again password jupiter'

DEBIAN_FRONTEND=noninteractive apt-get -y install slapd
apt-get install -y ldap-utils
rm -rf /etc/ldap/slapd.d/*
rm -rf /var/lib/ldap/*
cp /vagrant/ldap/DB_CONFIG /var/lib/ldap/.
slaptest -Q -f /vagrant/ldap/slapd.conf -F /etc/ldap/slapd.d &> /dev/null
slapadd -F /etc/ldap/slapd.d -l /vagrant/ldap/edt.org.ldif
chown -R openldap.openldap /etc/ldap/slapd.d
chown -R openldap.openldap /var/lib/ldap
cp /vagrant/ldap/ldap.conf /etc/ldap/ldap.conf
sudo service slapd start
sudo service slapd restart