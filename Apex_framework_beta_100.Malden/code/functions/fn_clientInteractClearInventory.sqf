/*
File: fn_clientInteractClearInventory.sqf
Author:

	Quiksilver
	
Last modified:
	
	29/12/2015 ArmA 1.54 by Quiksilver
	
Description:

	Clear Inventory Action
_______________________________________________________*/

_v = vehicle player;
clearItemCargoGlobal _v;
clearMagazineCargoGlobal _v;
player setVariable ['QS_action_inventoryCleared',(time + 30),FALSE];
