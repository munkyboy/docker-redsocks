A redsocks container primarily used to transparently utilize http(s) proxies.

Fork of [munkyboy's docker-redsocks repository](https://github.com/munkyboy/docker-redsocks) in order to improve the documentation (at least, I will try).

Inspired by [https://github.com/jpetazzo/squid-in-a-can](https://github.com/jpetazzo/squid-in-a-can) and
[https://github.com/wtsi-hgi/docker-proxify](https://github.com/wtsi-hgi/docker-proxify).

This container requires that you link the host network stack to the container.
After starting the container, you will then issue iptable commands to redirect
specific ports 80 and 443 to the redsocks daemon (see below).

### Start Container

#### Simple Example for HTTP Proxy only
(Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment and add -e https_proxy, if needed.)
```
docker run --net=host -e http_proxy=http://yourproxy_IP_address_or_name:8080 munkyboy/redsocks
```
Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment and add -e https_proxy, if needed.

#### Example with HTTP proxy and HTTPS Proxy pointing to the same proxy URL:
(Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment and add -e https_proxy, if needed.)
```
export my_proxy=http://yourproxy_IP_address_or_name:8080
docker run --net=host -e http_proxy=$my_proxy -e https_proxy=$my_proxy munkyboy/redsocks
unset my_proxy
```

#### Redirection on the Docker Host
Upon starting, the start script will echo sample `iptables` commands that need to be issued on the Docker host, e.g. 
```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 12345
```
After you stop the container, you will need to cleanup the iptables rules:
```
iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to 12345
```

#### Caveats
The container is sharing the Docker host's network and is listening to port `12345`. If this port is already in use, you might need to start the docker container without `--net=host` switch, but with a port mapping instead, e.g.
```
docker run -p54321:12345 -e http_proxy=http://yourproxy_IP_address_or_name:8080 munkyboy/redsocks
```
In this case the you need to redirect your traffic to the mapped port (`54321` in this example), e.g. 
```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 54321
```
The container cannot be not aware of this port mapping and therefore it will try confusing you with iptable examples with port `12345`.
:blush:


