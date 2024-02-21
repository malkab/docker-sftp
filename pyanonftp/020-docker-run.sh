#!/bin/bash

docker run -ti --rm \
    --name pyanonftp-test \
    -p 2221:21 \
    -p 40000-40009:40000-40009 \
    malkab/pyanonftp:latest
