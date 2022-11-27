/*
File: fn_clientInteractRelease.sqf
Author:

	Quiksilver
	
Last Modified:

	26/11/2017 A3 1.78 by Quiksilver
	
Description:

	-
_____________________________________________________________*/

private ['_anim','_cursorTarget','_object'];
private _released = FALSE;
private _unit = objNull;
_cursorTarget = cursorTarget;
if ((attachedObjects player) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			if (_x isKindOf 'Man') then {
				_unit = _x;
				if (!alive _unit) exitWith {
					_released = TRUE;
					detach _unit;
					0 = ['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				};
				if ((animationState _unit) in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still','acts_injuredlyingrifle02','ainjppnemstpsnonwnondnon']) then {
					50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					_released = TRUE;
					detach _unit;
					player playAction 'released';
					['switchMove',_unit,(['','acts_InjuredLyingRifle02'] select ((lifeState _unit) isEqualTo 'INCAPACITATED'))] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					/*/if (isPlayer _unit) then {/*/
						['setDir',_unit,((getDir _unit) + 180)] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
					/*/};/*/
					_unit setVariable ['QS_animDone',FALSE,TRUE];
					for '_x' from 0 to 1 step 1 do {
						_unit setVariable ['QS_RD_draggable',TRUE,TRUE];
						_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
						player setVariable ['QS_RD_interacting',FALSE,TRUE];
					};
				} else {
					if ((animationState _unit) in [
						'ainjpfalmstpsnonwrfldnon_carried_up','ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwnondnon_carried_up','ainjpfalmstpsnonwrfldnon_carried_still','ainjppnemstpsnonwnondnon',
						'ainjpfalmstpsnonwnondnon_carried_still'
					]) then {
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
						_released = TRUE;
						detach _unit;
						_anim = ['AinjPfalMstpSnonWrflDnon_carried_down','AinjPfalMstpSnonWnonDnon_carried_down'] select ((primaryWeapon _unit) isEqualTo '');
						player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
						0 = [8,_unit,(getDir player),(['',_anim] select ((lifeState _unit) isEqualTo 'INCAPACITATED'))] remoteExec ['QS_fnc_remoteExec',0,FALSE];
						for '_x' from 0 to 1 step 1 do {
							_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
							player setVariable ['QS_RD_interacting',FALSE,TRUE];
						};
					} else {
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
						_released = TRUE;
						detach _unit;
						if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
							['switchMove',_unit,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							for '_x' from 0 to 1 step 1 do {
								_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
								player setVariable ['QS_RD_interacting',FALSE,TRUE];
							};
						} else {
							['switchMove',_unit,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						};
					};
				};
				if ((_unit distance (markerPos 'QS_marker_medevac_hq')) < 10) then {
					if (!isNil {_unit getVariable 'QS_aoTask_medevac_unit'}) then {
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
					detach _unit;
					0 = ['switchMove',_unit,(_unit getVariable ['QS_RD_storedAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					for '_x' from 0 to 1 step 1 do {
						if (!isPlayer _unit) then {
							_unit setVariable ['QS_RD_escorted',FALSE,TRUE];
							_unit setVariable ['QS_RD_escortable',TRUE,TRUE];
						};
						_unit setVariable ['QS_RD_interacting',FALSE,TRUE];
						player setVariable ['QS_RD_interacting',FALSE,TRUE];
					};
					if (_unit isNotEqualTo (missionNamespace getVariable 'QS_sideMission_POW')) then {
						if ((player distance2D (missionNamespace getVariable ['QS_prisonPos',(markerPos 'QS_marker_gitmo')])) < 20) then {
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
							_puid1 = getPlayerUID player;
							_pname1 = profileName;
							_puid2 = (_unit getVariable 'QS_captor') # 0;
							_pname2 = (_unit getVariable 'QS_captor') # 1;
							missionNamespace setVariable ['QS_prisoners',((missionNamespace getVariable 'QS_prisoners') + [_unit]),TRUE];
							[92,_unit,EAST,TRUE] remoteExec ['QS_fnc_remoteExec',2,FALSE];							
							[60,[['PRISONER',_puid1,_pname1,1],['PRISONER',_puid2,_pname2,1],[player,1]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',[(format ['%1 %2',worldName,localize 'STR_QS_Notif_040']),'1']] call (missionNamespace getVariable 'QS_fnc_showNotification');
						};
					};
				};
			} else {
				_object = _x;
				if (([0,_object,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) || {(_object isKindOf 'StaticWeapon')}) then {
					if (!(_object call (missionNamespace getVariable 'QS_fnc_isBoundingBoxIntersected'))) then {
						_position = getPosWorld _object;
						_positionATL = getPosATL _object;
						if (isDamageAllowed player) then {
							player allowDamage FALSE;
							0 spawn {uiSleep 1;player allowDamage TRUE;};
						};
						_released = TRUE;
						detach _object;
						player playAction 'released';
						_object setPosWorld _position;
						if ((_positionATL # 2) < 1.75) then {
							_object setVectorUp (surfaceNormal _position);
						} else {
							_object setVectorUp [0,0,1];
						};
						uiSleep 0.1;
						// Testing this
						['awake',_object,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						// Testing this

						/*/ credit: commy2 (ace3) for the below fix /*/
						/*/
						private _isDamageAllowed = isDamageAllowed _object;
						private _hitPointsDamages = getAllHitPointsDamage _object;
						if (_hitPointsDamages isEqualTo []) then {
							_hitPointsDamages = [[],[],[]];
						};
						_object setDamage [(damage _object),FALSE];
						if (!(_isDamageAllowed)) then {
							_object allowDamage TRUE;
						};
						uiSleep 0.1;
						{
							_object setHitIndex [_forEachIndex,_x];
						} forEach (_hitPointsDamages # 2);
						uiSleep 0.1;
						if (!(_isDamageAllowed)) then {
							_object allowDamage FALSE;
						};
						/*/
						
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.3];
					} else {
						50 cutText [localize 'STR_QS_Text_120','PLAIN DOWN',0.5];
					};
				};
			};
		};
		if (_released) exitWith {};
	} count (attachedObjects player);
};
if (_released) then {
	if (isForcedWalk player) then {
		player forceWalk FALSE;
	};
};
_released;