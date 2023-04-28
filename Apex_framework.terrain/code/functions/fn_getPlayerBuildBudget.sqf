/*
File: fn_getPlayerBuildBudget.sqf
Author:

	Quiksilver
	
Last Modified:

	24/02/2023 A3 2.12 by Quiksilver
	
Description:

	Budget for player buildables
__________________________________________*/

params ['_unit'];
// engineer
if (_unit getUnitTrait 'engineer') exitWith {
	10
};
// mortar gunner
if (_unit getUnitTrait 'QS_trait_gunner') exitWith {
	4
};
// rifleman
if (_unit getUnitTrait 'QS_trait_rifleman') exitWith {
	1
};
// other roles
0;