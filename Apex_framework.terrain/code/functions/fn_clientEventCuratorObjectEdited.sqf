/*/
File: fn_clientEventCuratorObjectEdited.sqf
Author:

	Quiksilver
	
Last modified:

	24/05/2023 A3 2.12 by Quiksilver
	
Description:

	Event Curator Object Edited
__________________________________________________/*/

params ['_module','_entity'];
if (_entity isKindOf 'cargoplatform_01_base_f') then {
	[_entity,TRUE,TRUE,1] call QS_fnc_logisticsPlatformSnap;
};