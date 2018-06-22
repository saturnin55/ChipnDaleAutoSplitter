state("fceux") 
{
 	short boss_cleared:	0x003B1388, 0x0038;
	byte boss_hp: 		0x003B1388, 0x00ee;
	byte area_id: 		0x003B1388, 0x006e;
	byte is_started: 	0x003B1388, 0x0214; // F8 = running, 10 = demo, 67 = main menu (except some wonky stuff in G cutscene)
} 

state("nestopia") 
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	short boss_cleared: 	"nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xa0;  // 0x0038
	byte boss_hp: 		"nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x156; // 0x00ee
	byte area_id: 		"nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xd6;  // 0x006e
	byte is_started: 	"nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x27c; // 0x0214
} 

init
{
	// I want to be 100% sure there is no double split for an area
	vars.areas = new Dictionary<string, bool>();
}

split
{
	///////////////////
	// no boss levels
	/////////////////// 
	
	// Area C with differente alternate routes 
	if(!vars.areas["C"] && current.area_id == 0x19 && old.boss_cleared != 0x000b && current.boss_cleared == 0x000b)
	{
		vars.areas["C"] = true;
		return(true);
	}
	else if(!vars.areas["C"] && current.area_id == 0x19 && old.boss_cleared != 0x000d && current.boss_cleared == 0x000d)
	{
		vars.areas["C"] = true;
		return(true);
	}
	else if(!vars.areas["C"] && current.area_id == 0x19 && old.boss_cleared != 0x000f && current.boss_cleared == 0x000f)
	{
		vars.areas["C"] = true;
		return(true);
	}
	// Area F - any%
	else if(!vars.areas["F"] && current.area_id == 0x19 && old.boss_cleared != 0x0055 && current.boss_cleared == 0x0055)	
	{
		vars.areas["F"] = true;
		return(true);
	}
	// Area F - all zones
	else if(!vars.areas["F"] && current.area_id == 0x19 && old.boss_cleared != 0x007f && current.boss_cleared == 0x007f)	
	{
		vars.areas["F"] = true;
		return(true);
	}
	// Area H - any%
	else if(!vars.areas["H"] && current.area_id == 0x19 && old.boss_cleared != 0x01d5 && current.boss_cleared == 0x01d5)	
	{
		vars.areas["H"] = true;
		return(true);
	}
	// Area H - all zones
	else if(!vars.areas["H"] && current.area_id == 0x19 && old.boss_cleared != 0x01ff && current.boss_cleared == 0x01ff)
	{
		vars.areas["H"] = true;
		return(true);
	}
		
	///////////////////
	// boss levels
	///////////////////
	// Area J
	else if(!vars.areas["J"] && current.area_id == 0x16 && old.boss_hp == 0x4 && current.boss_hp == 0x5)	
	{
		vars.areas["J"] = true;
		return(true);
	}
	// Area 0
	else if(!vars.areas["0"] && current.area_id == 0x18 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["0"] = true;
		return(true);
	}
	// Area A
	else if(!vars.areas["A"] && current.area_id == 0x03 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["A"] = true;
		return(true);
	}
	// Area B
	else if(!vars.areas["B"] && current.area_id == 0x06 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["B"] = true;
		return(true);
	}
	// Area D
	else if(!vars.areas["D"] && current.area_id == 0x0a && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["D"] = true;
		return(true);
	}
	// Area E
	else if(!vars.areas["E"] && current.area_id == 0x0d && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["E"] = true;
		return(true);
	}
	// Area G
	else if(!vars.areas["G"] && current.area_id == 0x11 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["G"] = true;
		return(true);
	}
	// Area I
	else if(!vars.areas["I"] && current.area_id == 0x14 && current.boss_hp == 0x5 && old.boss_cleared != current.boss_cleared)	
	{
		vars.areas["I"] = true;
		return(true);
	}
	else
		return(false); 
}

start
{	
	if(old.is_started == 0x67 && current.is_started == 0xf8)
	{
		vars.areas["0"] = false;
		vars.areas["A"] = false;
		vars.areas["B"] = false;
		vars.areas["C"] = false;
		vars.areas["D"] = false;
		vars.areas["E"] = false;
		vars.areas["F"] = false;
		vars.areas["G"] = false;
		vars.areas["H"] = false;
		vars.areas["I"] = false;
		vars.areas["J"] = false;
		
		return(true);
	}
	else
		return(false);
}

reset 
{	
	//  avoid auto reset in the cutscene
	if(current.is_started == 0x10 && current.boss_cleared != 0x00d5 && current.boss_cleared != 0x00ff)
		return(true);
	// loaded a savestate for an earlier level
	else if(current.boss_cleared < old.boss_cleared)
		return(true); 
	// reset
	else if(current.is_started == 0x67 && current.boss_hp == 0x0 && current.boss_cleared == 0x0 && current.area_id == 0x0)
		return(true);
	else
		return(false); 
}

startup
{
	refreshRate = 60;
	
	settings.Add("main", false, "Chip 'N Dale AutoSplitter 0.13 by saturnin55");
	settings.Add("main0", false, "- Website : https://github.com/saturnin55/ChipnDaleAutoSplitter", "main");
	settings.Add("main2", false, "- Supported emulators : FCEUX, Netstopia", "main");
	settings.Add("main1", false, "- Note : Disable 'RESET' feature for 2-player autosplitting", "main");

}
