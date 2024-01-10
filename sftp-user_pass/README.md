# Docker Image for a SFTP Server with user / password Log In

This Docker image is based on the work of __Knut Ahlers__ (knut@ahlers.me, https://github.com/luzifer-docker/sftp-share) and Martin Honermeyer (https://github.com/djmaze). All credits to them. Just made some extra configurations and adaptations.


# What does this Docker image contains?

A very basic image with a single user SFTP server and data storage, accesible by user / password, intended to act as an entry point of data to other container's volumes. For example, this is often deployed in tandem with [Docker-GeoServer](https://github.com/malkab/docker-geoserver) to allow users to log in with WinSCP and load data to the server to be later served with GeoServer. GeoServer just a Compose volume shared with this service.


# Usage Pattern

Configure the service with the following env variables:

- __USER:__ the user name, used to log in;
- __PASS:__ the login password;
- __USER_UID:__ most of the times it is important to map the user's UID and GID to specific settings, to map users ID in another service (e.g. GeoServer). It defaults to 1000;
- __USER_GID:__ user group ID. Defaults to 1000.

To start the container interactively for testing purposes:

```Shell
docker run -ti --rm \
    -p 2222:22 \
    -e USER=theuser \
    -e PASS=thepass \
    -e USER_UID=1500 \
    -e USER_GID=1600 \
    malkab/sftp-user:latest
```

The SFTP stores data inside **/data**, so link other volumes to this root to attach volumes used by other containers.
