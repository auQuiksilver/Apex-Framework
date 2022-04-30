/*
File: fn_aoBoatPatrol.sqf
Author: 

	Quiksilver

Last Modified:

	26/03/2018 A3 1.82 by Quiksilver

Description:

	Spawn boats near the AO

Example:

	_return = [(missionNamespace getVariable 'QS_AOpos')] call QS_fnc_aoBoatPatrol;
____________________________________________________________________________*/

params ['_pos'];
private ['_return','_position','_boat','_grp','_count','_boatTypes'];
private _isHCActive = missionNamespace getVariable ['QS_HC_Active',FALSE];
_return = [];
_boatTypes = [['O_Boat_Armed_01_hmg_F'],['O_T_Boat_Armed_01_hmg_F']] select (worldName in ['Tanoa','Lingor3']);
_boat = objNull;
_count = [1,2] select (worldName in ['Tanoa','Lingor3']);
for '_i' from 0 to 1 step 1 do {
	_position = ['RADIUS',_pos,((missionNamespace getVariable ['QS_aoSize',800]) * 2),'WATER',[],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (!(_position in [[worldSize,worldSize,0],[]])) then {
		if ((getTerrainHeightASL _position) < -5) then {
			_position set [2,0];
			_boat = createVehicle [(selectRandom _boatTypes),_position,[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_boat setDir (random 360);
			_boat allowCrewInImmobile TRUE;
			_boat enableRopeAttach FALSE;
			_boat enableVehicleCargo FALSE;
			clearMagazineCargoGlobal _boat;
			clearWeaponCargoGlobal _boat;
			clearItemCargoGlobal _boat;
			clearBackpackCargoGlobal _boat;
			if ((count allPlayers) < 30) then {
				[_boat] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
			} else {
				if ((random 1) > 0.5) then {
					[_boat] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
				};
			};
			_grp = createVehicleCrew _boat;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _boat))),
				FALSE
			];
			_return pushBack _boat;
			_boat lock 3;
			_boat addEventHandler [
				'Killed',
				{
					if ((count (crew (_this select 0))) > 0) then {
						{
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						} count (crew (_this select 0));
					};
				}
			];
			_boat setDir (random 360);
			{
				_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
				_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _return pushBack _x;
				_x doWatch (missionNamespace getVariable 'QS_AOpos');
			} count (crew _boat);
			_grp enableAttack TRUE;
			_grp addVehicle _boat;
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			private _patrolPosition = position _boat;
			private _virtualPatrol = [_patrolPosition];
			for '_x' from 0 to 2 step 1 do {
				for '_x' from 0 to 1 step 0 do {
					_patrolPosition = (position _boat) getPos [(50 + (random 500)),(random 360)];
					if (((_virtualPatrol inAreaArray [_patrolPosition,50,50,0,FALSE]) isEqualTo []) && (surfaceIsWater _patrolPosition) && ((getTerrainHeightASL _patrolPosition) < -5)) exitWith {};
				};
				_virtualPatrol pushBack _patrolPosition;
			};
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_CONFIG',['BOAT_PATROL','',(count (units _grp)),_boat],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_TASK',['BOAT_PATROL',_virtualPatrol,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			if (_isHCActive) then {
				_grp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			};
			_boat addEventHandler [
				'GetOut',
				{
					params ['_vehicle','_position','_unit','_turret'];
					missionNamespace setVariable [
						'QS_analytics_entities_deleted',
						((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
						FALSE
					];
					deleteVehicle _unit;
				}
			];
		};
	};
};
_return;