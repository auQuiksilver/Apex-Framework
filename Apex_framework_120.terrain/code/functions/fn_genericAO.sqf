/*/
File: fn_genericAO.sqf
Author:

	Quiksilver
	
Last modified:

	24/03/2018 A3 1.82 by Quiksilver
	
Description:

	Generic AO
	
Notes:

	1. Enemy inf patrols
	2. Enemy vic patrols
__________________________________________________/*/

params [
	['_centerPos',[0,0,0],[[]]],
	['_centerRad',300,[0]],
	['_markerText','',['']],
	['_enemyData',[],[[]]]
];
_terrainData = [3,_centerPos,_centerRad,[]] call (missionNamespace getVariable 'QS_fnc_aoGetTerrainData');