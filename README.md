## ChipnDaleAutoSplitter
 
Auto Splitter for Chip n'Dale NES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - FCEUX 2.2.3
 - Nestopia 1.40
 - Let me know if you need support for another emulator
 
## Features

- Automatically start the timer when you start a run. Timer starts after selecting the character (Chip or Dale)
- Automatically reset the timer when you restart the game (or load a savestate of a level before the current level)
- Automatically split when the FatCat disappears after the 5th hit
- Supports both Any% and All Zones

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Desactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/saturnin55/ChipnDaleAutoSplitter/master/chipndale.asl
- Edit Layout
- Add Other /Scriptable Componment / Script Path: Browse to the "chipndale.asl" file you downloaded previously
- Enable Start/Split/Reset feature here
  
## Set-up (if auto-installed)

- Go to "Edit Splits..." in LiveSplit
- Click "Settings" to configure the autosplitter
  - **Note:** If for some reason LiveSplit does not automatically load the script, click "Browse...", navigate to "\LiveSplit\Components\" and select the appropriate script.
- Enable Start/Split/Reset feature here
  
Here you can enable/disable the options for auto start, auto reset, and auto splitting.

## Bugs

- You need to disable the 'Reset' feature to do 2-player mode autosplitting
- Let me know of any bugs
- Support for BizHawk soon

## Thanks

- Thanks to [Kinnijup](http://twitch.tv/kinnijup) and [Moliman](http://twitch.tv/moliman22) for testing. 
- Thanks to [Zimond](http://twitch.tv/zimond) from the Classic Capcom (Speedruns) Discord for figuring out some ROM stuff!

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [saturnin55](http://twitch.tv/saturnin55) or saturnin55#2730 on Discord
