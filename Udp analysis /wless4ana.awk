BEGIN{
	sent=0
	received=0
	cbr=0
	aodv=0;
}

{
	if($1=="s")			# $1 indicates column 1 in wless4.tr
	{
		sent++;
	}
	
	if($1=="r")
	{
		received++;
	}
	
	if($7=="cbr")
		cbr++;

	if($7=="AODV")
		aodv++;

}

END{
	printf("Sent=%d\n",sent);
	printf("Received=%d\n",received);
	printf("CBR Packets=%d\n",cbr);
	printf("AODV Packets=%d\n",aodv);	
}
