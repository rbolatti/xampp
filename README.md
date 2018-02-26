Windows:
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux:
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp




Esta imagen está pensada para el desarrollo de PHP + MySQL


## Running the image:

Las paginas se alojan en /www y tiene un link simbolico, se debe montar esta carpeta

```
Windows
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp

```

Para ingresar a los sitios: [http://localhost/www](http://localhost/www)    
Pagina inicial de XAMPP: [http://localhost/](http://localhost/)



### ssh

El password por default es 'root'.

```
ssh root@localhost -p 2222
```


```
docker exec -ti http bash
```


### Cambiar configuracion 

En el directorio de my_apache_conf se encuentran los los archivos de configuración

```
Montar en:
Windows
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp

```

### Reiniciar servidor

Para aplicar cambios realizados, ejecutar
```
docker exec http /opt/lampp/lampp restart
```
