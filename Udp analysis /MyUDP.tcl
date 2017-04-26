set val(chan)		Channel/Wirelesschannel;
set val(prop)		Propagation/TwoRayGround;
set val(netif)		Phy/WirelessPhy;
set val(ant)		Antenna/OmniAntenna;
set val(mac)		MAC/802_11;
set val(ll)		LL;
set val(rp)		AODV;
set val(ifq)		Queue/Droptail/PriQueue;
set val(ifqlen)		50;
set val(nn)		10;
set val(x)		500;
set val(y)		400;
set val(start)		35;
set val(stop)		25;

set ns [new Simulator]
set tracefd [open MyUDP.tr w]
set namtrace [open MyUDP.nam w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

$ns node-config	-adhocRouting $val(rp)	\
		-channelType $val(chan)	\
		-propType $val(prop)	\
		-ifqType $val(ifq)	\
		-ifqLen $val(ifqlen)	\
		-phyType $val(netif)	\
		-macType $val(mac)	\
		-llType $val(ll)	\
		-antType $val(ant)	\
		-topoInstance $topo 	\
		-agentTrace OFF		\
		-routerTrace OFF		\
		-macTrace ON		
		-movementTrace ON

for {set i 0} {$i<$val(nn)} {incr i} {
	set node($i) [$ns node]
	$node($i) set X_ (expr 10+round(rand()*480))
	$node($i) set Y_ (expr 10+round(rand()*380))
	$node($i) set Z_ 0.0
	$ns initial_node_pos $node($i) 30
	$ns at val(stop) "$node($i) reset"
}

for {set i 0} {$i<(expr $val(nn)/2)} {incr i} {
	$ns color 1 red
	set udp($i) [new Agent/UDP]
	$udp($i) set class_ 2
	$udp($i) set fid_ 1
	$ns attach-agent $node($i) $udp($i)
	set null(expr $val(nn)-$i-1) [new Agent/Null]
	$ns attach-agent $node(expr $val(nn)-$i-1) $null(expr $val(nn)-$i-1)
	$ns connect $udp($i) $null(expr $val(nn)-$i-1)

	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) attach-agent $udp($i)
	$cbr($i) set type_ Traffic/CBR
	$cbr($i) set packet_size_ 1000
	$cbr($i) set rate_ 1mb
	$ns at $val(start) "$cbr($i) start"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"

proc finish {} {
	global ns tracefd namtrace
	close $tracefd
	close $namtrace
	puts "Simulation end"
}

$ns run
