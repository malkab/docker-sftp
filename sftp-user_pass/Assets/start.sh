#!/bin/bash

if ( id ${USER} ); then

    echo "INFO: User ${USER} already exists"

else

    echo "INFO: User ${USER} does not exists, creating it"

    /usr/bin/ssh-keygen -A

    groupadd -g ${USER_GID} ${USER}

    ENC_PASS=$(perl -e 'print crypt($ARGV[0], "password")' ${PASS})

    useradd -d /data -M -p ${ENC_PASS} -u ${USER_UID} -g ${USER_GID} -s /usr/lib/openssh/sftp-server ${USER}

    chown ${USER}:${USER} /data

fi

sleep 5

exec /usr/sbin/sshd -D -e
