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
ENV CONPORT=5001 \
    FWPORT=5001 \
    EXPORT=5001 \
    FWIP= \
    IGDURL= \
    FORMAT=m \
    INTERVAL=1
EXPOSE 5001/TCP \
       5001/UDP
ENTRYPOINT ["/entrypoint.sh"]
