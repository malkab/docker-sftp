# A Small Full Anonymous FTP Implementation in Python

This is intended to field a fully anonymous FTP server in Python for implementing fully privately in LAN to share files between systems.


## Deployment in SWARM

This only works in a SWARM environment by exposing the ports directly to the host, a real pain:

```yaml
ftp:
  image: malkab/pyanonftp:latest

  volumes:
    - ftp-data:/file-server-anon/

  ports:
    - target: 21
      published: 2221
      protocol: tcp
      mode: host
    - target: 40000
      published: 40000
      protocol: tcp
      mode: host
    - target: 40001
      published: 40001
      protocol: tcp
      mode: host
    - target: 40002
      published: 40002
      protocol: tcp
      mode: host
    - target: 40003
      published: 40003
      protocol: tcp
      mode: host
    - target: 40004
      published: 40004
      protocol: tcp
      mode: host
    - target: 40005
      published: 40005
      protocol: tcp
      mode: host
    - target: 40006
      published: 40006
      protocol: tcp
      mode: host
    - target: 40007
      published: 40007
      protocol: tcp
      mode: host
    - target: 40008
      published: 40008
      protocol: tcp
      mode: host
    - target: 40009
      published: 40009
      protocol: tcp
      mode: host

  networks:
    - ssparc
```
