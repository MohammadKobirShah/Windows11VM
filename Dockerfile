FROM ubuntu:22.04

# Install QEMU + KVM + noVNC stack
RUN apt-get update && apt-get install -y \
    qemu qemu-kvm libvirt-daemon-system libvirt-clients \
    bridge-utils virt-manager \
    novnc websockify supervisor wget curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Workspace
WORKDIR /vm

# Supervisor config
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose noVNC web access
EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
