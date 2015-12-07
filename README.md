A redsocks container primarily used to transparently utilize http(s) proxies.

Fork of [munkyboy's docker-redsocks repository](https://github.com/munkyboy/docker-redsocks) in order to improve the documentation (at least, I will try).

Inspired by [https://github.com/jpetazzo/squid-in-a-can](https://github.com/jpetazzo/squid-in-a-can) and
[https://github.com/wtsi-hgi/docker-proxify](https://github.com/wtsi-hgi/docker-proxify).

This container requires that you link the host network stack to the container.
After starting the container, you will then issue iptable commands to redirect
specific ports 80 and 443 to the redsocks daemon (see below).

### Start Container

#### Simple Example for HTTP Proxy only
Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment:
```
docker run --net=host -e http_proxy=http://yourproxy_IP_address_or_name:8080 munkyboy/redsocks
```
#### Example with HTTP proxy and HTTPS Proxy pointing to the same proxy URL
Change `http://yourproxy_IP_address_or_name:8080` by the IP address or name and TCP port that fits to your environment:
```
export my_proxy=http://yourproxy_IP_address_or_name:8080
docker run --net=host -e http_proxy=$my_proxy -e https_proxy=$my_proxy munkyboy/redsocks
unset my_proxy
```

#### Redirection on the Docker Host
Upon starting, the start script will echo sample `iptables` commands that need to be issued on the Docker host, e.g. 
```
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 12345
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to 12346
```
After you stop the container, you will need to cleanup the iptables rules again:
```
iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to 12345
iptables -t nat -D PREROUTING -p tcp --dport 443 -j REDIRECT --to 12346
```

#### Caveats
The container is sharing the Docker host's network and is listening to port `12345` and `12346`. If one of those ports is already in use, you will not be able to start the container. In a HTTP-only case, you may use a port mapping like
```
docker run -p 54321:12345 ...
```
instead of `docker run --net=host ...`. However, this is not possible in case of HTTPS, since the container needs to share the network IP address of the host, if you do not want to get an SSL error (`403 Forbidden`).


