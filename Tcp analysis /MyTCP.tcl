set val(chan)		Channel/WirelessChannel;
set val(prop)		Propagation/TwoRayGround;
set val(netif)		Phy/WirelessPhy;
set val(ant)		Antenna/OmniAntenna;
set val(mac)		Mac/802_11;
set val(ll)		LL;
set val(rp)		AODV;
set val(ifq)		Queue/DropTail/PriQueue;
set val(ifqlen)		50;
set val(nn)		10;
set val(x)		500;
set val(y)		400;
set val(start)		5;
set val(stop)		25;

set ns [new Simulator]
set tracefd [open MyTCP.tr w]
set namtrace [open MyTCP.nam w]

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
		-agentTrace ON		\
		-routerTrace ON		\
		-macTrace OFF		\
		-movementTrace ON

for {set i 0} {$i<$val(nn)} {incr i} {
	set node($i) [$ns node]
	$node($i) set X_ [expr 10+round(rand()*480)]
	$node($i) set Y_ [expr 10+round(rand()*380)]
	$node($i) set Z_ 0.0
	$ns initial_node_pos $node($i) 30
	$ns at val(stop) "$node($i) reset"
}

for {set i 0} {$i<[expr $val(nn)/2]} {incr i} {
	$ns color 1 red
	set tcp($i) [new Agent/TCP]
	$tcp($i) set class_ 2
	$tcp($i) set fid_ 1
	$ns attach-agent $node($i) $tcp($i)
	set sink([expr $val(nn)-$i-1]) [new Agent/TCPSink]
	$ns attach-agent $node([expr $val(nn)-$i-1]) $sink([expr $val(nn)-$i-1])
	$ns connect $tcp($i) $sink([expr $val(nn)-$i-1])

	set ftp($i) [new Application/FTP]
	$ftp($i) attach-agent $tcp($i)
	$ftp($i) set type_ FTP
	$ftp($i) set packet_size_ 1000
	$ftp($i) set rate_ 1mb
	$ns at $val(start) "$ftp($i) start"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"

proc finish {} {
	global ns tracefd namtrace
	$ns flush-trace
	close $tracefd
	close $namtrace
	puts "Simulation end"
	$ns halt
	puts "awk -f MyTCPana.awk MyTCP.tr"
	exec nam MyTCP.nam &
	exit 0
}

$ns run
