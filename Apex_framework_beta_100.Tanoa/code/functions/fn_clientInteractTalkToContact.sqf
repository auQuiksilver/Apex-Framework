/*
File: fn_clientInteractTalkToContact.sqf
Author:

	Quiksilver
	
Last Modified:

	28/09/2015 ArmA 3 1.50
	
Description:

	-
_____________________________________________________________*/

_contact = _this select 0;
player playActionNow 'GestureHi';
for '_x' from 0 to 2 step 1 do {
	_contact setVariable ['QS_RD_mission_KISS_stage_2',FALSE,TRUE];
};