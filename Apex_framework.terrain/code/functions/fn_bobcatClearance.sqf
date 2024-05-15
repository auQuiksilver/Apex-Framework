/*
File: fn_bobcatClearance.sqf
Author:

	Quiksilver
	
Last Modified:

	16/09/2023 A3 2.14
	
Description:

	Bobcat clearance module
__________________________________________*/

params ['_mode'];
if (_mode isEqualTo 'INIT') then {
	0 spawn {
		sleep 0.5;
		_cameraOn = cameraOn;
		missionNamespace setVariable [
			'QS_action_plow',
			(
				_cameraOn addAction [
					localize 'STR_QS_Interact_061',
					{
						_v = cameraOn;
						_animPhase = _v animationSourcePhase 'MovePlow';
						private _soundSource = '';
						private _timeout = -1;
						if (_animPhase isEqualTo 1) then {
							50 cutText [localize 'STR_QS_Text_017','PLAIN DOWN',0.25];
							_v animateSource ['MovePlow',0,0.9];
							_soundSource = createSoundSource ['SoundPlowUp',(_v modelToWorld (_v selectionPosition 'plow')),[],0];
							[1,_soundSource,[_v,(_v selectionPosition 'plow')]] call QS_fnc_eventAttach;
							_timeout = diag_tickTime + 8;
							waitUntil {
								uiSleep 0.1;
								((diag_tickTime > _timeout) || (!alive _v) || ((_v animationSourcePhase 'MovePlow') isEqualTo 0))
							};
							uiSleep 0.1;
							deleteVehicle _soundSource;
						} else {
							50 cutText [localize 'STR_QS_Text_018','PLAIN DOWN',0.25];
							_v animateSource ['MovePlow',1,0.9];
							_soundSource = createSoundSource ['SoundPlowDown',(_v modelToWorld (_v selectionPosition 'plow')),[],0];
							[1,_soundSource,[_v,(_v selectionPosition 'plow')]] call QS_fnc_eventAttach;
							_timeout = diag_tickTime + 8;
							waitUntil {
								uiSleep 0.1;
								((diag_tickTime > _timeout) || (!alive _v) || ((_v animationSourcePhase 'MovePlow') isEqualTo 1))
							};
							uiSleep 0.1;
							deleteVehicle _soundSource;
						};
					},
					nil,
					0,
					FALSE,
					TRUE,
					'',
					'
						(call {
							_c = TRUE;
							_v = cameraOn;
							if (_v isNotEqualTo _originalTarget) exitWith {_originalTarget removeAction _actionId};
							if (_v isKindOf "b_apc_tracked_01_crv_f") then {
								if (local _v) then {
									_animPhase = _v animationSourcePhase "MovePlow";
									if (_animPhase in [0,1]) then {
										if (((_v actionParams QS_action_plow) # 0) isEqualTo (localize "STR_QS_Interact_061")) then {
											if (_animPhase isEqualTo 1) then {
												_v setUserActionText [QS_action_plow,(localize "STR_QS_Interact_062"),format ["<t size=""3"">%1</t>",(localize "STR_QS_Interact_062")]];
											};
										} else {
											if (_animPhase isEqualTo 0) then {
												_v setUserActionText [QS_action_plow,(localize "STR_QS_Interact_061"),format ["<t size=""3"">%1</t>",(localize "STR_QS_Interact_061")]];
											};
										};
									};
								};
							};
							_c;
						})
					',
					-1,
					FALSE,
					''
				]
			),
			FALSE
		];
		_cameraOn setUserActionText [(missionNamespace getVariable 'QS_action_plow'),((_cameraOn actionParams (missionNamespace getVariable 'QS_action_plow')) # 0),(format ["<t size='3'>%1</t>",((_cameraOn actionParams (missionNamespace getVariable 'QS_action_plow')) # 0)])];
	};
	QS_EH_bobcat = addMissionEventHandler [
		'EachFrame',
		{
			_cameraOn = cameraOn;
			if !(_cameraOn isKindOf 'B_APC_Tracked_01_CRV_F') exitWith {
				removeMissionEventHandler [_thisEvent,_thisEventHandler];
				['EXIT'] call QS_fnc_bobcatClearance;
			};
			if (
				(alive _cameraOn) &&
				{(local _cameraOn)} &&
				{((_cameraOn animationSourcePhase 'MovePlow') isEqualTo 1)}
			) then {
				_posInFront = _cameraOn modelToWorld [0,7.1,0];
				_listOfFrontStuff = (_posInFront nearObjects ['All',7]) + (nearestObjects [_posInFront,[],7]);
				_array = lineIntersectsSurfaces [
					(_cameraOn modelToWorldWorld (_cameraOn selectionPosition 'plow')),
					(AGLToASL _posInFront),
					_cameraOn,
					objNull,
					TRUE,
					-1, 
					'GEOM',
					'VIEW',
					TRUE
				];
				{
					if (
						(!isNull (_x # 3)) &&
						{(!alive (_x # 3))} &&
						{((_x # 3) isKindOf 'AllVehicles')}
					) then {
						_listOfFrontStuff pushBackUnique (_x # 3);
					};
				} forEach _array;
				_mines = nearestMines [_posInFront,[],7];
				if (_mines isNotEqualTo []) then {
					{
						triggerAmmo _x;
						_x setDamage [1,TRUE];
						if (diag_tickTime > (uiNamespace getVariable ['QS_genericCooldown_5',-1])) then {
							uiNamespace setVariable ['QS_genericCooldown_5',diag_tickTime + 5];
							[46,[QS_player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',[localize 'STR_QS_Notif_159','1']] call QS_fnc_showNotification;
						};
					} forEach _mines;
				};
				if (_listOfFrontStuff isNotEqualTo []) then {
					_QS_toDelete = [];
					_craterDecals = ['crater_decals_1'] call QS_data_listOther;
					_allDead = allDead;
					{
						_obj = _x;
						_objType = typeOf _obj;
						if (
							(!isNull _obj) &&
							{(!alive _obj)} &&
							{(_obj in _allDead)}
						) then {
							_QS_toDelete pushBack _obj;
						};
						if ((_craterDecals findIf { _obj isKindOf _x }) isNotEqualTo -1) then {
							_QS_toDelete pushBack _obj;
							if (diag_tickTime > (uiNamespace getVariable ['QS_genericCooldown_5',-1])) then {
								uiNamespace setVariable ['QS_genericCooldown_5',diag_tickTime + 5];
								[46,[QS_player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								['ScoreBonus',[format ['%2 %1',worldName,localize 'STR_QS_Notif_041'],'1']] call QS_fnc_showNotification;
							};
						};
						if ((['WeaponHolder','WeaponHolderSimulated','GroundWeaponHolder'] findIf { _obj isKindOf _x }) isNotEqualTo -1) then {
							_QS_toDelete pushBack _obj;
						};
						if (
							(_obj isKindOf 'Land_Razorwire_F') &&
							{((damage _obj) < 1)}
						) then {
							_obj setDamage [1,TRUE];
						};
					} forEach _listOfFrontStuff;
					if (_QS_toDelete isNotEqualTo []) then {
						deleteVehicle _QS_toDelete;
						_QS_toDelete = [];
					};
				};
			};
			
		}
	];
};
if (_mode isEqualTo 'EXIT') exitWith {
	
};