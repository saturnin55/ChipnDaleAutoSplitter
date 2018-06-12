## ChipnDaleAutoSplitter
 
Auto Splitter for Chip n'Dale NES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - FCEUX 2.2.3
 - Let me know if you need support for another emulator
 
## Features

- Automatically start the timer when you start a run. Timer starts after selecting the character (Chip or Dale)
- Automatically reset the timer when you restart the game (or load a savestate of a level before the current level)
- Automatically split when the FatCat disappears after the 5th hit
- Supports both Any% and All Zones

## Installation 

(this won't work until the autosplitter is published to the official livesplit repo)

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Desactivate"

## Manual Installation

- Edit Layout
- Add Other /Scriptable Componment / Select chipndale.asl
  
## Set-up

- Go to "Edit Splits..." in LiveSplit
- Click "Settings" to configure the autosplitter
  - **Note:** If for some reason LiveSplit does not automatically load the script, click "Browse...", navigate to "\LiveSplit\Components\" and select the appropriate script.
  
Here you can enable/disable the options for auto start, auto reset, and auto splitting.

## BUGS

- Sometimes,the autosplitter will double split at the Spaceship. I haven't figured out how to fix that yet. It doesn't happen often, but when it happen, undo the last split.
- Probably doesn't work well in 2-player mode
- Sometimes the timer will start automatically when the demo starts. To fix, just manually start the timer and then hit alt-r to reset the console

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [saturnin55](http://twitch.tv/saturnin55) or saturnin55#2730 on Discord
