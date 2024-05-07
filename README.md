# iperf-containers

iperf2 and iperf3 are network testing tools. No, iperf2 is not deprecated (although instances found in the wild tend to be very out of date). 
They are maintained by two different teams.

The iperf2 command is more typically called plained `iperf`, while the iperf3 command, well, `iperf3`.

Which one do you need? Well, if you have to ask, you probably could make use of either. Both do the most common tests: TCP, UDP, rate limited, time limited, byte count limited, etc. 
Where they differ is in the tecnical details. Probably the most likely difference you will encounter is that iperf3 does not handle multicast, while iperf2 does. (Another former
difference is that iperf3 did not support bidirectional traffic, but recent versions do have that feature.)

[This comparison from 2022](https://iperf2.sourceforge.io/IperfCompare.html) is still largely current. As you can see, there differences can be esoteric. They have to do with 
specific implementation decisions (zero copy, full duplex in the same socket, concurrency approach, and metrics reporting).

Note they are not interoperable. If you use iperf3-server, you need to use it with iperf3-client; same for iperf2-server with iperf2-client.
