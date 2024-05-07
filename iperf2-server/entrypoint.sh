#!/bin/sh
iperf -v

# CONPORT is the port used in the container; it's what iperf2 will bind to in server mode.
if test -z "$CONPORT"; then
	CONPORT=5001;
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

echo "Container port (CONPORT): $CONPORT";
echo "Forwarded port (FWPORT) : $FWPORT";
echo "Forwarded IP (FWIP)     : $FWIP";
echo "External port (EXPORT)  : $EXPORT";

# other less important control variables
test -z "$FORMAT"   && FORMAT="m"
test -z "$INTERVAL" && INTERVAL="1";

# FWIP is the port we want the router to forward packets to. 
# in standard docker NAT mode, and in --net=host mode, this is the IP address of the container host.
# in --net=macvlan, this it the value the container gets assigned by the macvlan mechanism.

if test -z "$FWIP"; then
	echo "Forwarding IP address (FWIP) is not set, so UPNP forwarding will not be attempted." >&2;
else
	echo "Registering port forwarding on the router ($EXPORT -> $FWIP:$FWPORT)";
	if ! test -z "$IGDURL"; then
		echo "Using $IGDURL for UPNP port forwarding requests";
		IGD="-u $IGDURL";
	else
		IGD=
	fi
	if upnpc $IGD -e iperf2 -a "$FWIP" "$FWPORT" "$EXPORT" UDP; then
		true;
	else
		echo "Failed to forward UDP, continuing" >&2;
	fi
	
	if upnpc $IGD -e iperf2 -a "$FWIP" "$FWPORT" "$EXPORT" TCP; then
		true;
	else
		echo "Failed to forward TCP, continuing" >&2;
	fi

	trap "upnpc $IGD -d $EXPORT TCP; upnpc $IGD -d $EXPORT UDP" EXIT;
fi

echo "Running iperf2 server, listening on container TCP and UDP ports $CONPORT";
iperf --udp --server --port "$CONPORT" --interval $INTERVAL --format $FORMAT &
iperf --server --port "$CONPORT" --interval $INTERVAL --format $FORMAT;

# TODO: add options to support upnp authentication
        handle all the advanced stuff that iperf2 can do
