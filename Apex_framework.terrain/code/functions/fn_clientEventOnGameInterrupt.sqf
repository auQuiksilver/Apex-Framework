/*/
File: fn_clientEventOnGameInterrupt.sqf
Author: 

	Quiksilver
	
Last modified:

	30/04/2019 A3 1.92 by Quiksilver
	
Description:

	Game Interrupt event
______________________________________________/*/

params ['_display'];
if ((lifeState player) in ['HEALTHY','INJURED']) exitWith {

};