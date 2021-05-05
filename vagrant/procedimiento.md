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
   3.2. [Interfaz Gráfica](#id3-2)  
   3.3. [Aprovisionamiento Ligero](#id3-3)  
   3.4. [Redirección de puertos](#id3-4)  
   3.5. [Configuración SSH](#id3-5)  
   3.6. [Configuración red prvada](#id3-6)  
   3.7. [Configuración red pública](#id3-7)  
   3.8. [Multimáquinas](#id3-8)  
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

El funcionamiento de **Vagrant** consiste en dividir la distribución de la aplicación en dos, el sistema operativo en un determinado formato y por otra lado distribuimos la configuración y modificaciones de este escenario en un fichero de texto plano, que viene a ser **Vagrantfile**, bueno pues la distribución de este sistema operativo, que es, entre otras cosas, la imagen del sistema operativo que queremos usar. 

Vagrant tiene su [comunidad](https://app.vagrantup.com/boxes/search) en la cual todo el mundo puede subir sus boxes y ahí es donde se pueden obtener las boxes o también podemos crear nuestra propia box con ayuda de otro software, por ejemplo **packer**.

<a name="id2-1"></a>
### 2.1. Añadir un box

Para añadir un box vagrant nos proporciona el subcomando ***"box"*** que a su vez tiene más subcomandos y entre ellos encotramos el subcomando ***"add"*** que es los que nos permite descargar el box que queramos:

```
$ vagrant box add [nombre del box] [opciones]
```

Como hemos dicho antes los boxes que **Vagrant** descarga, a no ser que se especifique que los queremos de una ruta local, se obtienen desde su página web de su [comunidad](https://app.vagrantup.com/boxes/search), y el nombre de estos boxes se rigen por: **username/boxname**

Ejemplo:

<img src="imagenes/parte_2/box_add.png"></a>  


***Hay que tener en cuenta que las imagenes que se suben a la comunidad de Vagrant no están verificados, por lo tanto es necesario que tengamos cuidado al momento de qué box descargar***

<a name="id2-2"></a>  
### 2.2. Lanzar un box

Para el arranque de un box que hayamos descargado anteriormente tenemos que usar el subcomando ***"init"*** dentro del subcomando de ***"box"***, esto lo que hará es crear un fichero **Vagrantfile** en el cual se encuentra la configuración base para poder hacer posteriormente ```vagrant up```, por lo tanto, tenemos que tener en cuenta que el uso de este fichero de configuración por tal de poder arrancar el box tiene que esta alojado en un directorio y en este directorio no pueden ir otros ficheros de configuración, en conclusión, por cado vox que queramos arrancar necesitaremos un directorio diferente, esto nos permite poder tener una mejor organización de los boxes que tengamos activos.

<img src="imagenes/parte_2/vagrant_init.png">  

Como podemos en la imagen, hemos hecho un ```vagrant init``` de un box llamado "ubuntu/trusty64" y automáticamente nos ha creado un fichero **Vagrantfile** en el cual especifica que al momento de hacer ```vagrant up``` se usará como box el box que hemos especificado.

<img src="imagenes/parte_2/vagrant_up.png">  

Al hacer el ```vagrant up``` podemos ver que se han hecho es importar el box que hemos espcificado, es decir hace una copia y sobre esta copia hacer una series de adaptaciones para que podamos utlilizar y acceder a la máquina, las adaptaciones que hace son:

* Conectarla en una red interna de virtual box que tiene acceso a internet mediante **NAT**
* Abrir el puerto 2222 (en caso de que esté en uso, usa otro puerto) de la máquina anfitriona por tal de poder hacer un redirección al puerto 22 de la máquina virtual y que nosotros podamos conectarnos por ssh.
* Hace una serie de comprobaciones
* Monta un directorio compartido
    
Todos estos pasos se hacen automáticamente.

<img src="imagenes/parte_2/vagrant_ssh.png">  

Y, como podemos ver, al hacer un simple ```vagrant ssh``` nos conectamos a la máquina lanzada y esta, por medio de NAT, puede accede al exterior y la máquina anfitriona puede contactarse con ella mediante comandos de vagrant sin ningún problema, esto lo que resuelve es tener que que levantar una máquina, instalar el sistema operativo, configurarlo, etc.

Una vez tengamos la máquina encendida podemos hacer un ```vagrant status``` para poder ver el estado de esta, este comando también nos proporciona información sobre qué comandos podemos utilizar para parar, suspender o reinicar la máquina.

<img src="imagenes/parte_2/vagrant_status.png">  

En caso de que ya no necesitemos este escenario, lo que podemos hacer es ```vagrant destroy```, que lo que hace es destruir la configuración que hayamos hecho en la máquna una vez iniciada.  

<img src="imagenes/parte_2/vagrant_destroy.png">  

<a name="id2-3"></a>  
### 2.3. Directorio Compartido

La gran mayoría de los boxes de **Vagrant** suelen crearse con un directorio compartido, es decir, un directorio que está sincronizado entre la máquina anfitriona y la máquina virtual, este directorio se suele encontrar en la ruta ```/vagrant``` de las máquinas virtuales.

Por lo tanto, lo que permite este directorio es compartir de un extremo a otro, todo tipo de archivos. 

<img src="imagenes/parte_2/shared_dir.png">

Al momento de compartir los archivos, **Vagrant** lo que hace es mappear el usuario y grupo activo del origen al usuario y grupo activoo del destino.

<img src="imagenes/parte_2/shared_dir_2.png">

<a name="id2-4"></a>
### 2.4. Reempaquetar un box

Al momento de descargar un box, **Vagrant** lo que en verdad hace es, en cuanto descarga el .box, lo descomprime y lo guarda en ~/.vagrant.d/boxes ya descomprimido que contiene:
* Un fichero .ovf que es de información
* La imagen 
* Un fichero de metadatos
* Un Vagrantfile que hace la configuración básica para que la máquina pueda arrancar
  
Por lo tanto en verdad nosotros no tenemos el .box, ahora bien, digamos que nosotros necesitamos el .box para poder transportarlo a una máquina que no tiene acceso a internet y, por lo tanto no, puede descargar de la página de **Vagrant Cloud** los boxes.

Vagrant tiene una opción llamada **repackage** que lo que hace es, a partir de los elementos del box, volver a crear el .box, entonces con esto podemos llevar este .box a cualquier lugar.

<img src="imagenes/parte_2/vagrant_repackage.png">  

Como podemos ver, para poder hacer el repackage necesitamos el nombre del box, el proveedor que utiliza y la versión que tiene.

<a name="id2-5"></a>
### 2.5. Eliminiación e instalación de una imagen local

En caso de que tengamos una imagen propia en local y queremos que **Vagrant** use esta en vez de alguna que esté en **Vagrant Cloud** lo que podemos hacer es indicarle el .box que queremos que use y especificarle un nombre:

<img src="imagenes/parte_2/vagrant_local_install.png">  

<a name="id2-6"></a>
### 2.6. Actualización de una imagen

**Vagrant** a través de **Vagrant Cloud** nos proporciona boxes los cuales con el tiempo se van actualizando.

Pero, ¿cómo podemos ver si el box que tenemos instalado necesita una actualización?, **Vagrant** proporciona una opción ```outdated``` la cual, con el argumento ```--global``` hace un chequeo de todos los boxes que tenemos instaladas y nos dice si necesitan actualizarse o no.

<img src="imagenes/parte_2/vagrant_outdated.png">  

Como podemos ver hay el box "ubuntu/trusty64" está actualizado, detecta que el box "diego-ubuntu/trusty64" no pertenece al catálogo de la comunidad de **Vagrant** y no tiene versión y por lo tanto no hay informaciíon, y, por último, detecta que hay una versión más nueva para el box "debian/jessie64" y por lo tanto necesita actualizarse.

Para actualizar un box lo que tenemos que hacer es crear hacer un ```vagrant init``` con lo cual nos creará un fichero Vagrantfile, tenemos que hacer un ```vagrant up --provider virtualbox``` y por último tenemos que hacer es un ```vagrant box update``` y entonces **Vagrant** se conectará a **Vagrant Cloud**, comprovará la versión descargada con la versión más nueva de la página, la descargará y la instalará.

<img src="imagenes/parte_2/vagrant_box_update.png">

***También podemos especificar el box que queremos actualizar con ```vagrant box update --box [boxname]```, esto nos permite actualizar el box desde cualquier lugar y sin necesidad de hacer un ```vagrant init``` y ```vagrant up```:***

<img src="imagenes/parte_2/vagrant_box_update_2.png">  

**Vagrant** no borrá la versión antigua por si se necesita volver a usar por cualquier motivo, pero este box ocupa espacio, entonces lo que podemo hacer es un ```vagrant prune``` para que borré las versiones antiguas y dejará solo la más actual.

<img src="imagenes/parte_2/vagrant_box_prune.png">

<a name="id3"></a>
## 3. Configuración Vagrantfile


<a name="id31"></a>
### 3.1. Configuración Simple
Hasta ahora solo hemos usado el **Vagrantfile** para indicarle qué box tiene que levantar, pero tenemos muchas más opciones como por ejemplo indicarle un nombre de hostname, la memória que puede usar, los cpus que puede usar, etc que suelen ser los primeros pasos al crear una máquina virtual.

Normalmente cada proveedor tiene sus valores determinados para estos casos y no hace falta configurar nada, pero en caso de queramos editar los valores podemos hacerlo.

En el caso de **virtualbox** ,que es el proveedor con el que estamos trabajando, tiene un listado en la página de [Vagrant](https://www.vagrantup.com/docs/providers/virtualbox/configuration) en la cual nos especifica que opciones podemos usar para configurar nuestro box.

```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "diego-ubuntu"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end
end
```

Como podemos ver en el **Vagrantfile**, le hemos especificado que al momento de levantar la máquina, tenga el hostname: "diego-ubuntu", que de estar parte se encargan las opciones de configuración de virtual machine de **Vagrant**, y también le hemos especificado al proveedor, que en este caso es **VirtualBox** que de memoria tenga 1024MB y que trabaje con 2 cpus.

Al momento de hacer ```vagrant up``` podemos ver que se han realizado los cambios que hemos especificado en el fichero **Vagrantfile**:

<img src="imagenes/parte_3/vagrant_simple_conf_2.png">

***En caso de hacer otros cambios más especificos se puede usar el comando ```vagrant reload``` para no tener que hacer un ```vagrant destroy``` y un ```vagrant up``` cada vez que queramos aplicar los cambios que hayamos hecho en el Vagrantfile.***

<a name="id32"></a>
### 3.2. Interfaz Gráfica
Vagrant también nos da la posibilidad de usar una interfaz gráfica que puede ser muy útil en algunos casos, por ejemplo, supongamos que estamos haciendo configuraciones con ssh y hacemos algo mal que no nos deja conectarnos por ssh a la máquina virtual, entonces no tenemos otra forma de conectarnos, aquí es cuando entra la interfaz gráfica que, siempre que tengamos al menos un usuario creado, podemos entrar sin problema.

Para hacer que la máquina, al levantarse, ejecute una interficie gráfica es muy sencillo:

```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "diego-ubuntu"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
    vb.gui = true
  end
end

```

y al hacer un ```vagrant up``` nos abre la interfaz gráfica:

<img src="imagenes/parte_3/punto2/vagrant_gui.png">

***Esto funcionará siempre y cuando el proveedor que se esté utilizando soporte la interfaz gráfica***

<a name="id33"></a>
### 3.3. Aprovisionamiento Ligero

Imaginemos que tenemos 10 máquinas lanzadas y las dos usan la misma imagen, lo que pasará es que por cada máquina creada habrá una imagen ocupando espacio en disco real del host anfitrión.

El aprovisionamiento ligero o *"thin provisioning"* consiste en que en lugar de clonar el disco que contiene la imagen de la máquina para cada una de ellas lo que hace es crear un fichero de imagen que almace unicamente las diferencias tiene respecto a la imagen inicial, por lo cual creamos un fichero de imagen mucho más pequeño y ya este fichero irá creciendo en el futuro conform hayan mas diferencias. 

Por lo tanto lo que nos permite este método es ahorrar mucho espacio en el disco real.

Este recueso depende de cada proveedor que lo soporte, en **VirtualBox** la opción que nos permite usar aprovisionamiento ligero es [linked_clone](https://www.vagrantup.com/docs/providers/virtualbox/configuration#linked-clones) 

```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "diego-ubuntu"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
    vb.linked_clone = true
  end
end
```

A hacer ```vagrant up``` podemos ver que se prepara para hacer el aprovisionamiento ligero:

<img src="imagenes/parte_3/punto3/vagrant_tp.png">

Al inspeccionar lo que se crea al arrancar la máquina podemos ver que en lugar de crear una imagen de nuevo lo que ha hecho es crear un directorio de Snapshot donde guarda el fichero de la imagen que unicamente contiene las diferencias con el fichero de imagen original:

<img src="imagenes/parte_3/punto3/vagrant_tp_2.png">

<a name="id34"></a>
### 3.4. Redirección de puertos

Vagrant por defecto ya hace redireccionamiento: 

* En un pricipio todas la máquinas virtuales están conectadas a una red interna de VirtualBox, a partir de aquí se le asigna a la máquina virtual una dirección ip dentro del segmento de la red privada y se le pone como gateway una dirección ip que VBox conecta al exterior y para que esta máquina virtual pueda acceder al exterior se hace un proceso de **Source NAT**.

* Por otra si queremos conectarnos desde el exterior (teniendo en cuenta también el host anfitrión) a la máquina virtual lo que hace **Vagrant** por defecto es redirigir por el puerto 2222 (en caso que esté en uso se usa otro puerto) de la máquina anfitriona al purto 22 de la máquina virtual.

Pero si nosotros queremos redirigir manualmente un puerto para poder acceder a otro servicio, a apache por ejemplo, ¿Cómo se haría?

Para ello vagrant tiene la opción **vm.network**, que entre cosas, nos permite hacer el port forwarding:

```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "diego-ubuntu"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "2"
  end
end
```

Aquí le indicamos que desde el puerto 8080 del host anfitrión (**host**) se redirigirá al puerto 80 de la máquina virtual (**guest**).

Lo que queda hacer es un ```vagrant up```:

<img src="imagenes/parte_3/punto4/vagrant_port_forwarding.png">

Aquí podemos como, en los pasos que hace vagrant para preparar la máquina, hace el redireccionamiento de puertos.

Para poder demostrar el funcionamiento he instalado apache2 para ubuntu y he editado el **index.html** para que aparezca "Prueba Redireccionamiento de Puertos":

<img src="imagenes/parte_3/punto4/vagrant_port_forwarding_2.png">

Un comando muy útil para saber que puertos han sido redireccionados es: ```vagrant port```:

<img src="imagenes/parte_3/punto4/vagrant_port.png">

