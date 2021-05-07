# Procedimiento

## Índice
1. [Instalación](#id1)  
2. [Providers](#id2)  
   1.1. [AWS Provider](#id2-1)  
3. [Configuración Simple](#id3)  
   3.1. [Recurso](#id3-1)  
   3.2. [State File](#id3-2)  
   3.3. [Varibales](#id3-3)  
   3.4. [Outputs](#id3-4)  
   3.5. [Data Sources](#id3-5)  
   3.6. [Templates](#id3-6)  
4. [Configuración Compleja](#id4)  
   4.1. [Múltiples Recursos](#id4-1)  
   4.2. [Reutilizar Plantilla](#id4-2)  
   4.3. [Relacionar Recursos](#id4-3)  
5. [Ejercicio Final](#id5)  

<a name="id1"></a>
### 1. Instalación  

La instalación de Terraform un muy sencilla, para poder instalarlo tenemos que descargar un archivo comprimdo que contiene el binario de **Terraform** de la la página de [Terraform](https://www.terraform.io/downloads.html), ahí encontraremos las diferentes opciones para los diferentes sistemas operativos y distribuciones disponibles como MacOS,FreeBSD, Linux, OpenBSD, Solaris, Windows, también encontramos opciones a la arquitectura, ya sea 32-bits, 64-bits, Arm o Arm64.

<img src="imagenes/parte_1/terraform_install_1.png">  

Para este caso descargamos el comprimido .zip para una máquina de distribución Linux de 64-bits.

Lo descomprimimos y lo vemos a al directorio /usr/bin/ para poder ejecutarlo desde cualquier lugar:

<img src="imagenes/parte_1/terraform_install_2.png">  

y listo, ya estaría instalado y listo para usarse.

<a name="id2"></a>
### 2. Providers

Los providers son ***"plugins"*** que permiten a **Terraform** interactuar con sistemas remotos, la primera configuracón de **Terraform** tiene que ser la declaración de que providers vamos a usar, así él puede instalarlos y usar los tipos de recursos (***resource types***) y fuente de datos (***data sources***).

* **resource types:**  
  Son los elementos más importantes al momento de configurar la infraestructura, ya que estos elementos describen uno o mas objetos como redes virtuales, instancias, etc.

```
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}
```

* **data sources:**  
  Son fuentes de datos que nos proporciona el provider que no están incluidas en Terraform, con estas fuentes de datos podemos buscar y crear recursos referenciando a esas fuentes de datos.

```
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```
  
<a name="id21"></a>
## 2.1. AWS Provider

Para hacer la integración de **Terraform** con **AWS** lo primero que tenemos que hacer es crear una cuenta ***IAM*** en **AWS** por tal que **Terraform** pueda crear recursos.

Tabíen tendremos que instalar el AWS CLI (command line interface) por tal de poder gestionar nuestras credenciales quet tenemos en **AWS** que nos permitirán gestionar los recursos desde **Terraform**.

* **Instalación AWS CLI**:
  La instalación es muy secilla y está descrita paso a paso y con diferenes alternativas con la [página de AWS](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html), en este caso instalaremos la versión de **AWS CLI** [para Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

  * Descargamos el archivo comprimido que contiene, entre otras cosas, un script para la instalación de **AWS CLI**:
  
  ```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  ```

  * Los descomprimimos:
  
  ```
    unzip awscliv2.zip
  ```

  * Y ejecutamos el script de instalación:
  
  ```
    sudo ./aws/install
  ```
  
  Y listo ya tenemos el CLI de **AWS** instalado, lo podemos comprovar haciendo ```aws --version```:

Una vez instalado el CLI de **AWS** necesitamos conseguir la credenciales y el ID-Account de **AWS**, los cuales se encuentran en:

<img src="imagenes/parte_2/punto1/terraform_aws_credentials_1.png">  

<img src="imagenes/parte_2/punto1/terraform_aws_credentials_2.png">  

***Al momento de crear tanto las credencias lo recomendable es guardar las estas en un lugar seguro.***

Para poder usar el CLI de **AWS** como autenticador de AWS tenemos ejecutar la orde ```aws configure```, seguidamente nos pedirá crear insertar tanto la Access Key ID y la Secret Key, luego nos pedirá insertar la region y el output (que nos obligatorios).

Una vez hecho este paso las credenciales se guardarán en el fichero ```~/.aws/credentials``` con un **profile** que es con las cuales se identificarán estas claves en el sistema operativo.

<img src="imagenes/parte_2/punto1/terraform_aws_credentials_3.pn">
<a name="id3"></a>
