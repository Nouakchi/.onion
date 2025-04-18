FROM debian:bullseye

RUN apt update && \
    apt install -y tor nginx openssh-server && \
    apt clean

# Add HTML file
COPY index.html /var/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
COPY sshd_config /etc/ssh/sshd_config
COPY torrc /etc/tor/torrc
COPY start.sh /start.sh

# Set up SSH
RUN mkdir /var/run/sshd && \
    useradd -m toruser && \
    echo "toruser:torpassword" | chpasswd

# Tor hidden service directory permissions
RUN mkdir -p /var/lib/tor/hidden_service && \
    chown -R debian-tor:debian-tor /var/lib/tor/hidden_service && \
    chmod 700 /var/lib/tor/hidden_service

EXPOSE 80 4242

CMD ["/bin/bash", "/start.sh"]