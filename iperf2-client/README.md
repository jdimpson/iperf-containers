# iperf2-client

## example usage
Fortunately, much easier than server, because no messing with port forwarding.
```
docker run -it --rm jdimpson/iperf2-client -c <name or IP of host running iperf2> -t 10 -u -i 1
```

## help
All the iperf2 command line options are available via a docker run command (including running in server mode, but 
you're on your own for port forwarding)

You can get the help message by running `docker run -it --rm jdimpson/iperf2-client -c <name or IP of host running iperf2> -t 10`
Which prints the following:
```
Usage: iperf [-s|-c host] [options]
       iperf [-h|--help] [-v|--version]

Client/Server:
  -b, --bandwidth #[kmgKMG | pps]  bandwidth to read/send at in bits/sec or packets/sec
  -e, --enhanced    use enhanced reporting giving more tcp/udp and traffic information
  -f, --format    [kmgKMG]   format to report: Kbits, Mbits, KBytes, MBytes
      --hide-ips           hide ip addresses and host names within outputs
  -i, --interval  #        seconds between periodic bandwidth reports
  -l, --len       #[kmKM]    length of buffer in bytes to read or write (Defaults: TCP=128K, v4 UDP=1470, v6 UDP=1450)
  -m, --print_mss          print TCP maximum segment size
  -o, --output    <filename> output the report or error message to this specified file
  -p, --port      #        client/server port to listen/send on and to connect
      --permit-key         permit key to be used to verify client and server (TCP only)
      --sum-only           output sum only reports
  -u, --udp                use UDP rather than TCP
      --utc                use coordinated universal time (UTC) with time output
  -w, --window    #[KM]    TCP window size (socket buffer size)
  -z, --realtime           request realtime scheduler
  -B, --bind <host>[:<port>][%<dev>] bind to <host>, ip addr (including multicast address) and optional port and device
  -C, --compatibility      for use with older versions does not sent extra msgs
      --NUM_REPORT_STRUCTS increase the shared memory between the traffic threads and the reporter thread (default is 10,000 entries)
  -M, --mss       #        set TCP maximum segment size using TCP_MAXSEG
  -N, --nodelay            set TCP no delay, disabling Nagle's Algorithm
  -S, --tos       #        set the socket's IP_TOS (byte) field
  -Z, --tcp-congestion <algo>  set TCP congestion control algorithm (Linux only)

Server specific:
  -p, --port      #[-#]    server port(s) to listen on/connect to
  -s, --server             run in server mode
  -1, --singleclient       run one server at a time
      --histograms         enable latency histograms
      --jitter-histograms  enable jitter histograms
      --permit-key-timeout set the timeout for a permit key in seconds
      --tcp-rx-window-clamp set the TCP receive window clamp size in bytes
      --tap-dev   #[<dev>] use TAP device to receive at L2 layer
  -t, --time      #        time in seconds to listen for new connections as well as to receive traffic (default not set)
  -B, --bind <ip>[%<dev>]  bind to multicast address and optional device
  -U, --single_udp         run in single threaded UDP mode
      --sum-dstip          sum traffic threads based upon destination ip address (default is src ip)
  -D, --daemon             run the server as a daemon
  -V, --ipv6_domain        Enable IPv6 reception by setting the domain and socket to AF_INET6 (Can receive on both IPv4 and IPv6)

Client specific:
      --bounceback         request a bounceback test (use -l for size, defaults to 100 bytes)
      --bounceback-hold    request the server to insert a delay of n milliseconds between its read and write
      --bounceback-period  request the client schedule a send every n milliseconds
      --bounceback-no-quickack request the server not set the TCP_QUICKACK socket option (disabling TCP ACK delays) during a bounceback test
  -c, --client    <host>   run in client mode, connecting to <host>
      --connect-only       run a connect only test
      --connect-retries #  number of times to retry tcp connect
  -d, --dualtest           Do a bidirectional test simultaneously (multiple sockets)
      --fq-rate #[kmgKMG]  bandwidth to socket pacing
      --full-duplex        run full duplex test using same socket
      --ipg                set the the interpacket gap (milliseconds) for packets within an isochronous frame
      --isochronous <frames-per-second>:<mean>,<stddev> send traffic in bursts (frames - emulate video traffic)
      --incr-dstip         Increment the destination ip with parallel (-P) traffic threads
      --incr-dstport       Increment the destination port with parallel (-P) traffic threads
      --incr-srcip         Increment the source ip with parallel (-P) traffic threads
      --incr-srcport       Increment the source port with parallel (-P) traffic threads
      --local-only         Set don't route on socket
      --near-congestion=[w] Use a weighted write delay per the sampled TCP RTT (experimental)
      --no-connect-sync    No sychronization after connect when -P or parallel traffic threads
      --no-udp-fin         No final server to client stats at end of UDP test
  -n, --num       #[kmgKMG]    number of bytes to transmit (instead of -t)
  -r, --tradeoff           Do a fullduplexectional test individually
      --tcp-quickack       set the socket's TCP_QUICKACK option (off by default)
      --tcp-write-prefetch set the socket's TCP_NOTSENT_LOWAT value in bytes and use event based writes
      --tcp-write-times    measure the socket write times at the application level
  -t, --time      #        time in seconds to transmit for (default 10 secs)
      --trip-times         enable end to end measurements (requires client and server clock sync)
      --txdelay-time       time in seconds to hold back after connect and before first write
      --txstart-time       unix epoch time to schedule first write and start traffic
  -B, --bind [<ip> | <ip:port>] bind ip (and optional port) from which to source traffic
  -F, --fileinput <name>   input the data to be transmitted from a file
  -H, --ssm-host <ip>      set the SSM source, use with -B for (S,G) 
  -I, --stdin              input the data to be transmitted from stdin
  -L, --listenport #       port to receive fullduplexectional tests back on
  -P, --parallel  #        number of parallel client threads to run
  -R, --reverse            reverse the test (client receives, server sends)
  -S, --tos                IP DSCP or tos settings
  -T, --ttl       #        time-to-live, for multicast (default 1)
      --working-load request a concurrent TCP stream
  -V, --ipv6_domain        Set the domain to IPv6 (send packets over IPv6)
  -X, --peer-detect        perform server version detection and version exchange

Miscellaneous:
  -x, --reportexclude [CDMSV]   exclude C(connection) D(data) M(multicast) S(settings) V(server) reports
  -y, --reportstyle C      report as a Comma-Separated Values
  -h, --help               print this message and quit
  -v, --version            print version information and quit

[kmgKMG] Indicates options that support a k,m,g,K,M or G suffix
Lowercase format characters are 10^3 based and uppercase are 2^n based
(e.g. 1k = 1000, 1K = 1024, 1m = 1,000,000 and 1M = 1,048,576)

Accepted tos values are: af11, af12, af13, af21, af22, af23, af31, af32, af33, af41, af42, af43,
cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, ef, le, nqb, nqb2, ac_be, ac_bk, ac_vi, ac_vo, lowdelay, throughput,
reliability, or a numeric value.

The TCP window size option can be set by the environment variable
TCP_WINDOW_SIZE. Most other options can be set by an environment variable
IPERF_<long option name>, such as IPERF_BANDWIDTH.

Source at <http://sourceforge.net/projects/iperf2/>
Report bugs to <iperf-users@lists.sourceforge.net>
```

## more documentation

[iperf2 man page](https://iperf2.sourceforge.io/iperf-manpage.html)

[iperf2 source](https://sourceforge.net/projects/iperf2/)
