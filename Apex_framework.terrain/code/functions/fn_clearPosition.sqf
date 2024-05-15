/*
File: fn_clearPosition.sqf
Author: 

	Quiksilver
	
Last modified:

	1/02/2016 A3 1.54 by Quiksilver

Description: 

	Clear position of obstructions that could cause ArmA 3 signature spontaneous combustion.
	Send obstructions to safe positions nearby
_________________________________________________________________*/

params ['_pos','_rad','_minDist','_maxDist'];
private [
	'_obstructions','_obstructionsArray','_obstructions2Array',
	'_emptyPosition'
];
deleteVehicle (allDead inAreaArray [_pos,_rad,_rad]);
_obstructions = ['Air','LandVehicle','StaticWeapon','Ship'];
_obstructionsArray = _pos nearEntities [_obstructions,_rad];
if (_obstructionsArray isNotEqualTo []) then {
	{
		_emptyPosition = _pos findEmptyPosition [_minDist,_maxDist,'O_APC_Tracked_02_AA_F'];
		if (_emptyPosition isEqualTo []) then {
			for '_x' from 0 to 49 step 1 do {
				_emptyPosition = _pos findEmptyPosition [_minDist,_maxDist,'O_APC_Tracked_02_AA_F'];
				if (_emptyPosition isNotEqualTo []) exitWith {};
			};
		};
		_x setPos _emptyPosition;
	} count _obstructionsArray;
};
TRUE;