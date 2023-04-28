/*/
File: fn_clientEventCuratorObjectEdited.sqf
Author:

	Quiksilver
	
Last modified:

	16/02/2023 A3 2.12 by Quiksilver
	
Description:

	Event Curator Object Edited
__________________________________________________/*/

params ['_module','_entity'];
if (_entity isKindOf 'CargoPlatform_01_base_F') then {
	[_entity,FALSE,TRUE] call QS_fnc_logisticsPlatformSnap;
	for '_ii' from 1 to 4 step 1 do {
		_entity animate [format ["Leg_%1_move",_ii],linearConversion [0.25,6.541,((_entity animationPhase (format ["leg_%1_move",_ii])) - ((_entity modelToWorldVisual (_entity selectionPosition (format ["block%1_pos",_ii]))) # 2)),0,1,TRUE],TRUE];
	};
};