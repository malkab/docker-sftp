#!/bin/bash

AUTHORIZED_KEYS_FILE=/authorized_keys

if ( id datauser ); then
    echo "INFO: User datauser already exists"
else
    echo "INFO: User datauser does not exists, creating it"

    /usr/bin/ssh-keygen -A

    groupadd -g ${USER_GID} datausergroup

    useradd -d /data -M \
        -u ${USER_UID} -g ${USER_GID} \
        -s /usr/bin/rssh datauser

    chown datauser:datausergroup /data
    chmod 0700 /data

    echo "AuthorizedKeysFile $AUTHORIZED_KEYS_FILE" >>/etc/ssh/sshd_config
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
    
    touch $AUTHORIZED_KEYS_FILE
    chown datauser $AUTHORIZED_KEYS_FILE
    chmod 0600 $AUTHORIZED_KEYS_FILE

    mkdir /var/run/sshd
    chmod 0755 /var/run/sshd

    echo "allowscp" >> /etc/rssh.conf
    echo "allowsftp" >> /etc/rssh.conf

    # Copy authorized keys from ENV variable
    IFS='#' read -ra ADDR <<< "$AUTHORIZEDKEYS"

    for i in "${ADDR[@]}"; do
        echo $i >> $AUTHORIZED_KEYS_FILE
    done

    unset IFS
fi

# Run sshd on container start
exec /usr/sbin/sshd -D -e
