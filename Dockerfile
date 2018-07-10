FROM jerev/docker-php-apache-v8js

EXPOSE 80

# the default image has duplicate entries
RUN echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://httpredir.debian.org/debian jessie-updates main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org jessie/updates main" >> /etc/apt/sources.list && \
    echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    libxrender-dev \
    gdebi

# install phantom js
RUN mkdir /tmp/phantomjs && \
    curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | tar -xj --strip-components=1 -C /tmp/phantomjs && \
    mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

#RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb && \
#    gdebi --n wkhtmltox-0.12.2.1_linux-jessie-amd64.deb && \
#    rm wkhtmltox-0.12.2.1_linux-jessie-amd64.deb

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    tar vxf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    cp wkhtmltox/bin/wk* /usr/local/bin/

# do a little cleanup
RUN apt-get remove -y --purge software-properties-common build-essential \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
