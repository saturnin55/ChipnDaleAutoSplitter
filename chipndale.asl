state("fceux")
{
	byte boss_cleared: 0x003B1388, 0x38;
	byte fatrat_dead: 0x003B1388, 0xec;
}

split
{
	// split on goal line
	if(current.boss_cleared < old.boss_cleared.level)
	   return(true);
  else if(current.boss_cleared == 981 && current.fatrat_dead != 0)
     return(true);
	else
	   return(false);
}

start
{ 
	//return(current.level == 0 && old.end_of_level != current.end_of_level && current.end_of_level == 1);
}

reset
{
	//	1) reload nes or savestate to menu
	if(current.boss_cleared == 0 && old.boss_cleared != 0)
		return(true);
	//	2) load a previous level
	else if(current.boss_cleared < old.boss_cleared)
     return(true);
  else
		return(false);
}

startup
{
	refreshRate = 70;
	
	settings.Add("main", false, "Chip 'N Dale AutoSplitter 0.01");
	settings.Add("main3", false, "--https://github.com/saturnin55/ChipnDaleAutoSplitter", "main");
	settings.Add("main1", false, "--Currently only support FCEUX emulator", "main");
}

