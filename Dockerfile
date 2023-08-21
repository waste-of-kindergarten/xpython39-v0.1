From ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
COPY sources.list /etc/apt/sources.list
COPY python /home/python
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    libffi-dev \
    vim \
    net-tools \
    openssh-server 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'root:python39' | chpasswd
WORKDIR /home/python
RUN ./configure --enable-optimizations
RUN make && make install 
ENV PATH="/usr/local/bin:$PATH"
RUN rm -rf /home/python
CMD service ssh restart && /bin/bash

