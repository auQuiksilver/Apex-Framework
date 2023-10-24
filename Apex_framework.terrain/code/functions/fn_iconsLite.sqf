/*/
File: fn_iconsLite.sqf
Author:

	Quiksilver
	
Last Modified:

	17/02/2023 A3 2.12 by Quiksilver
	
Description:

	Lightweight Map Icons alternative
_______________________________________________/*/

if (_this isEqualTo 'init') exitWith {
	uiNamespace setVariable ['QS_mapDrawType',objNull];							// Draw type: switch to grpNull for groups only
	((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers 'Draw';		// Remove existing
	((findDisplay 12) displayctrl 51) ctrlAddEventHandler [						// Apply liteweight
		'Draw',
		{call QS_fnc_iconsLite}
	];
};
params ['_map'];
if (diag_tickTime > (uiNamespace getVariable ['QS_mapListInterval',-1])) then {
	uiNamespace setVariable ['QS_mapListInterval',diag_tickTime + 5];				// 5 seconds interval
	uiNamespace setVariable [														// cache side color incase side changes
		'QS_mapListSideColor',
		([
			[0.7,0.6,0,0.5],
			[0.5,0,0,0.65],
			[0,0.3,0.6,0.65],
			[0,0.5,0,0.65],
			[0.4,0,0.5,0.65],
			[0.7,0.6,0,0.5]
		] # (([sideUnknown, east, west, independent, civilian, sideUnknown] find ((missionNamespace getVariable ['QS_player',player]) getVariable ['QS_unit_side',WEST])) max 0))
	];
	if ((uiNamespace getVariable ['QS_mapDrawType',objNull]) isEqualType objNull) then {
		uiNamespace setVariable ['QS_mapList',units ((missionNamespace getVariable ['QS_player',player]) getVariable ['QS_unit_side',WEST])];
	} else {
		uiNamespace setVariable ['QS_mapList',groups ((missionNamespace getVariable ['QS_player',player]) getVariable ['QS_unit_side',WEST])];
	};
};
// Icon color for players side
_mapDir = ctrlMapDir _map;
_color = uiNamespace getVariable ['QS_mapListSideColor',[1,1,1,0.5]];
_drawObjects = (uiNamespace getVariable ['QS_mapDrawType',objNull]) isEqualType objNull;
private _leader = objNull;
// Draw
{
	if (_drawObjects) then {
		_leader = _x;
	} else {
		_leader = leader _x;
	};
	_map drawIcon [
		'a3\ui_f\data\map\vehicleicons\iconMan_ca.paa',
		_color,
		getPosWorldVisual _leader,
		22,
		22,
		_mapDir + (getDirVisual _leader),
		(if (_x isEqualType objNull) then {['',(name _leader)] select (_leader isEqualTo (effectiveCommander (vehicle _leader)))} else {(groupId _x)}),
		1,
		0.035,
		'puristaMedium',
		'right'
	];
} forEach (uiNamespace getVariable ['QS_mapList',[]]);