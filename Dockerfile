FROM ubuntu:focal

LABEL org.opencontainers.image.authors="benjamin.c.burns@gmail.com"

RUN apt-get update && apt-get install -y python2 python2-dev iptables dnsmasq uml-utilities net-tools build-essential curl && apt-get clean

COPY docker-image-config/docker-startup.sh switchedrelay.py limiter.py requirements.txt /opt/v86/
COPY docker-image-config/dnsmasq/interface docker-image-config/dnsmasq/dhcp /etc/dnsmasq.d/
COPY public /opt/v86

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python2 get-pip.py && rm get-pip.py
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && rm install.sh && nvm install 16

WORKDIR /opt/v86/

RUN pip2 install -r /opt/v86/requirements.txt
RUN npm install --global http-server

EXPOSE 80
EXPOSE 9134

CMD /opt/v86/docker-startup.sh


