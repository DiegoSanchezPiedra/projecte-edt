#!/bin/bash
apt update
apt upgrade
apt -y install apache2
apt -y install software-properties-common
add-apt-repository ppa:ondrej/php
apt -y install php7.4

rm -f /var/www/html/index.html
cat <<'EOF' >> /var/www/html/index.php
<?php
phpinfo();
?>
EOF

#service httpd restart
systemctl start apache2.service