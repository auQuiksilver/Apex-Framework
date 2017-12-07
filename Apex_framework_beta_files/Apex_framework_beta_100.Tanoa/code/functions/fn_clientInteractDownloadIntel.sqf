/*
File: fn_clientInteractDownloadIntel.sqf
Author:

	Quiksilver
	
Last Modified:

	28/09/2015 ArmA 3 1.50
	
Description:

	-
_____________________________________________________________*/

_intel = _this select 0;
player playMoveNow 'AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon';
for '_x' from 0 to 2 step 1 do {
	_intel setVariable ['QS_RD_mission_KISS_stage_1',FALSE,TRUE];
};
playSound 'ClickSoft';
true;