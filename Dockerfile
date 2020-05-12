FROM jerev/docker-php-apache-v8js:latest

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        fontconfig \
        git-core \
        libfontconfig1-dev \
        libfreetype6-dev \
        libssl-dev \
        libx11-dev \
        libxext-dev \
        libxrender-dev \
        openssl \
        xfonts-75dpi \
        xvfb && \
       apt-get purge -y --auto-remove && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# install phantom js
RUN mkdir /tmp/phantomjs && \
    curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | tar -xj --strip-components=1 -C /tmp/phantomjs && \
    mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

# install wkhtmltox
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.jessie_amd64.deb && \
    dpkg -i wkhtmltox_0.12.5-1.jessie_amd64.deb && \
    rm wkhtmltox_0.12.5-1.jessie_amd64.deb
