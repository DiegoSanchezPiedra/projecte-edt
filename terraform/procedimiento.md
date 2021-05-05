# Procedimiento

## Índice  
1. [Instalación](#id1)  
   1.1. [Vagrant](#id1-1)  
   1.2. [VirtualBox](#id1-2)  
2. [Boxes](#id2)  
   2.1. [Añadir un box](#id2-1)  
   2.2. [Lanzar un box](#id2-2)  
   2.3. [Directorio Sincronizado](#id2-3)  
   2.4. [Reempaquetar un box](#id2-4)  
   2.5. [Eliminiación e instalación de una imagen local](#id2-5)  
   2.6. [Actualización de una imagen](#id2-6)  
3. [configuración Vagrantfile](#id3)  
   3.1. [Configuración Simple](#id3-1)  
   3.2. [Configuración hardware](#id3-2)  
   3.3. [Interfaz Gráfica](#id3-3)  
   3.4. [Aprovisionamiento Ligero](#id3-4)  
   3.5. [Redirección de puertos](#id3-5)  
   3.6. [Configuración SSH](#id3-6)
   3.7. [Configuración red prvada](#id3-7)  
   3.8. [Configuración red pública](#id3-8)
   3.9. [Multimáquinas](#id3-9)  
4. [Vagrant con AWS][#id4]  

<a name="id1"></a>
## 1. Instalación

Como se ha comentado anteriormente, para usar **Vagrant** se necesita tener, al menos, un sistema de virtualización, en estos ejercicios se utilizará el sistema de vitualización inicial con el cual se desarrolló **Vagrant** que es **VirtualBox** y que además es donde se ofrece más funcionalidad.

<a name="id1-1"></a>
### 1.1. Vagrant

La instalación de vagrant es muy secilla, en el caso de sistemas operativos como **Ubuntu**, **Debian**, **CentOS**, **Fedora**, **Amazon Linux** o **Homebrew** lo único que tenemos que hacer es:
* Añadir el repositorio
* Instalar Vagrant

```
$ sudo dnf install -y dnf-plugins-core
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
$ sudo dnf -y install vagrant
```

<a name="id1-2"></a>
### 1.2. VirtualBox

* Para la instalación de VirtualBox, tenemos que ir a la página web de [VirtualBox](https://www.virtualbox.org/wiki/Downloads), aquí encontraremos las diferentes opciones de descarga dependiendo del sistema operativo y la distribución.

* En este caso lo instalaremos para un Fedora 32.

```
$ wget https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1-6.1.22_144080_fedora32-1.x86_64.rpm

$ sudo rpm -i VirtualBox-6.1-6.1.22_144080_fedora32-1.x86_64.rpm
```

* Nos añadimos al grupo de virtualbox por tal de poder ejecutarlo correctamente:

```
$ sudo usermod -a -G vboxusers ${USER}
```
  
Una vez hecha la instalación y los demás pasos tendremos que ejecutar el setup que prorporciona VirtualBox:

```
$ sudo /usr/lib/virtualbox/vboxdrv.sh setup
```


<a name="id2"></a>
## 2. Boxes