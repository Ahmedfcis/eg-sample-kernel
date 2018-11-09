FROM ubuntu
LABEL Name=eg-sample-kernel Version=0.0.1
RUN apt-get -y update && apt-get install -y gcc gcc-multilib build-essential xorriso grub-pc-bin
RUN mkdir /kernel
WORKDIR /kernel
CMD make clean && make in-docker-all