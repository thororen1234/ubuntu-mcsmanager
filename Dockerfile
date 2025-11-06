FROM node:lts-trixie-slim

ENV DEBIAN_FRONTEND=noninteractive
USER root

RUN sed -i 's/^Components: main$/& contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    iptables \
    uidmap \
    sudo \
    git \
    tar \
    iproute2 \
    socat \
    nano \
    tcpdump \
    net-tools \
    openjdk-*-jre \
    cron \
    ssh \
    7zip-rar \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -m 0755 -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian trixie stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -qO- https://raw.githubusercontent.com/thororen1234/MCSManager/master/setup.sh | bash

EXPOSE 23333 24444 2375 2376

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
