/*
File: fn_clientInteractRelease.sqf
Author:

	Quiksilver
	
Last Modified:

	29/11/2022 A3 2.10 by Quiksilver
	
Description:

	-
_________________________________________*/

private _released = FALSE;
private _unit = objNull;
private _cursorTarget = cursorTarget;
private _anim = '';
private _object = objNull;
_attachedObjects = (attachedObjects QS_player) select {!isObjectHidden _x};
if (_attachedObjects isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			if (_x isKindOf 'CAManBase') then {
				_unit = _x;
				if (!alive _unit) exitWith {
					_released = TRUE;
					[0,_unit] call QS_fnc_eventAttach;
					['switchMove',QS_player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				};
				if ((animationState _unit) in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still','acts_injuredlyingrifle02','ainjppnemstpsnonwnondnon']) then {
					50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					_released = TRUE;
					[0,_unit] call QS_fnc_eventAttach;
					QS_player playAction 'released';
					['switchMove',_unit,(['','acts_InjuredLyingRifle02'] select ((lifeState _unit) isEqualTo 'INCAPACITATED'))] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					['setDir',_unit,((getDir _unit) + 180)] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
					_unit setVariable ['QS_animDone',FALSE,TRUE];
					for '_x' from 0 to 1 step 1 do {
						_unit setVariable ['QS_RD_draggable',TRUE,TRUE];
						_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
						QS_player setVariable ['QS_RD_interacting',FALSE,TRUE];
					};
				} else {
					if ((animationState _unit) in [
						'ainjpfalmstpsnonwrfldnon_carried_up','ainjpfalmstpsnonwnondf_carried_dead',
						'ainjpfalmstpsnonwnondnon_carried_up','ainjpfalmstpsnonwrfldnon_carried_still','ainjppnemstpsnonwnondnon',
						'ainjpfalmstpsnonwnondnon_carried_still'
					]) then {
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
						_released = TRUE;
						[0,_unit] call QS_fnc_eventAttach;
						QS_player switchMove '';
						[8,_unit,(getDir QS_player) + 90,(['','acts_InjuredLyingRifle02'] select ((lifeState _unit) isEqualTo 'INCAPACITATED')),QS_player,'',(QS_player modelToWorldWorld [0,1,0.75])] remoteExec ['QS_fnc_remoteExec',0,FALSE];
						QS_player setVariable ['QS_RD_interacting',FALSE,TRUE];
					} else {
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
						_released = TRUE;
						[0,_unit] call QS_fnc_eventAttach;
						if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
							['switchMove',_unit,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							for '_x' from 0 to 1 step 1 do {
								_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
								QS_player setVariable ['QS_RD_interacting',FALSE,TRUE];
							};
						} else {
							['switchMove',_unit,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						};
					};
				};
				if ((_unit distance (markerPos 'QS_marker_medevac_hq')) < 10) then {
					if !(_unit isNil 'QS_aoTask_medevac_unit') then {
						if (_unit getVariable 'QS_aoTask_medevac_unit') then {
							_unit spawn {
								uiSleep 10;
								if (!isNull _this) then {
									[17,_this] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								};
							};
							_unit setVariable ['QS_aoTask_medevac_unit',FALSE,TRUE];
							[46,[player,3]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',[localize 'STR_QS_Notif_034','3']] call (missionNamespace getVariable 'QS_fnc_showNotification');
						};
					};
				};
				if (_unit getVariable ['QS_RD_escorted',FALSE]) then {
					50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					_released = TRUE;
					[0,_unit] call QS_fnc_eventAttach;
					0 = ['switchMove',_unit,(_unit getVariable ['QS_RD_storedAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					for '_x' from 0 to 1 step 1 do {
						if (!isPlayer _unit) then {
							_unit setVariable ['QS_RD_escorted',FALSE,TRUE];
							_unit setVariable ['QS_RD_escortable',TRUE,TRUE];
						};
						_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
						QS_player setVariable ['QS_RD_interacting',FALSE,TRUE];
					};
					if (_unit isNotEqualTo (missionNamespace getVariable 'QS_sideMission_POW')) then {
						if ((QS_player distance2D (missionNamespace getVariable ['QS_prisonPos',(markerPos 'QS_marker_gitmo')])) < 20) then {
							50 cutText [localize 'STR_QS_Text_121','PLAIN DOWN',0.3];
							_prisonPos = missionNamespace getVariable ['QS_prisonPos',[0,0,0]];
							_unit setPos [((_prisonPos # 0) + 2 - (random 4)),((_prisonPos # 1) + 2 - (random 4)),0];
							_unit forceAddUniform 'U_C_WorkerCoveralls';
							_unit setVariable ['QS_RD_escortable',FALSE,TRUE];
							if (local _unit) then {
								_unit setDir (random 360);
							} else {
								['setDir',_unit,(random 360)] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
							};
							_text = format ['%1 %2',profileName,localize 'STR_QS_Chat_092'];
							['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							missionNamespace setVariable ['QS_prisoners',((missionNamespace getVariable 'QS_prisoners') + [_unit]),TRUE];
							[92,_unit,EAST,TRUE] remoteExec ['QS_fnc_remoteExec',2,FALSE];							
							[60,[['PRISONER',getPlayerUID player,profileName,1],['PRISONER',((_unit getVariable 'QS_captor') # 0),((_unit getVariable 'QS_captor') # 1),1],[player,1]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',[(format ['%1 %2',worldName,localize 'STR_QS_Notif_040']),'1']] call (missionNamespace getVariable 'QS_fnc_showNotification');
						};
					};
				};
			} else {
				_object = _x;
				if (
					([0,_object,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) || 
					{(_object isKindOf 'StaticWeapon')}
				) then {
					if (!([_object] call (missionNamespace getVariable 'QS_fnc_isBoundingBoxIntersected'))) then {
						private _position = getPosWorld _object;
						if (_object isKindOf 'StaticWeapon') then {
							_position = _position vectorAdd [0,0,0.1];
						};
						_positionATL = getPosATL _object;
						if (isDamageAllowed QS_player) then {
							QS_player allowDamage FALSE;
							0 spawn {uiSleep 1;QS_player allowDamage TRUE;};
						};
						_released = TRUE;
						[0,_object] call QS_fnc_eventAttach;
						_object setPosWorld _position;
						if ((_positionATL # 2) < 1.75) then {
							_object setVectorUp (surfaceNormal _position);
						} else {
							_object setVectorUp [0,0,1];
						};
						uiSleep 0.1;
						['awake',_object,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					} else {
						50 cutText [localize 'STR_QS_Text_120','PLAIN DOWN',0.5];
					};
				} else {
					50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					_released = TRUE;
					_position = getPosWorld _object;
					_positionATL = getPosATL _object;
					if (isDamageAllowed QS_player) then {
						QS_player allowDamage FALSE;
						0 spawn {uiSleep 1;QS_player allowDamage TRUE;};
					};
					[0,_object] call QS_fnc_eventAttach;
					_object setPosWorld _position;
					if ((_positionATL # 2) < 1.75) then {
						_object setVectorUp (surfaceNormal _position);
					} else {
						_object setVectorUp [0,0,1];
					};
					uiSleep 0.1;
					_simulation = QS_hashmap_configfile getOrDefaultCall [
						format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
						{(toLowerANSI (getText ((configOf _object) >> 'simulation')))},
						TRUE
					];
					if ((toLowerANSI _simulation) in ['thingx']) then {
						['awake',_object,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_object,FALSE];
						if (local _object) then {
							_object setVelocity [0,0,-1];
						} else {
							['setVelocity',_object,[0,0,-1]] remoteExec ['QS_fnc_remoteExecCmd',_object,FALSE];
						};
					};
				};
			};
		};
		if (_released) exitWith {};
	} forEach _attachedObjects;
};
if (_released) then {
	if (isForcedWalk QS_player) then {
		QS_player forceWalk FALSE;
	};
};
_released;