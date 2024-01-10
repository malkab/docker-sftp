#!/bin/bash

docker run -ti --rm \
    -p 2222:22 \
    --name sftp-user-pass-test \
    -e USER=theuser \
    -e PASS=thepass \
    -e USER_UID=1500 \
    -e USER_GID=1500 \
    malkab/sftp-user:latest
