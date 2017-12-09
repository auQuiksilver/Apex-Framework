/*/
File: arsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	9/12/2017 A3 1.80 by Quiksilver
	
Description:

	Arsenal whitelisting (WIP)
	
Notes:

	This file is currently unused and is not compiled by the engine.
	This file may be used in the future for comprehensive arsenal gear whitelisting, both in general and also by class.
	Currently gear restrictions are done in a number of files, and we would like to tie them all back here for easy editing.
	
	Locations for gear restriction configuration currently:
	
		"code\functions\fn_clientCore.sqf" - lines 711-792
		"code\functions\fn_clientEventArsenalClosed.sqf" - lines 52-55
		"code\functions\fn_clientEventArsenalOpened.sqf" - lines 25-28
		
	Arsenal function is called from:
	
		"code\functions\fn_clientInteractArsenal.sqf"
_______________________________________________________/*/