A redsocks container primarily used to transparently utilize http(s) proxies.

Inspired by https://github.com/jpetazzo/squid-in-a-can and https://github.com/wtsi-hgi/docker-proxify

to run:
```
docker run -d --net=host -e http_proxy=http://1.2.3.4:3128 redsocks
```
