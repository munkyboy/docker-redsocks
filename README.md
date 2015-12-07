A redsocks container primarily used to transparently utilize http(s) proxies.

Inspired by https://github.com/jpetazzo/squid-in-a-can and
https://github.com/wtsi-hgi/docker-proxify

This container requires that you link the host network stack to the container.
After starting the container, you will then issue iptable commands to redirect
specific ports 80 and 443 to the redsocks daemon.

to run:

```
docker run --net=host -e http_proxy=http://yourproxy_IP_address_or_name:8080 munkyboy/redsocks
```
Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment and add -e https_proxy, if needed.

Example with HTTP proxy and HTTPS Proxy pointing to the same proxy URL:

```
export my_proxy=http://yourproxy_IP_address_or_name:8080
docker run --net=host -e http_proxy=$my_proxy -e https_proxy=$my_proxy munkyboy/redsocks
unset my_proxy
```

Upon starting, the start script will echo sample `iptables` commands that need to be issued on the Docker host, e.g. 
```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 12345
```
As you see, the redosocks deamon is listening to port `12345`. 
