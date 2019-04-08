FROM ubuntu
MAINTAINER SungYong EOM <bluei@blueiblog.com>

# 레포지트 업데이트
RUN apt-get update -y

# 타임존 셋팅
RUN apt-get install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# 기본 패키지 설치
RUN apt-get install -y gcc make telnet whois vim git gettext cron mysql-client iputils-ping net-tools wget curl net-tools 

# Python 설치
RUN apt-get install -y python3 python3-pip

# PHP 설치
RUN apt install -y php php-cli php-mysql php-pear php-mbstring php-curl php-gd php-imagick php-memcache php-xmlrpc php-geoip php-zmq
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm composer-setup.php
RUN mkdir /php

# 라이브러리 설치
RUN pip3 install flask beautifulsoup4 Pillow requests pandas selenium Image matplotlib OpenCV-Python tensorflow scikit-learn keras 

# PhantomJS 설치
RUN mkdir -p /root/src && cd /root/src
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar jxvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
RUN apt install -y fonts-nanum*
RUN rm -rf /root/src/*

# Install Jupytern notebook & javascript and css files
RUN pip3 install Jupyter
RUN pip3 install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user

# Install PHP7 Kernel
RUN curl -sS https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar -o /root/jupyter-php-installer.phar
RUN php /root/jupyter-php-installer.phar install
RUN rm /root/jupyter-php-installer.phar 

# RUN Notebook
CMD jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token=$PASSWORD --allow-root --notebook-dir=/notebook/

EXPOSE 8888
VOLUME ["/notebook"]
