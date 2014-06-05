
FROM ubuntu

MAINTAINER Anton Dorofieiev <gotterdemarung@gmail.com>

# repository
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install MySQL client
RUN apt-get install -y \
  mysql-client apache2 \
  php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-gd php5-dev php5-curl php-apc php5-cli php5-json \
  git \
  ssh wget

# sendmail
# RUN apt-get install -y sendmail

# Directory for ssh
RUN mkdir /var/run/sshd

# Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

# Adding files
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD phabricator.conf /etc/apache2/sites-available/phabricator.conf
ADD ./startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

# Configuring Apache
RUN ln -s /etc/apache2/sites-available/phabricator.conf /etc/apache2/sites-enabled/phabricator.conf
RUN rm -f /etc/apache2/sites-enabled/000-default
RUN a2enmod rewrite

# Configuring system
RUN ulimit -c 10000

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

# Exposing ports
EXPOSE 3306 80 22

# Exposing volumes
# TODO

CMD ["/usr/bin/supervisord"] 
