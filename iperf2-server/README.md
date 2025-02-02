# iperf server
This container listens on both TCP and UDP ports 5001 by default. If you really want to change the port used within the container, you can set it using the CONPORT environment variable.

## Internet facing

If you are a a risk taker, you are not running your container host behind a firewall/router. You're nuts!  But at least your startup command is easier as a result!

You only need to forward that port from the host port to the container. 

Obviously, you can use any port on the container host. If you do, you should change FWPORT environment variable to reflect this. (But it doesn't actually matter.) 

## behind a firewall

Congratulations, you have a reasonable risk assessment threshold! But now you have to do more work, because you need to forward a port on your router/firewall to the host where you are running 
this container. Here's a picture.

```
 +-----------------------------+
 | host                        |       +-----------+
 |  +---------------+          |       | rtr/fw    |
 |  | iperf server  |   FWPORT |       |           |
 |  |       CONPORT +<---------+<------+    EXPORT +<-------- The Internet<---- iperf client
 |  | container     |          |       |           |
 |  +---------------+          |       |           |
 |                             |       +-----------+
 +-----------------------------+
```
Note that CONPORT, FWPORT, and EXPORT are all port numbers. I use the same value for all of them (5001). You may want to change EXPORT for your own reasons (like using the 
same external port number you may have used in the past). You might need to change FWPORT if you are running multiple instances of iperf servers on the same host. But you really shouldn't need 
to change CONPORT. But you can if you want.

Anyway, the `docker run` command will take care of the settings on the host and container, but we also need a rule on the router/firewall, so that it will forward the packets from the Internet into the host
and then into the container. You can make that manually, by changing the configuration of the router/firewall. You are on your own for that.

However, you router/firewall may support [UPnP requests for port forwarding](https://blog.qnap.com/en/what-is-upnp-port-forwarding-en/). Note that many people who are smarter than me will disable or
disallow this feature, as it presents a security risk. So don't enable it just because I convince you that it's cool.

## upnpc

This container also contains `upnpc`, which can make UPnP requests and set up the forwaring rule for you! YOu can activate `upnpc` by providing a FWIP (forwarding IP Address) to the run command. 

```
docker run -it --rm -p 5001:5001/tcp -p 5001:5001/udp -e FWIP=X.X.X.X jdimpson/iperf2-server
```
(where `X.X.X.X` is the IP address of the host in the above picture.) However, **this command won't work right.**  (The iperf server will still work, but the `upnpc` command won't successfully request
port forwarding.)

Unfortunately it's not a as simple as it could be when in a container environment. The above command uses the default host network, but `upnpc` defaults to using multicast discovery packets to locate 
the router/firewall. And at least so far I haven't figure out a way to make that work with in a Docker environment without adding custom `iptables` rules on the host.

Fortunately, you can bypass the multicast-based discovery step and provide the correct IGD URL to `upnpc`

```
docker run -it --rm -p 5001:5001/tcp -p 5001:5001/udp -e FWIP=X.X.X.X -e IGDURL=http://Y.Y.Y.Y:36725/ctl/IPConn jdimpson/iperf2-server
```

But how do you determine the IGDURL? Well, you can run `upnpc -L`, which will show result like this:

```
upnpc : miniupnpc library test client, version 2.2.3.
 (c) 2005-2021 Thomas Bernard.
Go to http://miniupnp.free.fr/ or https://miniupnp.tuxfamily.org/
for more information.
List of UPNP devices found on the network :
 desc: http://Y.Y.Y.Y:36725/rootDesc.xml
 st: urn:schemas-upnp-org:device:InternetGatewayDevice:1

Found valid IGD : http://Y.Y.Y.Y:36725/ctl/IPConn
Local LAN ip address : X.X.X.X
 i protocol exPort->inAddr:inPort description remoteHost leaseTime
 0 TCP 5001->X.X.X.X:5001 'iperf2' '' 0
 1 UDP 5001->X.X.X.X:5001 'iperf2' '' 0
```

Find the line `Found valid IGD`. The IGDURL value is `http://Y.Y.Y.Y:36725/ctl/IPConn`.

The problem is you'll have to install `upnpc` on some other computer in order to run this. On Debian based systems, you can get `upnpc` from running `apt install miniupnpc`.


## with firewall, MACVLAN or L2 IPVLAN networking
There is an alternative. You can allow the `upnpc` multicast discovery to work if you can give the container an IP address directly on your network. You can do that if you use 
a MACVLAN or Layer 2 IPVLAN network for your container. All you need to do is add "-e FWIP=..." by itself, without setting IGDURL. But don't set FWIP to your host, but instead to the 
MACVLAN or L2 IPVLAN address you gave to the container, like below. Z.Z.Z.Z is an IP address in the docker network range assigned to macvlan0:

```
docker run -it --rm --net=macvlan0 --ip=Z.Z.Z.Z -e FWIP=Z.Z.Z.Z  jdimpson/iperf2-server
```
You also don't need the host level port forward ("-p 5001:1111/tcp ...") in this mode, either.

### with host networking
Finally, and easiest, is to use host networking (--net=host), and set FWIP to the IP address of the Docker host. This may allows `upnpc` multicast discovery to work and avoids need to setting up macvlan or l2vlan. It may be easiest to describe this as a script:

``` 
#!/bin/sh

# set FWIP to the host IP address that follows what is (probably) the default route. 
FWIP=$(ip route get 8.8.8.8 | sed -e '/cache/d' -e 's/.* src //' -e 's/ uid .*//')
echo Using $FWIP to register with firewall as iperf server
docker run -it --rm --net=host -e FWIP=$FWIP jdimpson/iperf2-server 
```

## Summary
Setting FWIP to the IP address of the container will cause `upnpc` request port forwarding twice, once each for TCP and UDP ports. That's all you need to do if your container network is in MACVLAN or Layer 2 IPVLAN or host modes.
You need to set IGDURL if your container network is in default mode.

