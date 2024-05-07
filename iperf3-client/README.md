# iperf3-client

## example usage
Fortunately, much easier than server, because no messing with port forwarding.
```
docker run -it --rm jdimpson/iperf3-client -c <name or IP of host running iperf3> -t 10
```

## help
All the iperf3 command line options are available via a docker run command (including running in server mode, but 
you're on your own for port forwarding)

You can get the help message by running `docker run -it --rm jdimpson/iperf3-client -c <name or IP of host running iperf3> -t 10`
Which prints the following:
``` 
Usage: iperf3 [-s|-c host] [options]
       iperf3 [-h|--help] [-v|--version]

Server or Client:
  -p, --port      #         server port to listen on/connect to
  -f, --format   [kmgtKMGT] format to report: Kbits, Mbits, Gbits, Tbits
  -i, --interval  #         seconds between periodic throughput reports
  -I, --pidfile file        write PID file
  -F, --file name           xmit/recv the specified file
  -A, --affinity n/n,m      set CPU affinity
  -B, --bind <host>[%<dev>] bind to the interface associated with the address <host>
                            (optional <dev> equivalent to `--bind-dev <dev>`)
  --bind-dev <dev>          bind to the network interface with SO_BINDTODEVICE
  -V, --verbose             more detailed output
  -J, --json                output in JSON format
  --logfile f               send output to a log file
  --forceflush              force flushing output at every interval
  --timestamps<=format>     emit a timestamp at the start of each output line
                            (optional "=" and format string as per strftime(3))
  --rcv-timeout #           idle timeout for receiving data (default 120000 ms)
  --snd-timeout #           timeout for unacknowledged TCP data
                            (in ms, default is system settings)
  -d, --debug[=#]           emit debugging output
                            (optional optional "=" and debug level: 1-4. Default is 4 - all messages)
  -v, --version             show version information and quit
  -h, --help                show this message and quit
Server specific:
  -s, --server              run in server mode
  -D, --daemon              run the server as a daemon
  -1, --one-off             handle one client connection then exit
  --server-bitrate-limit #[KMG][/#]   server's total bit rate limit (default 0 = no limit)
                            (optional slash and number of secs interval for averaging
                            total data rate.  Default is 5 seconds)
  --idle-timeout #          restart idle server after # seconds in case it
                            got stuck (default - no timeout)
  --rsa-private-key-path    path to the RSA private key used to decrypt
                            authentication credentials
  --authorized-users-path   path to the configuration file containing user
                            credentials
  --time-skew-threshold     time skew threshold (in seconds) between the server
                            and client during the authentication process
Client specific:
  -c, --client <host>[%<dev>] run in client mode, connecting to <host>
                              (option <dev> equivalent to `--bind-dev <dev>`)
  -u, --udp                 use UDP rather than TCP
  --connect-timeout #       timeout for control connection setup (ms)
  -b, --bitrate #[KMG][/#]  target bitrate in bits/sec (0 for unlimited)
                            (default 1 Mbit/sec for UDP, unlimited for TCP)
                            (optional slash and packet count for burst mode)
  --pacing-timer #[KMG]     set the timing for pacing, in microseconds (default 1000)
  --fq-rate #[KMG]          enable fair-queuing based socket pacing in
                            bits/sec (Linux only)
  -t, --time      #         time in seconds to transmit for (default 10 secs)
  -n, --bytes     #[KMG]    number of bytes to transmit (instead of -t)
  -k, --blockcount #[KMG]   number of blocks (packets) to transmit (instead of -t or -n)
  -l, --length    #[KMG]    length of buffer to read or write
                            (default 128 KB for TCP, dynamic or 1460 for UDP)
  --cport         <port>    bind to a specific client port (TCP and UDP, default: ephemeral port)
  -P, --parallel  #         number of parallel client streams to run
  -R, --reverse             run in reverse mode (server sends, client receives)
  --bidir                   run in bidirectional mode.
                            Client and server send and receive data.
  -w, --window    #[KMG]    set send/receive socket buffer sizes
                            (indirectly sets TCP window size)
  -C, --congestion <algo>   set TCP congestion control algorithm (Linux and FreeBSD only)
  -M, --set-mss   #         set TCP/SCTP maximum segment size (MTU - 40 bytes)
  -N, --no-delay            set TCP/SCTP no delay, disabling Nagle's Algorithm
  -4, --version4            only use IPv4
  -6, --version6            only use IPv6
  -S, --tos N               set the IP type of service, 0-255.
                            The usual prefixes for octal and hex can be used,
                            i.e. 52, 064 and 0x34 all specify the same value.
  --dscp N or --dscp val    set the IP dscp value, either 0-63 or symbolic.
                            Numeric values can be specified in decimal,
                            octal and hex (see --tos above).
  -Z, --zerocopy            use a 'zero copy' method of sending data
  -O, --omit N              perform pre-test for N seconds and omit the pre-test statistics
  -T, --title str           prefix every output line with this string
  --extra-data str          data string to include in client and server JSON
  --get-server-output       get results from server
  --udp-counters-64bit      use 64-bit counters in UDP test packets
  --repeating-payload       use repeating pattern in payload, instead of
                            randomized payload (like in iperf2)
  --dont-fragment           set IPv4 Don't Fragment flag
  --username                username for authentication
  --rsa-public-key-path     path to the RSA public key used to encrypt
                            authentication credentials

[KMG] indicates options that support a K/M/G suffix for kilo-, mega-, or giga-

iperf3 homepage at: https://software.es.net/iperf/
Report bugs to:     https://github.com/esnet/iperf
```

## more documentation

[iperf3 man page](https://manpages.org/iperf3)

[iperf3 source](https://github.com/esnet/iperf)
