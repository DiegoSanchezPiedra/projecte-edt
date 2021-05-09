#!/bin/bash
sleep 30
sudo apt update
sudo apt -y install apache2
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt -y install php7.4

sudo rm -f /var/www/html/index.html
sudo cat <<'EOF' >> /var/www/html/index.php
<?php
phpinfo();
?>
EOF

#service httpd restart
sudo systemctl start apache2.service