/*/
File: fn_clientEventCuratorSelectionPresetSaved.sqf
Author:

	Quiksilver
	
Last modified:

	17/09/2023 A3 2.14 by Quiksilver
	
Description:

	Selection Preset Saved Event
__________________________________________________/*/

params ['_curator','_numkey'];
50 cutText [format [localize 'STR_QS_Text_472',_numkey],'PLAIN DOWN',0.25];