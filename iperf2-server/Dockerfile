#FROM alpine:latest AS build
#WORKDIR /src
#RUN apk add git make gcc libc-dev linux-headers
#RUN git clone https://github.com/robertdavidgraham/masscan.git
#RUN cd masscan && make

FROM alpine:latest AS run
#COPY --from=build /src/masscan/bin/masscan /masscan
RUN apk add curl iptables speedtest-cli miniupnpc iperf
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENV CONPORT=11111 \
    FWPORT=11111 \
    EXPORT=11111 \
    FWIP= \
    IGDURL= \
    FORMAT=m \
    INTERVAL=1
EXPOSE 11111/TCP \
       11111/UDP
ENTRYPOINT ["/entrypoint.sh"]
