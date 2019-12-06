FROM ubuntu:18.04
LABEL maintainer="veggiebenz@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends supervisor \
        openssh-server pwgen sudo vim-tiny nano \
        net-tools \
        lxde x11vnc x11vnc-data xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        fonts-wqy-microhei \
        language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        nginx \
        python-dev python3-dev build-essential \
        ffmpeg \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD docker-ubuntu-novnc/web /web/
ADD docker-ubuntu-novnc/get-pip.py /get-pip.py
RUN python get-pip.py
RUN python3 get-pip.py
RUN /usr/local/bin/pip3 install -r /web/requirements.txt
RUN pip3 install tensorflow-gpu pybullet gym jupyter matplotlib pandas

ADD docker-ubuntu-novnc/noVNC /noVNC/
ADD docker-ubuntu-novnc/nginx.conf /etc/nginx/sites-enabled/default
ADD docker-ubuntu-novnc/startup.sh /
ADD docker-ubuntu-novnc/supervisord.conf /etc/supervisor/conf.d/
ADD docker-ubuntu-novnc/doro-lxde-wallpapers /usr/share/doro-lxde-wallpapers/

EXPOSE 6080 11311 9090 5900
WORKDIR /root
ENTRYPOINT ["/startup.sh"]