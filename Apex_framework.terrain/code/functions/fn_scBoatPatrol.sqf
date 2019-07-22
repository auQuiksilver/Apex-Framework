/*
File: fn_aoBoatPatrol.sqf
Author: 

	Quiksilver

Last Modified:

	1/04/2016 A3 1.56 by Quiksilver

Description:

	Spawn boats near the AO

Example:

	_return = [(missionNamespace getVariable 'QS_AOpos')] call QS_fnc_aoBoatPatrol;
____________________________________________________________________________*/

params ['_pos'];
private ['_return','_position','_boat','_grp','_count','_boatTypes'];
_return = [];
if (worldName isEqualTo 'Tanoa') then {
	_boatTypes = ['O_T_Boat_Armed_01_hmg_F'];
} else {
	_boatTypes = ['O_Boat_Armed_01_hmg_F','I_Boat_Armed_01_minigun_F'];
};
_boat = objNull;
_count = 1;
if (worldName in ['Tanoa']) then {
	_count = 2;
};
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
			_boat addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
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
			if ((random 1) > 0.666) then {
				[_grp,_position,(50 + (random 150))] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
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