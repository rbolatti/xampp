Windows
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp




This image is intended for PHP+MySQL development. For convenience, it also runs SSH server to connect to. __Both MySQL and phpmyadmin use default XAMPP password__.


## Running the image:

This image uses /www directory for your page files, so you need to mount it.

```
Windows
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp

```
The command above will expose the SSH server on port 41061 and HTTP server on port 41062.    
Feel free to use your own name for the container...

To connect to your web page, visit this URL: [http://localhost/www](http://localhost/www)    
And to open up the XAMPP interface: [http://localhost/](http://localhost/)

## additional How tos

### ssh connection

default SSH password is 'root'.

```
ssh root@localhost -p 2222
```

### get a shell terminal inside your container

```
docker exec -ti http bash
```

### use binaries provided by XAMPP

Inside docker container:
```
export PATH=/opt/lampp/bin:$PATH
```
You can then use `mysql` and friends installed in `/opt/lampp/bin` in your current bash session. If you want this to persist, you need to add it to your user or system-wide `.bashrc` (inside container).

### Use your own configuration

In your home directory, create a `my_apache_conf` directory in which you place any number of apache configuration directive files. As soon as they end up with the .conf extension, they will be used by the image.

```
Windows
docker run --name http -p 2222:22 -p 80:80 -d -v /c/www:/www rbolatti/xampp
Linux
docker run --name http -p 2222:22 -p 80:80 -d -v ~/www:/www rbolatti/xampp

```

### Restart the server

Once you have modified configuration for example
```
docker exec http /opt/lampp/lampp restart
```
