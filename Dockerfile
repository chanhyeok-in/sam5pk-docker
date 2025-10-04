# Use a base image with Ubuntu, LXDE desktop, and VNC server
FROM dorowu/ubuntu-desktop-lxde-vnc

# Install dosbox
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg wget && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get install -y dosbox && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for the game data
RUN mkdir -p /dos

# Copy the disk image into the container
COPY ./image.img /dos/image.img

# Add the dosbox configuration file to automatically run the game
# This file should be in the same directory as the Dockerfile
COPY dosbox.conf /root/.dosbox/dosbox.conf

# Add a desktop shortcut for convenience
# This file should be in the same directory as the Dockerfile
COPY Sam5.desktop /root/Desktop/Sam5.desktop
RUN chmod +x /root/Desktop/Sam5.desktop

# The base image already exposes 5900 for VNC and starts the server.
# Default VNC password is 'vncpassword'.
# You can change it by setting the VNC_PASSWORD environment variable in Render.
