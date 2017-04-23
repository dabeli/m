BEGIN{
	sent=0
	received=0
	tcp=0
	ack=0
	aodv=0;
}

{
	if($1=="s")			# $1 indicates column 1 in wless3.tr
	{
		sent++;
	}
	
	if($1=="r")
	{
		received++;
	}
	
	if($7=="tcp")
		tcp++;
	
	if($7=="ack")
		ack++;

	if($7=="AODV")
		aodv++;

}

END{
	printf("Sent=%d\n",sent);
	printf("Received=%d\n",received);
	printf("TCP Packets=%d\n",tcp);
	printf("TCP Acknowledgements=%d\n",ack);
	printf("AODV Packets=%d\n",aodv);	
}
