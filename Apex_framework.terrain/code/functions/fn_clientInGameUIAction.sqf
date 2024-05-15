/*/
File: fn_clientInGameUIAction.sqf
Author:

	Quiksilver
	
Last modified:

	9/11/2023 A3 2.14 by Quiksilver
	
Description:
	
	-
______________________________________________/*/

if (
	(_this isEqualTo []) ||
	{(!(diag_tickTime > (uiNamespace getVariable ['QS_client_uiLastAction',-1])))}
) exitWith {TRUE};
uiNamespace setVariable ['QS_client_uiLastAction',(diag_tickTime + 0.5)];
params [
	'_QS_actionTarget','_QS_player','_QS_actionIndex','_QS_actionName','_QS_actionText',
	'_QS_actionPriority','_QS_actionShownWindow','_QS_actionHiddenOnUse','_QS_actionShortcutName',
	'_QS_actionVisibility','_QS_actionEventName'
];
private _QS_c = FALSE;
_attachedObjects = (attachedObjects QS_player) select {!isObjectHidden _x};
if (((animationState QS_player) in (['medic_animations_1'] call QS_data_listOther)) && (!((toLower _QS_actionText) in [
	(toLower (localize 'STR_QS_Interact_065')),		// Cancel
	(toLower (localize 'STR_QS_Interact_010'))		// Release
]))) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.333];
	_QS_c = TRUE;
	_QS_c;
};
if (
	(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]) &&
	{(!((toLower _QS_actionText) in QS_ui_releaseActions))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.333];
	TRUE
};
if (!((lifeState QS_player) in ['HEALTHY','INJURED',''])) exitWith {
	50 cutText [localize 'STR_QS_Text_025','PLAIN DOWN',0.333];
	_QS_c = TRUE;
	_QS_c;
};
if (
	(QS_player call QS_fnc_isBusyAttached) &&
	{(!((toLower _QS_actionText) in QS_ui_releaseActions))} && 
	{(!(_QS_actionName in ['OpenParachute','BackFromUAV']))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.333];
	TRUE
};
getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
private _exit = FALSE;
private _text = '';
if (
	(_QS_actionName isEqualTo 'User') &&
	{(_QS_actionText isNotEqualTo '')} &&
	{((call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1)} &&
	{(!((getPlayerUID player) in (['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))}
) then {
	_whitelistedActions = call (missionNamespace getVariable 'QS_data_actions');
	if (
		(!(_QS_actionText in _whitelistedActions)) && 
		{(!(_QS_actionText in QS_client_dynamicActionText))}		// Remove this line if security is super important for you
	) then {
		_exit = TRUE;
		[
			40,
			[
				time,
				serverTime,
				(name player),
				profileName,
				profileNameSteam,
				(getPlayerUID player),
				2,
				(format ['Non-whitelisted scroll action text: "%1"',(_this # 4)]),
				player,
				productVersion
			]
		] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		_co = player;
		removeAllActions _co;
	};
};
if (_exit) exitWith {TRUE};
if (_QS_actionTarget getVariable ['QS_interaction_disabled',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_087','PLAIN DOWN',0.333];
	TRUE;
};
([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
if (
	(!isNull (isVehicleCargo _QS_actionTarget)) &&
	{((['LandVehicle','Air'] findIf { _QS_actionTarget isKindOf _x }) isNotEqualTo -1)} &&
	{(!(_QS_actionName in ['Gear','User']))} &&
	{(cameraOn isNotEqualTo _QS_actionTarget)}
) exitWith {TRUE};
if (
	(!isNull (attachedTo _QS_actionTarget)) &&
	{((attachedTo _QS_actionTarget) isKindOf 'CAManBase')}
) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.333];
	TRUE
};
if (
	((['Air','LandVehicle','Ship'] findIf { _QS_actionTarget isKindOf _x }) isNotEqualTo -1) &&
	{(_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE])}
) exitWith {
	50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];			// To do: Localize
	TRUE;
};
if (_QS_actionName isEqualTo 'GetInDriver') exitWith {
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	if (
		(!isNull (getTowParent _QS_actionTarget)) &&
		{(!isNull (ropeAttachedTo _QS_actionTarget))}
	) then {
		50 cutText [localize 'STR_QS_Text_343','PLAIN',0.333];
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (['GetIn',_QS_actionName,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if (
		(_attachedObjects isNotEqualTo []) &&
		{((_attachedObjects findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isNotEqualTo -1)}
	) then {
		50 cutText [localize 'STR_QS_Text_054','PLAIN DOWN',0.75];
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_c) exitWith {_QS_c;};
if (_QS_actionName isEqualTo 'HealSoldier') exitWith {
	if ((_attachedObjects findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isNotEqualTo -1) then {
		50 cutText [localize 'STR_QS_Text_055','PLAIN DOWN'];
		_QS_c = TRUE;
	};
	if ((lifeState _QS_actionTarget) isEqualTo 'INCAPACITATED') then {
		_QS_c = TRUE;
		50 cutText [(format ['%1 %2',(name _QS_actionTarget),localize 'STR_QS_Text_056']),'PLAIN DOWN'];
	};
	if !(_QS_actionTarget isNil 'QS_noHeal') then {
		_QS_c = TRUE;
		50 cutText [localize 'STR_QS_Text_057','PLAIN DOWN'];
	};
	if (!(_QS_c)) then {
		_QS_c = TRUE;
		if (isPlayer _QS_actionTarget) then {
			[63,[5,[(format [localize 'STR_QS_Text_260',profileName]),'PLAIN DOWN',0.5]]] remoteExec ['QS_fnc_remoteExec',_QS_actionTarget,FALSE];
		};
		player setVariable ['QS_treat_entryAnim',(animationState player),FALSE];
		player setVariable ['QS_treat_target',_QS_actionTarget,FALSE];
		_animEvent = player addEventHandler [
			'AnimDone',
			{
				params ['_unit','_anim'];
				if ((lifeState _unit) in ['HEALTHY','INJURED']) then {
					if (['medicdummyend',_anim,false] call (missionNamespace getVariable 'QS_fnc_inString')) then {
						_target = _unit getVariable ['QS_treat_target',objNull];
						if (!isNull _target) then {
							_unit setVariable ['QS_treat_target',objNull,FALSE];
							if (
								((_target distance _unit) <= 2.5) && 
								(isNull (objectParent _target)) && 
								((lifeState _target) in ['HEALTHY','INJURED'])
							) then {
								_fakIndex = ((items _unit) apply {toLowerANSI _x}) findAny QS_core_classNames_itemFirstAidKits;
								if (_fakIndex isNotEqualTo -1) then {
									_unit removeItem ((items _unit) # _fakIndex);
									_target setDamage [([0.25,0] select (_unit getUnitTrait 'medic')),TRUE];
								};
							};
						};
					};
				};
			}
		];
		player playActionNow 'MedicOther';
		[_QS_actionTarget,_animEvent] spawn {
			params ['_injured','_animEvent'];
			_timeout = diag_tickTime + 10;
			uiSleep 0.5;
			waitUntil {
				uiSleep 0.05;
				((isNull (player getVariable ['QS_treat_target',objNull])) || {(!((lifeState player) in ['HEALTHY','INJURED']))} || {(diag_tickTime > _timeout)} || {((_injured distance player) > 2.5)})
			};
			if ((_injured distance player) > 2.5) then {
				player setVariable ['QS_treat_target',objNull,FALSE];
				if ((lifeState player) in ['HEALTHY','INJURED']) then {
					_nearbyPlayers = allPlayers inAreaArray [QS_player,100,100,0,FALSE,-1];
					['switchMove',player,(player getVariable ['QS_treat_entryAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',_nearbyPlayers,FALSE];
				};
			};
			if (!isNull (player getVariable ['QS_treat_target',objNull])) then {
				player setVariable ['QS_treat_target',objNull,FALSE];
			};
			player removeEventHandler ['AnimDone',_animEvent];
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'LoadVehicle') exitWith {
	_QS_c = (((ropeAttachedObjects cameraOn) isNotEqualTo []) || {(!isNull (ropeAttachedTo cameraOn))});
	if (_QS_c) then {
		50 cutText [localize 'STR_QS_Text_316','PLAIN',0.5];
	};
	_QS_c;
};
if (
	(_QS_actionName isEqualTo 'Land') &&
	{(!(missionNamespace getVariable ['QS_missionConfig_autopilot',TRUE]))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_416','PLAIN DOWN',0.333];
	TRUE
};
if (_QS_actionName isEqualTo 'RepairVehicle') exitWith {
	if (((crew _QS_actionTarget) findIf {(alive _x)}) isNotEqualTo -1) then {
		{
			if ((side _x) in ([QS_player] call (missionNamespace getVariable 'QS_fnc_enemySides'))) exitWith {
				_QS_c = TRUE;
				50 cutText [localize 'STR_QS_Text_058','PLAIN',0.5];
			};
		} count (crew _QS_actionTarget);
	};
	if (!(_QS_c)) then {
		if !(_QS_actionTarget isNil 'QS_RD_noRepair') then {
			_QS_c = TRUE;
			50 cutText [localize 'STR_QS_Text_059','PLAIN DOWN'];
		} else {
			if (
				(!isNull (effectiveCommander _QS_actionTarget)) &&
				{(alive _QS_actionTarget)} &&
				{(isPlayer _QS_actionTarget)} &&
				{(_QS_actionTarget isNotEqualTo (vehicle QS_player))}
			) then {
				[63,[5,[(format [localize 'STR_QS_Text_261',profileName]),'PLAIN DOWN',0.5]]] remoteExec ['QS_fnc_remoteExec',(effectiveCommander _QS_actionTarget),FALSE];
			};
			if ((fuel (_this # 0)) isEqualTo 0) then {
				0 = [_this # 0] spawn {
					_v = _this # 0;
					uiSleep 5;
					if (local _v) then {
						_v setFuel (0.03 + (random 0.03));
					} else {
						['setFuel',_v,(0.03 + (random 0.03))] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
					};
					_dn = QS_hashmap_configfile getOrDefaultCall [
						format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _QS_actionTarget)],
						{getText ((configOf _QS_actionTarget) >> 'displayName')},
						TRUE
					];
					50 cutText [(format ['%1 %2',_dn,localize 'STR_QS_Text_060']),'PLAIN DOWN',0.75];
				};
			};
			if ((_this # 0) isKindOf 'Helicopter') then {
				(_this # 0) setHit ['tail_rotor_hit',0];
			};
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'UseMagazine') exitWith {
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
		50 cutText [localize 'STR_QS_Text_063','PLAIN'];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'UseContainerMagazine') exitWith {
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
		50 cutText [localize 'STR_QS_Text_063','PLAIN'];
		_QS_c = TRUE;
	};
	_QS_c;	
};
if (_QS_actionName isEqualTo 'Eject') exitWith {
	if ((vehicle QS_player) isKindOf 'Air') then {
		if (QS_player isEqualTo (driver (vehicle QS_player))) then {
			_QS_c = TRUE;
			0 spawn {
				private _result = [localize 'STR_QS_Menu_118',localize 'STR_QS_Menu_119',localize 'STR_QS_Menu_120',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
				if (_result) then {
					QS_player action ['eject',(vehicle QS_player)];
				};
			};
		} else {
			if (
				(!(isTouchingGround (vehicle QS_player))) &&
				{(((vectorMagnitude (velocity (vehicle QS_player))) * 3.6) > 25)}
			) then {
				_QS_c = TRUE;
				0 spawn {
					private _result = [localize 'STR_QS_Menu_118',localize 'STR_QS_Menu_119',localize 'STR_QS_Menu_120',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
					if (_result) then {
						QS_player action ['eject',(vehicle QS_player)];
					};
				};
			};
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'GetInPilot') exitWith {
	// Heli - Non-helipilots blocked from entering
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(!(player getUnitTrait 'QS_trait_pilot'))} &&
		{(
			(_QS_actionTarget isKindOf 'Helicopter') || 
			{(_QS_actionTarget isKindOf 'VTOL_Base_F')}
		)}
	) then {
		_text = localize 'STR_QS_Hints_015';
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,FALSE,8,-1,_text,[],-1];
		_QS_c = TRUE;
	};
	// Plane - Non-fighter pilots blocked from entering
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionPlane',FALSE]) &&
		{(!(player getUnitTrait 'QS_trait_fighterPilot'))} &&
		{(_QS_actionTarget isKindOf 'Plane')} && 
		{(!(_QS_actionTarget isKindOf 'VTOL_Base_F'))}
	) then {
		_text = localize 'STR_QS_Hints_015';
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,FALSE,8,-1,_text,[],-1];
		_QS_c = TRUE;
	};
	// Not allowed to fly planes if received a number of Robocop reports (6+ for in-AO reports)
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'GetInCargo') exitWith {
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
};
if (_QS_actionName isEqualTo 'GetInGunner') exitWith {
	// Not allowed to get in gunner if many reports against
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	// Heli pilot not allowed to be chopper gunner if >20 players on server, but can still get in if far from base.
	if (
		(
			((missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) && ((_QS_actionTarget isKindOf 'Helicopter') || (_QS_actionTarget isKindOf 'VTOL_Base_F'))) ||
			{((missionNamespace getVariable ['QS_missionConfig_roleRestrictionPlane',FALSE]) && ((_QS_actionTarget isKindOf 'Plane') && (!(_QS_actionTarget isKindOf 'VTOL_Base_F'))))}
		) &&
		{(player getUnitTrait 'QS_trait_pilot')} &&
		{((count allPlayers) > 20)} &&
		{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))}
	) then {
		_QS_c = TRUE;
	};
	// Fighter Pilot not allowed to be a gunner in helicopters/etc
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(player getUnitTrait 'QS_trait_fighterPilot')} &&
		{(!(_QS_actionTarget isKindOf 'Plane'))}
	) then {
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'GetInCommander') exitWith {
	// Not allowed to get in commander if many reports against
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	// Heli pilot not allowed to be vehicle commander if >20 players on server, but can still get in if far from base.
	if (
		(player getUnitTrait 'QS_trait_pilot') &&
		{((count allPlayers) > 20)} &&
		{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))}
	) then {
		_QS_c = TRUE;
	};
	// Fighter Pilot not allowed to be a gunner in helicopters/etc
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(player getUnitTrait 'QS_trait_fighterPilot')} &&
		{(!(_QS_actionTarget isKindOf 'Plane'))}
	) then {
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'GetInTurret') exitWith {
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	// Exceptions for non-pilots to fly when server pop is low
	_allowedClasses = ['basic_heli_types_1'] call QS_data_listVehicles;
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(['Copilot',_QS_actionText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} &&			// This fails in language translations
		{((count allPlayers) > 20)} &&
		{((_allowedClasses findIf {_QS_actionTarget isKindOf _x}) isEqualTo -1)} &&
		{(!(player getUnitTrait 'QS_trait_pilot'))}
	) then {
		_QS_c = TRUE;
	};
	// Heli pilot not allowed to be copilot/turret if >20 players on server, but can still get in if far from base.
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(player getUnitTrait 'QS_trait_pilot')} &&
		{((count allPlayers) > 20)} &&
		{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))}
	) then {
		_QS_c = TRUE;
	};
	// Mortar operator needs to be in Mortar gunner slot
	if (
		(_QS_actionTarget isKindOf 'StaticMortar') &&
		{(!(player getUnitTrait 'QS_trait_gunner'))}
	) then {
		private _currentMortarGunnerName = localize 'STR_QS_Text_328';
		private _currentMortarGunners = [];
		_currentMortarGunners = allPlayers select {(_x getUnitTrait 'QS_trait_gunner')};
		if (_currentMortarGunners isNotEqualTo []) then {
			_currentMortarGunnerName = name (_currentMortarGunners # 0);
		};
		50 cutText [(format ['%2 ( %1 )',_currentMortarGunnerName,localize 'STR_QS_Text_066']),'PLAIN DOWN',0.75];
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'MoveToDriver') exitWith {
	// Cant move to driver if detected as a teamkiller
	if ((player getVariable ['QS_tto',0]) > 3) then {
		_QS_c = TRUE;
	};
	if (
		(!isNull (getTowParent _QS_actionTarget)) &&
		{(!isNull (ropeAttachedTo _QS_actionTarget))} &&
		{((getTowParent _QS_actionTarget) isEqualTo (ropeAttachedTo _QS_actionTarget))}
	) then {
		50 cutText [localize 'STR_QS_Text_343','PLAIN',0.333];
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'MoveToTurret') exitWith {
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(player getUnitTrait 'QS_trait_pilot')} &&
		{((count allPlayers) > 20)} &&
		{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))}
	) then {
		_QS_c = TRUE;
	};
};
if (_QS_actionName isEqualTo 'Gear') exitWith {
	_QS_c;
};
if (_QS_actionName isEqualTo 'DropWeapon') exitWith {
	_QS_c;
};
if (_QS_actionName isEqualTo 'Assemble') then {
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
		_QS_c = TRUE;
		50 cutText [localize 'STR_QS_Text_067','PLAIN'];
	};
	//"$STR_A3_DISASSEMBLE"
	//"$STR_ACTION_ASSEMBLE"
	if (!(['$STR_A3_DISASSEMBLE',_QS_actionText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
		if !(player isNil 'QS_client_assembledWeapons') then {
			private _assembledWeapons = player getVariable ['QS_client_assembledWeapons',[]];
			if (({(alive _x)} count _assembledWeapons) >= 3) then {
				50 cutText [localize 'STR_QS_Text_068','PLAIN DOWN',1];
				_QS_c = TRUE;
			};
		};
	};
};
if (_QS_actionName in ['TouchOffMines','TouchOff']) exitWith {
	private _playersNearby = [];
	private _mine = objNull;
	private _count = 0;
	{
		_mine = _x;
		if (!isNull _mine) then {
			if (mineActive _mine) then {
				_playerside = player getVariable ['QS_unit_side',WEST];
				_playersNearby = (allPlayers select {((side (group _x)) isEqualTo _playerside)}) inAreaArray [_mine,30,30,0,FALSE];
				if ((count _playersNearby) > 1) then {
					{
						if ((lifeState _x) in ['HEALTHY','INJURED']) then {
							if ((([objNull,'GEOM'] checkVisibility [(eyePos (vehicle _x)),((getPosASL _mine) vectorAdd [0,0,0.5])]) > 0) || {(([objNull,'VIEW'] checkVisibility [(eyePos (vehicle _x)),((getPosASL _mine) vectorAdd [0,0,0.5])]) > 0)}) then {
								_count = _count + 1;
								if ((player targets [TRUE,30,[],0,(getPosATL _mine)]) isEqualTo []) then {
									_QS_c = TRUE;
								};
							};
						};
					} forEach _playersNearby;
					if (_QS_c) then {
						50 cutText [(format ['%1 %2',_count,localize 'STR_QS_Text_069']),'PLAIN DOWN',1];
					};
				};
			};
			if (
				(_count > 1) &&
				((player getVariable ['QS_tto',0]) >= 2)
			)then {
				deleteVehicle _x;
			};
		};
	} forEach (getAllOwnedMines player);
	_QS_c;
};
if (_QS_actionName isEqualTo 'UseMagazine') exitWith {
	getCursorObjectParams params [
		'_cursorObject',
		'',
		'_cursorObjectDistance'
	];
	if (
		(_cursorObject isKindOf 'Air') &&
		{(_cursorObjectDistance < 5)} &&
		{(!(player getUnitTrait 'QS_trait_pilot'))}
	) then {
		_nCargo = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_transportsoldier',toLowerANSI (typeOf _cursorObject)],
			{getNumber ((configOf _cursorObject) >> 'transportSoldier')},
			TRUE
		];
		if (
			(_nCargo > 0) &&
			{(((crew _cursorObject) findIf {((alive _x) && (isPlayer _x))}) isNotEqualTo -1)} &&
			{((player targets [TRUE,30,[],0,(getPosATL _cursorObject)]) isEqualTo [])}
		) then {
			50 cutText [localize 'STR_QS_Text_070','PLAIN DOWN',0.5];
			_QS_c = TRUE;
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'DisAssemble') exitWith {
	if (
		(!isNull (attachedTo _QS_actionTarget)) //&&
		//((attachedTo _QS_actionTarget) isKindOf 'CAManBase')
	) then {
		50 cutText [localize 'STR_QS_Text_070','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	if (!(_QS_c)) then {
		private _assembledWeapons = player getVariable ['QS_client_assembledWeapons',[]];
		if (
			(_assembledWeapons isNotEqualTo []) &&
			(_QS_actionTarget in _assembledWeapons)
		) then {
			_assembledWeapons deleteAt (_assembledWeapons find _QS_actionTarget);
			player setVariable ['QS_client_assembledWeapons',_assembledWeapons,FALSE];
		};
	};
	_QS_c;
};
if (_QS_actionName in ['TakeVehicleControl','MoveToPilot']) exitWith {
	// Exceptions for non-pilots to fly when server pop is low
	_allowedClasses = ['Heli_Light_01_unarmed_base_F','Heli_light_03_unarmed_base_F'];		// Unarmed Hummingbird & Hellcat. To Do: Support Mod/DLC assets
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{((count allPlayers) > 20)} &&
		{((_allowedClasses findIf {_QS_actionTarget isKindOf _x}) isEqualTo -1)} &&
		{(!(player getUnitTrait 'QS_trait_pilot'))}
	) then {
		_QS_c = TRUE;
	};
	if (
		(missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE]) &&
		{(player getUnitTrait 'QS_trait_fighterPilot')}
	) then {
		_QS_c = TRUE;
	};
	if (_QS_actionTarget getVariable ['QS_logistics_wreck',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
		_QS_c = TRUE;
	};
	if (lockedDriver _QS_actionTarget) then {
		50 cutText [localize 'STR_QS_Text_394','PLAIN',0.333];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'AutoHover') exitWith {
	if (!(missionNamespace getVariable ['QS_missionConfig_autohover',TRUE])) then {
		50 cutText [localize 'STR_QS_Text_417','PLAIN DOWN',0.333];
		_QS_c = TRUE;
		cameraOn spawn {
			sleep 0.1;
			action ['autohovercancel',_this];
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'UAVTerminalHackConnection') exitWith {
	if (_QS_actionTarget getVariable ['QS_uav_disabled',FALSE]) then {
		_QS_c = TRUE;
		50 cutText [localize 'STR_QS_Text_316','PLAIN',0.5];
	} else {
		_dn = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _QS_actionTarget)],
			{getText ((configOf _QS_actionTarget) >> 'displayName')},
			TRUE
		];
		_text = format ['%1 %3 %2!',profileName,(_QS_actionTarget getVariable ['QS_ST_customDN',_dn]),localize 'STR_QS_Chat_091'];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		_QS_actionTarget spawn {
			_timeout = diag_tickTime + 15;
			waitUntil {
				(
					((crew _this) isNotEqualTo []) ||
					(diag_tickTime > _timeout)
				)
			};
			if ((crew _this) isNotEqualTo []) then {
				(crew _this) joinSilent (group player);
				(group (driver _this)) setVariable ['QS_HComm_grp',FALSE,TRUE];
			};
		};
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'OpenBag') exitWith {
	if (
		(isNull (objectParent player)) &&
		{(
			(((vectorMagnitude (velocity (vehicle player))) * 3.6) > 2) || 
			{(((vectorMagnitude (velocity (vehicle _QS_actionTarget))) * 3.6) > 2)}
		)}
	) then {
		_QS_c = TRUE;
		50 cutText [localize 'STR_QS_Text_071','PLAIN DOWN',0.75];
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'UserType') then {
	_actionTextLower = toLower _QS_actionText;
	if (_actionTextLower in [
		(toLower (localize "$STR_DN_OUT_O_DOOR")),
		(toLower (localize "$STR_DN_OUT_C_DOOR")),
		(toLower (localize "$STR_A3_HATCH_OPEN")),
		(toLower (localize "$STR_A3_HATCH_CLOSE"))
	]) then {
		/*/
			private _info = 2 call (missionNamespace getVariable 'QS_fnc_getDoor');
			_info params ['_house','_door'];
			if (isNull _house) exitWith {};
			private _getDoorAnimations = [_house, _door] call (missionNamespace getVariable 'QS_fnc_getDoorAnimations');
			_getDoorAnimations params ['_animations','_lockedVariable'];
			if (_animations isEqualTo []) exitWith {};
			if (diag_tickTime > (missionNamespace getVariable ['QS_interact_doorLastOpenTime',-1])) then {
				missionNamespace setVariable ['QS_interact_doorLastOpenTime',(diag_tickTime + 1),FALSE];
				2 call (missionNamespace getVariable 'QS_fnc_clientInteractDoor');
			};
		/*/
	} else {
		if (_actionTextLower in [
			(toLower (localize 'STR_QS_Interact_019')),		// 'beacons on',
			(toLower (localize 'STR_QS_Interact_020'))		// 'beacons off'
		]) then {
			if (_actionTextLower isEqualTo (toLower (localize 'STR_QS_Interact_019'))) then {
				//comment 'Beacons on';
				call (missionNamespace getVariable 'QS_fnc_clientInteractUtilityOffroad');
			} else {
				//comment 'Beacons off';
				(vehicle player) setVariable ['Utility_Offroad_Beacons',FALSE,TRUE];
			};
		};
	};
};
if (
	(cameraOn isKindOf 'Air') &&
	{(QS_player isNotEqualTo (currentPilot cameraOn))} &&
	{(_actionTextLower in [
		toLower (localize "$STR_ACTION_RAMP_OPEN0"),
		toLower (localize "$STR_ACTION_RAMP_CLOSE0")
	])} &&
	{(cameraOn getVariable ['QS_rappellSafety',FALSE])}
) exitWith {
	50 cutText [localize 'STR_QS_Text_319','PLAIN DOWN',0.75];
	_QS_c = TRUE;
};
if (
	(_QS_actionName isEqualTo 'UnloadAllVehicles') &&
	{(_QS_actionTarget isKindOf 'LandVehicle')}
) exitWith {
	if (
		(surfaceIsWater (getPosWorld _QS_actionTarget)) &&
		{(isTouchingGround _QS_actionTarget)}
	) then {
		50 cutText [localize 'STR_QS_Text_375','PLAIN',0.333];
	} else {
		if (!lockedInventory _QS_actionTarget) then {
			uiNamespace setVariable ['QS_menuUnloadCargo_target',_QS_actionTarget];
			createDialog 'QS_RD_client_dialog_menu_unloadCargo';
		} else {
			50 cutText [localize 'STR_QS_Text_379','PLAIN',0.333];
		};
	};
	TRUE
};
if (_QS_actionName isEqualTo 'UnloadUnconsciousUnits') exitWith {
	if (isNull (objectParent player)) then {
		50 cutText [localize 'STR_QS_Text_073','PLAIN DOWN',0.5];
	} else {
		50 cutText [localize 'STR_QS_Text_074','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	if (!isNull (isVehicleCargo _QS_actionTarget)) then {
		50 cutText [localize 'STR_QS_Text_070','PLAIN DOWN',0.5];
		_QS_c = TRUE;
		
	};
	if (surfaceIsWater (getPosWorld _QS_actionTarget)) then {
		50 cutText [localize 'STR_QS_Text_070','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	if (!isNull (ropeAttachedTo _QS_actionTarget)) then {
		50 cutText [localize 'STR_QS_Text_070','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'HookCargo') exitWith {
	if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
		if ('EmptyDisplay' in (infoPanel 'left')) then {
			setInfoPanel ['left','SlingLoadDisplay'];
		} else {
			if ('EmptyDisplay' in (infoPanel 'right')) then {
				setInfoPanel ['right','SlingLoadDisplay'];
			} else {
				setInfoPanel ['left','SlingLoadDisplay'];
			};
		};
	};
};
if (_QS_actionName isEqualTo 'UnhookCargo') exitWith {
	_vehicle = cameraOn;
	if (local _vehicle) then {
		if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
			if ('EmptyDisplay' in (infoPanel 'left')) then {
				setInfoPanel ['left','SlingLoadDisplay'];
			} else {
				if ('EmptyDisplay' in (infoPanel 'right')) then {
					setInfoPanel ['right','SlingLoadDisplay'];
				} else {
					setInfoPanel ['left','SlingLoadDisplay'];
				};
			};
		};
		_heliplayer = if (isNull (missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',objNull])) then {player} else {(missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',objNull])};
		if (
			(!isNull (getSlingLoad _vehicle)) &&
			{((getSlingLoad _vehicle) in (attachedObjects _vehicle))} &&
			{(
				(_heliplayer isEqualTo (driver _vehicle)) || 
				{((_vehicle isKindOf 'heli_transport_04_base_f') && (_heliplayer isEqualTo (_vehicle turretUnit [1])))}
			)}
		) then {
			_QS_c = TRUE;
			['DOWN'] call (missionNamespace getVariable 'QS_fnc_slingRope');
		};
	} else {
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionName isEqualTo 'ManualFire') exitWith {
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
		50 cutText [localize 'STR_QS_Text_075','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (
	((toLowerANSI (typeOf _QS_actionTarget)) isEqualTo 'land_destroyer_01_interior_04_f') &&
	{(_QS_actionPriority in [0.397,0.398])}
) exitWith {
	if (missionNamespace getVariable ['QS_destroyer_heliLaunch',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.5];
		_QS_c = TRUE;
	};
	_QS_c;
};
if (_QS_actionText in ['   ',(localize 'STR_QS_Interact_106')]) exitWith {
	TRUE;
};
_QS_c;