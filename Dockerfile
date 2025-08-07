FROM ubuntu:22.04

# Install FFmpeg and OpenSSH
RUN apt-get update && \
    apt-get install -y ffmpeg openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:railway' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
