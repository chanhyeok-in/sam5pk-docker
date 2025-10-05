# Use a base image with Ubuntu, LXDE desktop, and VNC server
FROM dorowu/ubuntu-desktop-lxde-vnc

# Install dosbox
RUN rm -f /etc/apt/sources.list.d/google-chrome.list && \
    sed -i 's/mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/http:\/\/archive.ubuntu.com\/ubuntu/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y dosbox && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for the game data
RUN mkdir -p /dos

RUN mkdir -p /root/dosdrive

# Copy the game CD image files into the container
COPY ./SAM5.bin /dos/SAM5.bin
COPY ./SAM5.cue /dos/SAM5.cue
COPY ./sam5pk/win /dos/win

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

# Force rebuild 1