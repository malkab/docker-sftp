Docker Image for a SFTP Server with Keys Log In
===
This Docker image is based on the work of __Knut Ahlers__ (knut@ahlers.me, https://github.com/luzifer-docker/sftp-share) and Martin Honermeyer (https://github.com/djmaze). All credits to them. Just made some extra configurations and adaptations.


What does this Docker image contains?
---
A very basic image with a single user SFTP server and data storage, accesible by key, intended to act as an entry point of data to other container's volumes. For example, this is often deployed in tandem with [Docker-GeoServer](https://github.com/malkab/Docker-GeoServer) to allow users to log in with WinSCP and load data to the server to be later served with GeoServer. GeoServer just a Compose volume shared with this service.


Usage Pattern
---
Configure the service with the following env variables:

- __USER_UID:__ most of the times it is important to map the user's UID and GID to specific settings, to map users ID in another service (e.g. GeoServer). It defaults to 1000;
- __USER_GID:__ user group ID. Defaults to 1000;
- __AUTHORIZEDKEYS:__ a # separated list of SSH public keys authorized to log in.

The user inside the container is called __datauser__. This image exposes a __/data__ volume which is the home of the mentioned user.

To start the container interactively for testing purposes:

```Shell
docker run -ti --rm \
    -p 2222:22 \
    -e AUTHORIZEDKEYS="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZF0IcSoaVvlqITHQb9JWpGiE/9HIPLXJzw7ybBk4hYO9xQP9WCRBsFQnsXJRZwbV3c0BSG1IJQKX8YY4ZAGR9prRf+jEqrnrryNedEDUZHs+H4hwdimNREoby1D3Jj1ybPpe9Zj7kbyr61rj43j4354terCWpRYr84aVCFjfuq4EWaqSNT7XhMGR0QuUofAm4YW5VzR29TjUOg2T8dLaTi/9DEF32X9C2WuDTUOF4OkJ3fb3Vai2B6PQ3KAI7dJdG0jSOEgYfA9lYBYk6frDCtKwqPoF+QbbWzVSdp5K1GYBskMQfQJK5xsghA1E3YTpfBS/Mwi5ScxEiHlhDKKM63/K9R anuser@ahost#ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV3SPjwSHGFcDpOR5uZ+RiRIwV+2cQvceFohk+wsYPCb+1h/oDb9b3gi3asBuT7kuF7xUP72iWDjFhBAk5FLlVyJqobFeUhL4PA4s4ujS35tEIRhQM5I6V91sOePsg4xj25u3j4k534rq3uLHzmnBeCC5CEeDG013CIuMfIigYMFVgoGxyM44JTFbU0wQShbA/X8cOIel571HyHLLIf9kmi+TZCGDEgfDQ7RVaBw2ru52a/OXYvt1+ZYJpnsl7Dn/1pG5LGYxP6I2gdrDDZ93laBsJUP4z4ryOJlkRdXAWkmJT54i8/KMthJGYkwW2zDCbQnfB6c0PtuOEC57v21eX1 anuser@anotherhost" \
    -e USER_UID=1500 \
    -e USER_GID=1600 \
    malkab/sftp-user:latest
```

SFTP and SCP access are granted. To upload files without known_host check:

```Shell
scp -P 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null afile datauser@localhost:newname
```


Deploying as a Stack
---
Use the supplied __docker-compose.yaml__ as a template to deploy a standalone stack service. Authorized keys can be modified on the fly:

```Shell
docker service update --env-add AUTHORIZEDKEYS=whatever servicename
```
