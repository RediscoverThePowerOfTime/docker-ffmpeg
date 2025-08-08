FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install FFmpeg, OpenSSH, ImageMagick, and dependencies
RUN apt-get update && \
    apt-get install -y \
        ffmpeg \
        openssh-server \
        imagemagick \
        bc \
        libmagickwand-dev \
    && mkdir /var/run/sshd \
    && echo 'root:railway' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && rm -rf /var/lib/apt/lists/*

# Copy and run the dependency installation script for verification
COPY install-deps.sh /tmp/install-deps.sh
RUN chmod +x /tmp/install-deps.sh && /tmp/install-deps.sh

# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
