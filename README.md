A redsocks container primarily used to transparently utilize http(s) proxies.

Inspired by https://github.com/jpetazzo/squid-in-a-can and
https://github.com/wtsi-hgi/docker-proxify

This container requires that you link the host network stack to the container.
After starting the container, you will then issue iptable commands to redirect
specific ports to the redsocks daemon.

to run:
```
docker run --net=host -e http_proxy=http://1.2.3.4:3128 redsocks
```

The container currently interprets the environment variables `http_proxy` and
`https_proxy` to configure redsocks. Upon starting, the start script will echo
sample `iptables` commands to issue on the host.
