# Procedimiento

## Índice

1. [AWS ami](#id1)   
2. [Vagrant Box](#id2)  
   
<a name="id1"></a>
## 1. AWS ami

Estal ami customizada partirá de una ami base de *Ubuntu Server 20.04 LTS*, la cual tendrá apache2 y php instalado por medio del provisioner **"shel"** y se la pasará el fichero *index.html* por medio del provisioner **"file"**.

**install.sh:**

```
#!/bin/bash
sleep 30
sudo apt update
sudo apt -y install apache2
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt -y install php7.4

sudo rm -f /var/www/html/index.html

#service httpd restart
sudo systemctl start apache2.service
```

**index.php:**

```
<?php
phpinfo();
?>
```

**image.json:**

```
{
    "builders": [
        {
            "typem": "amazon-ebs",
            "profile": "{{ user `aws_profile` }}",
            "region": "eu-west-3",
            "ami_name": "diego_ami",
            "source_ami": "ami-0f7cd40eac2214b37",
            "instance_type": "t2.micro",
            "ssh_username": "ubuntu"
        }
    ],
    "provisionaer": [
        {
            "type": "shell",
            "script": "intall.sh"
        },
        {
            "type": "file",
            "source": "index.php",
            "destination": "/tmp/"
        },
        {
            "type": "shell",
            "inline": ["sudo cp /tmp/index.php /var/www/html/"]
        }
    ]
}
```
* **Builders:**
  
  * Primero le indicamos que **Builder** queremos usar, en este caso el de **AWS** concretamente para crear amis para instancias EC2.
  * El profile se lo pasaremos como argumento por tal de aprovechar el CLI de AWS donde tenemos alamcenados nuestras **acces key** y **secret key**.
  * Le indicamos también la región donde usareme **AWS**.
  * El nombre que tendrá la ami que crearemos.
  * Es necesario que le indiquemos una **source_ami** ya que lo que hará **Packer** será copiar una ami base de referencia y en esta copia aplicar los cambios que hayamos especifado.
  * También es necesario indicar el **instance_type** ya que **Packer** para que pueda crear la imagen customizada primero tiene que lanzar un instancia y en esa instancia aplicar todas las configuraciones que hayamos espcificado, luego destruirá esta instancia y generará la imagen.
  * El **ssh_unsername** es para que **Packer** al momento de crear la instancia se pueda conectar a esta, es te caso es *"ubuntu"* ya que estamos usando la ami de un S.O. ubuntu y estos en **AWS** cuentan con el usuari ubuntu para poder conectarse.

*  **provisioners:**
   *  Usaremos dos tipos de provisioners:  
      *  shell: Eue nos permite ejecutar comandos de shell, en el cual le pasaremos un fichero .sh el cual contiene la instalación de apache2 y php además de una pequeña configuración.
      *  file: El cual nos permite tranferir ficheros de la máquina host al host remoto donde se lanzará instancia, en este caso en concreto le estamos pasando un fichero de nombre *"index.php"* qu contiene un función que muestra información sobre el módulo php.

***Cabe resaltar que primero tranferimos el fichero index.php a /tmp/ ya que el provisioner file no cuenta con permisos de root ni está en el grupo de sudoers y por lo tanto no tiene persmiso de tranferir directamente el fichero a /vaar/www/html/. Entonces lo que hemos hecho es primero pasarlo /tmp/ dónde todo el mundo tiene permisos de todo y luego con comandos de shell lo copiamos a /var/www/html***

<a name="id2"></a>
## 2. Vagrant Box

**install.sh:**
```
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
```

**image.json:**

```
{
    "builder": [
        {
            "type": "virtualbox",
            "source_partM": "ubuntu.box",
            "ssh_username": "ubuntu",
            "ssh_password": "ubuntu",
            "shutdown_command": "echo 'packer' | sudo -S shutdown -P now"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "install.sh"
        }
    ],
    "post-processor": ["vagrant"]
}
```

https://mohsensy.github.io/sysadmin/2018/07/24/vagrant-packer-tutorial.html 

Ubuntu-18.04/packer_cache/
Ubuntu-18.04/output/*.box