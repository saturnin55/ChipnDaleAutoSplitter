/** 
 * chipndale.asl - An ASL script for LiveSplit for the game Chip 'N Dale: Rescue Rangers (NES) using FCEUX.
 * @author saturnin55
 * @version 0.3 on June 12th 2018
 * Splits on boss kill, supports Any% and All Zones
 */
state("fceux")
{
	short boss_cleared: 0x003B1388, 0x38;
	byte fatcat_stun: 0x003B1388, 0xed;
	byte flag_start: 0x003B1388, 0x31;
	byte flag_start2: 0x003B1388, 0x99; 
	byte continues:  0x003B1388, 0xf8; 
	byte lifes_p1:  0x003B1388, 0x05b6; 
	byte lifes_p2:  0x003B1388, 0x05b4;
} 


split
{
	if(vars.started == 0)
		return(false);

	//vars.fatcat_hits= 0;
	//vars.fatcat_unstunned = 1;

	// no more continues or lifes
	if(current.lifes_p2 == 0)
	{
		vars.flag_reset = 1;
		return(false);
	}
	 
	// continues
	if((old.continues == 0x02 && current.continues == 0x01) ||
		(old.continues == 0x01 && current.continues == 0x00) ||
		(old.continues == 0x00 && current.continues == 0xff))
	{
		vars.fatcat_hits = 0;
		vars.continues--;
		print("CONTINUE TAKEN : " + vars.continues);
	}
      
	// losing a life
	if(current.lifes_p1 != old.lifes_p1 || current.lifes_p2 != old.lifes_p2)
	{
		int x2;
		
		vars.fatcat_hits = 0;
		
		if(current.lifes_p2 != 0)
			x2 = (current.lifes_p2 - 128) * 10;
		else
			x2 = 0;

		vars.lifes = x2 + current.lifes_p1 - 128; 
		
		print("ASL STATUS: continues => " + vars.continues + ", lifes => " + vars.lifes);
	}
   
   	if(vars.fatcat_unstunned == 0 && current.fatcat_stun == 0)
	{
		print("ASL FATCAT UNSTUNNED");
		vars.fatcat_unstunned = 1;
	}
	
	// split after boss stage cleared (fatcat not included)
	if(vars.started == 1 && current.boss_cleared > old.boss_cleared)
	{
		print("ASL BOSS SPLIT");
		return(true);
	}
	else if(vars.ready_for_fatcat == 0 && ((current.boss_cleared == 981 && old.boss_cleared == 981) || (current.boss_cleared == 1023 && old.boss_cleared == 1023)) && current.fatcat_stun == 0)
	{
		print("ASL READY FOR FAT CAT!!!");  
		vars.ready_for_fatcat = 1;
		
		return(false);	
	}
	else if(vars.ready_for_fatcat == 1 && vars.fatcat_unstunned == 1 && current.fatcat_stun != 0 && vars.fatcat_hits < 5)
	{
		vars.fatcat_unstunned = 0;
		vars.fatcat_hits++;
		print("ASL FATCAT HIT!!! HITS : " + vars.fatcat_hits + "/5");
		
		return(false);
	}
	// split after fatrat disappears
	else if(vars.started == 1 && vars.fatcat_hits == 5)
	{
		print("ASL FATCAT DED!!!");
		vars.started = 0;
		vars.ready_for_fatcat = 0;
		vars.fatcat_hits = 0;
		
		return(true);
	}
	else
		return(false); 
}

init  
{
	print("ASL INIT");
	vars.fatcat_hits = 0;
	vars.fatcat_unstunned = 1;
	vars.ready_for_fatcat = 0;
	vars.flag_reset = 0;
	vars.continues = 3;
	
	if(settings.StartEnabled)
		vars.started = 0; 
	else
	{
		vars.started = 1;
		vars.fatcat_hits = 0;
		vars.lifes = 2;
		vars.continues = 3;
		vars.flag_reset = 0;
	}
}

start
{
	if(timer.CurrentPhase == TimerPhase.NotRunning)
		print("not running");

	//print(timer.CurrentPhase);

	//print("ASL vars.started : " + vars.started);
	//print("ASL current.boss_cleared : " + current.boss_cleared);
	//print("ASL current.flag_start : " + current.flag_start);
	print("ASL Checking for START() boss_cleared : " + current.boss_cleared + ", flag_start : " + current.flag_start + ", vars.started : " + vars.started);
	
	if(current.boss_cleared == 0 && current.flag_start != 0 && vars.started == 0)
	{
		vars.started = 1;
		vars.fatcat_hits = 0;
		vars.lifes = 2;
		vars.continues = 3;
		vars.flag_reset = 0;
		
		print("ASL START");
		print("ASL STATUS: continues => " + vars.continues + ", lifes => " + vars.lifes);
		
		return(true);
	}
}

reset
{
	if(vars.flag_reset == 1)
		return(true);
		
	//	1) reload nes or savestate to menu
	if(vars.started == 1 && current.boss_cleared == 0 && current.flag_start == 0 && current.flag_start2 != 85)
	{
		print("ASL RESET1");
		//print("boss_cleared : " + current.boss_cleared.ToString() + "\nflag_start : " + current.flag_start.ToString() + "\nflag_start2 : " + current.flag_start2.ToString()+ "\nvars.started : " + vars.started.ToString());
		vars.started = 0;
		vars.fatcat_hits = 0;
		return(true);
	}
	//	2) load a previous level
	else if(vars.started == 1 && current.boss_cleared < old.boss_cleared)
	{
		print("ASL RESET2");
		vars.started = 0;
		vars.fatcat_hits = 0;
		return(true);
	}
	else
		return(false); 
}

startup
{
	refreshRate = 70;
	
	settings.Add("main", false, "Chip 'N Dale AutoSplitter 0.03");
	settings.Add("main3", false, "--https://github.com/saturnin55/ChipnDaleAutoSplitter", "main");
	settings.Add("main2", false, "--MAY NOT WORK IN 2-PLAYER MODE!!!", "main");
	settings.Add("main1", false, "--Currently only support FCEUX emulator", "main");
}
