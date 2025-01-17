FROM debian:stable-slim


ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

EXPOSE 88

RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y \
unzip \
wget \
nano \
tzdata && \
ln -fs /usr/share/zoneinfo/Australia/Perth /etc/localtime && \
dpkg-reconfigure --frontend noninteractive tzdata && \
apt-get autoremove -y && \


wget -o - https://www.hls-proxy.com/downloads/7.5.8/hls-proxy-7.5.8.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \
chmod +x /opt/hlsp/hls-proxy && \
/opt/hlsp/hls-proxy -address 0.0.0.0 -port 88 -save -quit

CMD ["/opt/hlsp/hls-proxy"]
