FROM ubuntu:16.04

RUN apt update
RUN apt upgrade --yes
RUN apt install --yes git
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -s /bin/bash builder && \
    echo 'builder:password' | chpasswd

RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER builder
WORKDIR /home/builder
RUN git clone https://github.com/webosose/build-webos.git
WORKDIR /home/builder/build-webos
RUN scripts/prerequisites.sh
RUN ./mcf -p 0 -b 0 raspberrypi3
RUN make webos-image || rm -rf ~/.node-gyp/ && make webos-image
