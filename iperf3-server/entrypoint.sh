#!/bin/sh

# CONPORT is the port used in the container; it's what iperf3 will bind to in server mode.
if test -z "$CONPORT"; then
	CONPORT=11111;
fi

# FWPORT is the port that the router iwll forward to.
# in standard docker NAT mode, this needs to be the port that gets redirected 
# by the container host to the container's CONPORT
# in --net=host or --net=macvlan, then this value must be equal to CONPORT
if test -z "$FWPORT"; then
	FWPORT="$CONPORT";
fi

# EXPORT is the external port we want to open up on the router, which will be forwarded 
# to the container host and ultimately to the container.
# It can be anything, but be aware that it's what the external iperf client will connect to
if test -z "$EXPORT"; then
	EXPORT="$FWPORT";
fi

# FWIP is the port we want the router to forward packets to. 
# in standard docker NAT mode, and in --net=host mode, this is the IP address of the container host.
# in --net=macvlan, this it the value the container gets assigned by the macvlan mechanism.

if test -z "$FWIP"; then
	# in theory, the IP address in net=host and net=macvlan could be detected, but for now we just require it to be set
	echo "Forwarding IP address (FWIP) is required." >&2;
	exit 1;
fi

echo "Container port (CONPORT): $CONPORT";
echo "Forwarded port (FWPORT) : $FWPORT";
echo "Forwarded IP (FWIP)     : $FWIP";
echo "External port (EXPORT)  : $EXPORT";

# other less important control variables
test -z "$FORMAT"   && FORMAT="m"
test -z "$INTERVAL" && INTERVAL="1";


echo "Registering port forwarding on the router ($EXPORT -> $FWIP:$FWPORT)";
if upnpc -e iperf3 -a "$FWIP" "$FWPORT" "$EXPORT" UDP; then
	echo "Failed to forward UDP, continuing" >&2;
fi
	
if upnpc -e iperf3 -a "$FWIP" "$FWPORT" "$EXPORT" TCP; then
	echo "Failed to forward TCP, continuing" >&2;
fi

trap "upnpc -d $EXPORT TCP; upnpc -d $EXPORT UDP" EXIT;

echo "Running iperf3 server, listening on container port $CONPORT";
iperf3 -s -p "$CONPORT" --interval $INTERVAL --format $FORMAT;

# TODO: add options to support upnp authentication
