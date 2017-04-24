BEGIN{
	sent=0;
	receive=0;
	tcp=0;
	ack=0;
	aodv=0;
}

{
	if($1=="s"){
		++sent;
	}
	if($1=="r"){
		receive++;
	}
	if($7=="tcp"){
		tcp++;
	}
	if($7=="ack"){
		ack++;
	}
	if($7=="AODV"){
		aodv++;
	}
}

END{
	printf("Sent = %d\n",sent);
	printf("Received = %d\n",receive);
	printf("TCP packets = %d\n",tcp);
	printf("TCP acknowledgments = %d\n",ack);
	printf("AODV packets = %d\n",aodv);
}
