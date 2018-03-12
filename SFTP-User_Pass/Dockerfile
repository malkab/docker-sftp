# Based on work from Knut Ahlers (knut@ahlers.me, https://github.com/luzifer-docker/sftp-share)
# and Martin Honermeyer (https://github.com/djmaze). All credits to them.

FROM debian:stable
LABEL "maintainer" "Juan Pedro Pérez <jp.perez.alcantara@gmail.com>"

ENV USER share
ENV PASS changeme
ENV USER_UID 1000
ENV USER_GID 1000

RUN apt-get update && \
    apt-get install -y openssh-server mcrypt && \
    mkdir /var/run/sshd && chmod 0755 /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

ADD Assets/start.sh /usr/local/bin/start.sh
ADD Assets/sshd_config /etc/ssh/sshd_config

VOLUME /data
EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start.sh"]
