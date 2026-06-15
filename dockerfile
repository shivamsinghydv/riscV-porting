FROM --platform=linux/riscv64 debian:trixie


RUN apt-get update && \
    apt-get install -y sed dpkg-dev && \
    if [ -f /etc/apt/sources.list.d/debian.sources ]; then \
        sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources; \
    fi && \
    sed -i 'p;s/^deb /deb-src /' /etc/apt/sources.list || true


RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    devscripts \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
