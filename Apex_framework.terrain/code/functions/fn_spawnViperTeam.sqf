/*/
File: fn_spawnViperTeam.sqf
Author:

	Quiksilver
	
Last Modified:

	3/03/2018 A3 1.80 by Quiksilver
	
Description:

	Spawn Viper Team
_____________________________________________________________________/*/

params ['_type','_quantity','_total',['_viperGroup',grpNull]];
_unitTypes = [
	[
		'O_V_Soldier_TL_hex_F',0.1,
		'O_V_Soldier_JTAC_hex_F',0.1,
		'O_V_Soldier_M_hex_F',0.3,
		'O_V_Soldier_Exp_hex_F',0.3,
		'O_V_Soldier_LAT_hex_F',0.3,
		'O_V_Soldier_Medic_hex_F',0.2,
		'o_v_soldier_hex_f',0.6
	],
	[
		'O_V_Soldier_TL_ghex_F',0.1,
		'O_V_Soldier_JTAC_ghex_F',0.1,
		'O_V_Soldier_M_ghex_F',0.3,
		'O_V_Soldier_Exp_ghex_F',0.3,
		'O_V_Soldier_LAT_ghex_F',0.3,
		'O_V_Soldier_Medic_ghex_F',0.2,
		'o_v_soldier_ghex_f',0.6
	]
] select (worldName isEqualTo 'Tanoa');
if (_type in ['CLASSIC','SC']) exitWith {
	comment 'Position';
	private _centerPos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
	private _aoSize = missionNamespace getVariable ['QS_aoSize',[0,0,0]];
	private _positionFound = FALSE;
	private _iterations = 0;
	private _checkVisibleDistance = 500;
	private _players = allPlayers;
	private _playersOnGround = (_players unitsBelowHeight 25) select {((side _x) in [WEST,CIVILIAN,SIDEFRIENDLY])};
	private _position1 = [0,0,0];
	for '_x' from 0 to 1 step 0 do {
		_position1 = ['RADIUS',_centerPos,_aoSize,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_centerPos,300,'(1 + forest) * (1 - houses)',15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if ((_position1 distance2D _centerPos) < 1500) then {
			if (({((_x distance2D _position1) < 250)} count _players) isEqualTo 0) then {
				if ((([(_position1 select 0),(_position1 select 1)] nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
					if (([(AGLToASL _position1),_checkVisibleDistance,_playersOnGround,[WEST,CIVILIAN,SIDEFRIENDLY],0,0] call (missionNamespace getVariable 'QS_fnc_isPosVisible')) <= 0.1) then {
						_positionFound = TRUE;
					};
				};
			};
		};
		if (_positionFound) exitWith {};
		if (_iterations > 300) exitWith {};
		_iterations = _iterations + 1;
	};
	if (_iterations > 300) exitWith {};
	comment 'Spawn units';
	private _unit = objNull;
	private _grp = _viperGroup;
	if (isNull _grp) then {
		_grp = createGroup [EAST,TRUE];
	};
	for '_x' from 0 to ((_total - _quantity) - 1) step 1 do {
		_unit = _grp createUnit [(selectRandomWeighted _unitTypes),_position1,[],0,'NONE'];
		_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit setAnimSpeedCoef 1.1;
		_unit setCustomAimCoef 0.9;
		_unit setUnitRecoilCoefficient 0.9;
		_unit setUnitTrait ['camouflageCoef',0.5,FALSE];
		_unit setUnitTrait ['audibleCoef',0.5,FALSE];
		if ((random 1) > 0.5) then {
			_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
			_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime - 1),FALSE];
		};
		_unit addEventHandler [
			'Hit',
			{
				if ((random 1) > 0.5) then {
					params ['_u','','','_i'];
					if (local _u) then {
						if (alive _i) then {
							if ((side _i) isEqualTo WEST) then {
								if ((stance _u) in ['CROUCH','STAND']) then {
									_u playAction (selectRandom ['TactLB','TactRB','TactL','TactR','TactLF','TactRf']);
									if ((random 1) > 0.5) then {
										_u playAction (selectRandom ['TactLB','TactRB','TactL','TactR','TactLF','TactRf']);
									};
								};
							};
						};
					};
				};
			}
		];
		_unit setVehiclePosition [(getPosWorld _unit),[],0,'NONE'];
		_unit setUnitPosWeak 'AUTO';
	};
	comment 'Configure units';
	_grp setBehaviour 'AWARE';
	_grp setCombatMode 'YELLOW';
	[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_TASK',['HUNT',[0,0,0],diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INF_VIPER',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_DATA',[_position1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	(units _grp);
};
if (_type isEqualTo 'GRID') exitWith {

};
if (_type isEqualTo 'SM') exitWith {

};