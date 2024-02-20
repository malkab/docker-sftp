#!/bin/bash

docker run -ti --rm \
    --name vsftpd-user_pass-test \
    -p 2221:21 \
    -p 2220:20 \
    -p 40000-40100:40000-40100 \
    -v $(pwd)/ftp-data:/home/user \
    malkab/vsftpd-user_pass:latest

	# --env FTP_USER=user \
	# --env FTP_PASS=123 \
