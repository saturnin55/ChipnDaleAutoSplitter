state("fceux")
{
  short boss_cleared: 0x003B1388, 0x0038;
	byte boss_hp: 		0x003B1388, 0x00ee;
	byte area_id: 		0x003B1388, 0x006e;
	byte is_started: 	0x003B1388, 0x0214; // F8 = running, 10 = demo, 67 = main menu (except some wonky stuff in G cutscene)
} 


split
{
	///////////////////
	// no boss levels
	/////////////////// 
	
	// Area C 
	if(current.area_id == 0x19 && old.boss_cleared != 0x000b && current.boss_cleared == 0x000b)
	{
		print("ASL SPLIT C");
		
		return(true); 
	}
	// Area F - any%
	else if(current.area_id == 0x19 && old.boss_cleared != 0x0055 && current.boss_cleared == 0x0055)
	{
		print("ASL SPLIT F");
		
		return(true); 
	}
	// Area F - all zones
	else if(current.area_id == 0x19 && old.boss_cleared != 0x007f && current.boss_cleared == 0x007f)
	{
		print("ASL SPLIT F");
		
		return(true);
	}
	// Area H - any%
	else if(current.area_id == 0x19 && old.boss_cleared != 0x01d5 && current.boss_cleared == 0x01d5)
	{
		print("ASL SPLIT H");
		
		return(true);
	}
	// Area H - all zones
	else if(current.area_id == 0x19 && old.boss_cleared != 0x01ff && current.boss_cleared == 0x01ff)
	{
		print("ASL SPLIT H");
		
		return(true);
	}
		
	///////////////////
	// boss levels
	///////////////////
	// Area J
	else if(current.area_id == 0x16 && old.boss_hp == 0x4 && current.boss_hp == 0x5)
	{
		print("ASL SPLIT J");
		
		return(true);
	}
	// Area 0
	else if(current.area_id == 0x18 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT 0");
		
		return(true);
	}
	// Area A
	else if(current.area_id == 0x03 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT A");
		
		return(true);
	}
	// Area B
	else if(current.area_id == 0x06 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT B");
		
		return(true);
	}
	// Area D
	else if(current.area_id == 0x0a && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT D");
		
		return(true);
	}
	// Area E
	else if(current.area_id == 0x0d && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT E");
		
		return(true);
	}
	// Area G
	else if(current.area_id == 0x11 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT G");
		
		return(true);
	}
	// Area I
	else if(current.area_id == 0x14 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)
	{
		print("ASL SPLIT I");
		
		return(true);
	}
	else
		return(false); 
}

init  
{
	print("ASL INIT");

	vars.started = 0; 
}

start
{	
	if(old.is_started == 0x67 && current.is_started == 0xf8)
	{
		print("ASL START");
		
		return(true);
	}
	else
		return(false);
}

reset
{	
	
	print("ASL RESET? c.is_started : " + current.is_started + ", c.area_id : " + current.area_id + ", c.boss_cleared : " + current.boss_cleared);
	
	//  avoid auto reset in the cutscene
	if(current.is_started == 0x10 && current.boss_cleared != 0x00d5 && current.boss_cleared != 0x00ff)
	{
		print("ASL RESET1");
		return(true);
	}
	// loaded a savestate for an earlier level
	else if(current.boss_cleared < old.boss_cleared)
	{
		print("ASL RESET2");

		return(true); 
	}
	// reset
	else if(current.is_started == 0x67 && current.boss_hp == 0x0 && current.boss_cleared == 0x0 && current.area_id == 0x0)
	{
		print("ASL RESET3");
		return(true);
	}
	else
		return(false); 
		

	
	
	if(current.is_started == 0x67)
	{
		print("ASL RESET1");
		
		return(true);
	}
	//	load a previous level
	
}

startup
{
	refreshRate = 70;
	
	settings.Add("main", false, "Chip 'N Dale AutoSplitter 0.10");
	settings.Add("main3", false, "--https://github.com/saturnin55/ChipnDaleAutoSplitter", "main");
	settings.Add("main2", false, "--DISABLE RESET FOR 2-PLAYER MODE!!!", "main");
	settings.Add("main1", false, "--Currently only support FCEUX emulator", "main");
}
