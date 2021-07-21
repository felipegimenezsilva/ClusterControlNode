FROM debian

RUN apt-get update
RUN apt-get install -y openssh-server openssh-client
RUN sed -i 's|^PermitRootLogin.*|PermitRootLogin yes|g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN ssh-keygen -f /root/.ssh/id_rsa -P -N
RUN echo "root:root_pass" | chpasswd
RUN service ssh start
