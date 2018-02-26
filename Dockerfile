FROM debian:jessie
MAINTAINER Renzo Bolatti

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --fix-missing

# curl es necesario para descargar el instalador xampp, net-tools proporciona el
RUN apt-get -y install curl net-tools

RUN curl -o xampp-linux-installer.run "https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.21/xampp-linux-x64-5.6.21-0-installer.run?from_af=true"
RUN chmod +x xampp-linux-installer.run
RUN bash -c './xampp-linux-installer.run'
RUN ln -sf /opt/lampp/lampp /usr/bin/lampp

# Habilitar la interfaz web de XAMPP (eliminar comprobaciones de seguridad)
RUN sed -i.bak s'/Require local/Require all granted/g' /opt/lampp/etc/extra/httpd-xampp.conf

# Archivos de configuración
RUN mkdir /opt/lampp/apache2/conf.d && \
    echo "IncludeOptional /opt/lampp/apache2/conf.d/*.conf" >> /opt/lampp/etc/httpd.conf

# Crear directorio /www , crear enlace simbolico al apache (/opt/lammp/htdocs/)
# Esto esta bueno para no romper nada cambiando permisos
RUN mkdir /www
RUN ln -s /www /opt/lampp/htdocs/

# SSH server
RUN apt-get install -y -q supervisor openssh-server
RUN mkdir -p /var/run/sshd

# Configurar e iniciar ssh server
RUN echo "[program:openssh-server]" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "numprocs=1" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "autostart=true" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf
RUN echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord-openssh-server.conf

# Permitir login con root
# password root: root
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Cambiar el passord de root
RUN sed -ri 's/root\:\*/root\:\$1\$xampp\$5\/7SXMYAMmS68bAy94B5f\./g' /etc/shadow

# Algunas cosas utiles
RUN apt-get -y install nano vim less --no-install-recommends

RUN apt-get clean
VOLUME [ "/var/log/mysql/", "/var/log/apache2/", "/www" ]

EXPOSE 3306
EXPOSE 22
EXPOSE 80

# Script de inicio
RUN echo '/opt/lampp/lampp start' >> /startup.sh
RUN echo '/usr/bin/supervisord -n' >> /startup.sh

CMD ["sh", "/startup.sh"]
