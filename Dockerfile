FROM ubuntu:22.04

# Install QEMU + noVNC
RUN apt-get update && apt-get install -y \
    qemu qemu-kvm libvirt-daemon-system libvirt-clients \
    bridge-utils virt-manager \
    novnc websockify supervisor wget curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /vm

# Copy config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Railway exposes a single $PORT - we map noVNC there
ENV PORT=8080

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
