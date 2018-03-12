# Based on work from Knut Ahlers (knut@ahlers.me, https://github.com/luzifer-docker/sftp-share)
# and Martin Honermeyer (https://github.com/djmaze). All credits to them.

FROM debian:stable
LABEL "maintainer" "Juan Pedro Pérez <jp.perez.alcantara@gmail.com>"

ENV USER_UID 1000
ENV USER_GID 1000
ENV AUTHORIZEDKEYS ""

RUN apt-get update
RUN apt-get install -y openssh-server rssh
RUN rm -f /etc/ssh/ssh_host_*
RUN rm -rf /var/lib/apt/lists/*

ADD Assets/start.sh /usr/local/bin/start.sh

VOLUME /data
EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start.sh"]
