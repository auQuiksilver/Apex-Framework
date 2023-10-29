/*
File: fn_clientInteractForceDismount.sqf
Author:

	Quiksilver
	
Last Modified:

	14/2/2023 A3 2.12
	
Description:

	Force AI units to Mount/Dismount
	
	(groupSelectedUnits player)
_______________________________________*/
if (diag_tickTime < (uiNamespace getVariable ['QS_ui_genericCooldown',-1])) exitWith {50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.5];};
uiNamespace setVariable ['QS_ui_genericCooldown',diag_tickTime + 2];
_cameraOn = cameraOn;
params ['',['_radius',sizeOf (typeOf _cameraOn)],['_allowPlayers',FALSE]];
private _selectedUnits = groupSelectedUnits QS_player;
private _crew = [];
if (
	(alive _cameraOn) &&
	{(local _cameraOn)} &&
	{(!unitIsUAV _cameraOn)} &&
	{((['Plane','Helicopter','LandVehicle','Ship'] findIf { _cameraOn isKindOf _x }) isNotEqualTo -1)}
) then {
	_crew = (fullCrew [_cameraOn,'cargo']) apply {_x # 0};
	if (_selectedUnits isNotEqualTo []) then {
		_crew = _selectedUnits select {_x in _crew};
	};
	if (_crew isNotEqualTo []) then {
		_cameraOn setUnloadInCombat [TRUE,FALSE];
		private _val = 0;
		{
			if ((!isPlayer _x) || _allowPlayers) then {
				if (isPlayer _x) then {
					if ((vectorMagnitude (velocity _cameraOn)) < 1) then {
						_val = _val + 1;
						unassignVehicle _x;
						_x moveOut _cameraOn;
					};
				} else {
					_val = _val + 1;
					unassignVehicle _x;
					_x moveOut _cameraOn;
				};
			};
		} forEach _crew;
		50 cutText [format [localize 'STR_QS_Text_382',_val],'PLAIN DOWN',0.5];
	} else {
		if (
			((locked _cameraOn) in [0,1]) &&
			{((_cameraOn emptyPositions 'cargo') > 0)}
		) then {
			_cameraOn setUnloadInCombat [FALSE,FALSE];
			_group = group (currentPilot _cameraOn);
			_crew = (_cameraOn nearEntities ['CAManBase',_radius]) select {
				(isNull (objectParent _x)) &&
				{(_x in (units _group))} &&
				{((!isPlayer _x) || _allowPlayers)} &&
				{(local _group)}
			};
			if (_selectedUnits isNotEqualTo []) then {
				_crew = _selectedUnits select { _x in _crew };
			};
			if (_crew isNotEqualTo []) then {
				_emptyPositions = _cameraOn emptyPositions 'cargo';
				private _val = 0;
				{
					if (_forEachIndex > _emptyPositions) exitWith {};
					_val = _val + 1;
					_x assignAsCargo _cameraOn;
					_x moveInCargo _cameraOn;
				} forEach _crew;
				50 cutText [format [localize 'STR_QS_Text_381',_val],'PLAIN DOWN',0.5];
			};
		};
	};
};