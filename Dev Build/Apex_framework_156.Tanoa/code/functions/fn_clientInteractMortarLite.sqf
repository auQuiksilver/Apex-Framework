/*/
File: fn_clientInteractMortarLite.sqf
Author:

	Quiksilver
	
Last modified:

	29/12/2022 A3 2.10 by Quiksilver
	
Description:
	
	Lightweight Mortar
_______________________________________________/*/

_mortarTubes = ['mortar_tubes_1'] call QS_data_listItems;
_unit = player;
if (
	(alive (_unit getvariable ['QS_mortar_lite',objNull]))
) exitWith {
	50 cutText [localize 'STR_QS_Text_314','PLAIN',0.5];
};
if (!((toLowerANSI (backpack _unit)) in _mortarTubes)) exitWith {};
([_unit,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
	50 cutText [localize 'STR_QS_Text_067','PLAIN',0.5];
};
_unit playAction 'PutDown';
uiSleep 0.7;
removeBackpack _unit;
_mortarType = ['player_mortarlite_01'] call QS_data_listVehicles;
_mortar = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _mortarType,_mortarType],[0,0,0]];
_mortar setPosWorld (_unit modelToWorldWorld [0,2,1]);
[player,_mortar,FALSE,TRUE] call QS_fnc_unloadCargoPlacementMode;
_mortar allowDamage FALSE; _mortar spawn {sleep 3; _this allowDamage TRUE; };
private _mag = '';
{
	if (_mag isEqualTo '') then {
		_mag = _x;
	};
	_mortar removeMagazineTurret [_x,[0]];
} forEach (_mortar magazinesTurret [0]);
_mortar addMagazineTurret [_mag,[0]];
_mortar enableWeaponDisassembly FALSE;
_mortar addEventHandler [
	'GetOut',
	{
		_vehicle = _this # 0;
		if (_vehicle getVariable ['QS_entity_destroyOnExit',FALSE]) then {
			_vehicle spawn {
				sleep 1;
				_this setDamage [1,FALSE];
			};
		};
	}
];
{
	_mortar setVariable _x;
} forEach [
	['QS_services_reammo_disabled',TRUE,TRUE],
	['QS_RD_draggable',TRUE,TRUE],
	['QS_mortar_lite',TRUE,TRUE]
];
_unit setVariable ['QS_mortar_lite',_mortar,TRUE];
[59,[_mortar]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
_mortar lock 0;