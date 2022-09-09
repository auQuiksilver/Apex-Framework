/*/
File: fn_clientInteractMedContainer.sqf
Author:

	Quiksilver
	
Last modified:

	20/04/2017 A3 1.68 by Quiksilver
	
Description:
	
	-
__________________________________________________________________________/*/

player playActionNow 'Medic';
0 spawn {
	uiSleep 4; 
	player setDamage 0;
	50 cutText [localize 'STR_QS_Text_117','PLAIN DOWN',0.2];
};