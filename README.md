# R para Android con Userland
## Descripción

Pequeño tutórial de como instalar una distribución Linux sin necesidad de ser Root, además de poder ejecutar comandos de R 
de una manera sencilla y sin complicaciones.

## Objetivo 

Trabajar con un sistema operativo Linux de manera muy minimalista, esto para equipos con muy pocos recursos,
pero además el atractivo que se puede replicar el los teléfonos celulares con Android.

## Pre-requisitos
[*] [Se recomienda tener la aplicación de Userland instalada en el celular.](https://play.google.com/store/apps/details?id=tech.ula)

[*] [Se recomienda tener conocimientos básicos de los comandos de **Bash**.](https://es.wikibooks.org/wiki/El_Manual_de_BASH_Scripting_B%C3%A1sico_para_Principiantes/Comandos_b%C3%A1sicos_de_una_shell)

[*] Se recomienda tener **4Gb** de almacenamiento interno. y/o externo (sdcard)

[*] Se recomienda tener **2Gb** de memoria RAM.

[*] Se recomienda tener al menos una hora de su tiempo.

## Instalación

[*] Si se encuentra leyendo el PDF en el celular solo necesita tocar el texto **Userland**
que es un hipervínculo que lo llevara a la google play para instalar la app, si esta
leyendo el PDF en su computadora no sera necesario darle clic; De igual manera  si toca la
palabra **Bash** lo mandara a una pagina que muestra una lista de comando de Linux.

[*] Los desarrolladores dejaron de darle soporte a Userland para IOS
por lo cual si quiere realizar este ejercicio en un IPhone puede que no 
funcione y además la app ya no esta disponible en medios oficiales.

Una vez instalada la app hay que seleccionar Kali (el que tiene un dibujo de dragón)

Saldrá un pequeño menú solicitando 

	1. **Nombre de usuario**
	2. **Contraseña**
	3. **Contraseña VNC**

Se recomienda un nombre de usuario muy corto, al iguales que las contraseñas 
sean cortas y fácil de recordar; Para este ejemplo se uso

        1. Nombre de usuario: **demo**
        2. Contraseña: **demo01**
        3. Contraseña VNC: **demo01**

***Solo es una sugerencia***

Una vez concluido este paso comenzara a descargar e instalar los archivos
necesarios para ejecutar el sistema operativo(puede que tome algo de tiempo).

Posteriormente saldrá una pantalla negra solicitando la contraseña
**OJO** *escriba la contraseña despacio ya que no mostrara nada cuando teclee
la contraseña* esto para evitar errores y frustraciones futuras.

Una vez que haya ingresado sera necesario ejecutar 

~~~~bash
	sudo apt update
~~~~

y después

~~~~bash
	sudo apt upgrade
~~~~

**Si no realiza estos dos pasos no podrá descargar ningún programa después.**

Una vez terminada la actualización deberá descargar los *scripts*

estos se encuentran en github

~~~~bash
	sudo apt install git
	git clone https://github.com/graycristoph/R_Userland_Android.git
	cd R_Userland_Android
~~~~

Una vez termina la descarga de los archivos solo deberá ejecutar los siguientes 
comandos:
 
~~~~bash
	sudo chmod +x sys

~~~~

y después:

~~~~bash
	. sys 
~~~~

o 

~~~~bash
	./sys
~~~~
**Nota**: no omitir el punto, es importante, el
script esta pensado tanto para ejecutarse en 
__Linux aarch64__, __Linux armv71__, __Linux armv81__ y 
__Linux x86_64__ sin ningún problema.

**A lo largo del proceso le pedirá que de permiso para la descarga e instalación de R**
**y sus packages necesarios para poder trabajar**

Los archivos creados en la terminal de Linux no podrá visualizarlos en la terminal ya que esta no cuenta con una interfaz,
la alternativa es copiar los archivos creados en la siguiente ruta

**archivos en la memoria interna**
	cp myarchivo /storage/internal
**archivos en la memoria externa**
	cp myarchivo /storage/sdcard

Para poder ver los archivos copiados en la memoria interna, la ruta es:

MemoriaInterna/Android/data/tech.ula/files/storage 

Para poder ver los archivos copiados en la memoria externa, la ruta es:

SdCard/Android/data/tech.ula/files/storage 

