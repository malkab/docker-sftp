# Docker Images for SFTP Servers

This Docker images are based on the work of __[Knut Ahlers](https://github.com/luzifer-docker/sftp-share)__ and __[Martin Honermeyer](https://github.com/djmaze)__. All credits to them. Just made some extra configurations and adaptations.

This service comes in two flavors:

- __SFTP-User_Pass__ configures a SFTP service with user / password log in;
- __SFTP-Keys__ configures a SFTP service with keys log in.

Please read their respective README for details.


# A Note for Deploying in SWARM Mode

Just exposing the SFTP port in Compose as 2222:22, for example, don't work in SWARM mode. The port is unreachable for whatever the reason.

Defining the port in **docker-compose.yaml** this way made it work:

```yaml
version: '3.5'

networks:
  mapera:
    external: false
    name: mapera
    attachable: true
    driver: overlay

services:

  sftp:
    image: malkab/sftp-user:latest

    ports:
      - target: 22
        published: 2222
        protocol: tcp
        mode: host

    networks:
      - mapera

    environment:
      - USER=mapera
      - PASS=maperaSFTPkk22
      - USER_UID=1000
      - USER_GID=1000

    volumes:
      - mapera-https:/data/https
      - mapera-geoserver:/data/geoserver
      - mapera-geoserver-logs:/data/geoserver-logs
```
