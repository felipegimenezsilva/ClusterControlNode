FROM debian

COPY authorized_keys /root/.ssh/authorized_keys
RUN apt-get update
RUN apt-get install -y openssh-server openssh-client
RUN sed -i 's|^PermitRootLogin.*|PermitRootLogin yes|g' /etc/ssh/sshd_config

RUN service ssh start
