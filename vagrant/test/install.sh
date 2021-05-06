debconf-set-selections <<< 'slapd slapd/root_password password jupiter'
debconf-set-selections <<< 'slapd slapd/root_password_again password jupiter'
DEBIAN_FRONTEND=noninteractive apt-get -y install slapd
