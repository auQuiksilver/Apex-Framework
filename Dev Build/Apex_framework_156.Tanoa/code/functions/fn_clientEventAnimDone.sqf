/*
File: fn_clientEventAnimDone.sqf
Author: 

	Quiksilver
	
Last modified:

	3/01/2015 ArmA 1.54 by Quiksilver
	
Description:

	Anim Done event
___________________________________________________________________*/

if (!(player getVariable ['QS_animDone',FALSE])) then {
	player setVariable ['QS_animDone',TRUE,FALSE];
};