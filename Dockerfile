FROM ubuntu:18.04

RUN apt update
RUN apt upgrade --yes
RUN apt install --yes git
RUN git clone https://github.com/webosose/build-webos.git
WORKDIR /build-webos
RUN scripts/prerequisites.sh
RUN ./mcf -p 0 -b 0 raspberrypi3
RUN make webos-image || rm -rf ~/.node-gyp/ && make webos-image
