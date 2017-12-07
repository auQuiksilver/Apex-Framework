/*/
File: fn_aoFortifiedAA.sqf
Author: 

	Quiksilver

Last Modified:

	1/05/2017 A3 1.68 by Quiksilver

Description:

	Fortified AA Site
____________________________________________________________________________/*/
params ['_pos','_type'];
private ['_position','_return','_newPos','_multiplier'];
_newPos = _pos getPos [((missionNamespace getVariable 'QS_aoSize') / 1.5),((markerPos 'QS_marker_base_marker') getDir _pos)];
_multiplier = 0.9;
for '_x' from 0 to 11 step 1 do {
	_position = ['RADIUS',_newPos,((missionNamespace getVariable 'QS_aoSize') * _multiplier),'LAND',[7,0,0.3,7.5,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((({((_position distance2D _x) < 75)} count (missionNamespace getVariable 'QS_registeredPositions')) isEqualTo 0) && ((([_position select 0,_position select 1] nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && (!((toLower(surfaceType _position)) in ['#gdtasphalt'])) && (!([_position,20,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
	_multiplier = _multiplier + 0.05;
};
if (((_position distance2D _pos) > 3000) || {(_position isEqualTo [])}) exitWith {[]};
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
_return = [
	_position,
	(_position getDir (markerPos 'QS_marker_base_marker')),
	[
		[
			_type,
			[0.358643,3.59985,-0.0538797],
			360,
			[],
			FALSE,
			TRUE,
			FALSE,
			{
				private ['_vehicle','_grp','_unit','_baseMarker'];
				_vehicle = _this select 0;
				/*/_vehicle setFuel 0;/*/
				_vehicle allowCrewInImmobile TRUE;
				_vehicle lock 2;
				_vehicle allowDamage FALSE;
				_vehicle spawn {uiSleep 10;_this allowDamage TRUE;};
				_vehicle setVariable ['QS_disableRefuel',TRUE,FALSE];
				_vehicle setVariable ['QS_vehicle_markers',[],FALSE];
				_vehicle setVehicleReceiveRemoteTargets TRUE;
				_vehicle setVehicleReportRemoteTargets TRUE;
				_vehicle addEventHandler [
					'Killed',
					{
						params ['_killed','_killer','_instigator','_useEffects'];
						private ['_name','_objType','_killerType','_killerDisplayName','_objDisplayName'];
						if (!isNil {_killed getVariable 'QS_vehicle_markers'}) then {
							if (!((_killed getVariable 'QS_vehicle_markers') isEqualTo [])) then {
								{
									_x setMarkerAlpha 0;
								} count (_killed getVariable 'QS_vehicle_markers');
							};
						};
						if (!isNil {_killed getVariable 'QS_vehicleCrew'}) then {
							{
								if (!isNull _x) then {
									if (alive _x) then {
										_x setDamage 1;
									};
								};
							} count (_killed getVariable 'QS_vehicleCrew');
						};
						_objType = typeOf _killed;
						if (!isNull _instigator) then {
							if (isPlayer _instigator) then {
								if ((vehicle _instigator) isKindOf 'Air') then {
									_killerType = typeOf (vehicle _instigator);
									_killerDisplayName = getText (configFile >> 'CfgVehicles' >> _killerType >> 'displayName');
									_objDisplayName = getText (configFile >> 'CfgVehicles' >> _objType >> 'displayName');
									_name = name _instigator;
									['sideChat',[WEST,'BLU'],(format ['%1 has destroyed a(n) %2 with a %3!',_name,_objDisplayName,_killerDisplayName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
								};
							};
						};
						if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
							['SC_SUB_COMPLETED',['','AA Site destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
						} else {
							['CompletedSub',['AA Site Destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
						};
					}
				];
				_vehicle setVariable ['QS_hidden',TRUE,TRUE];
				_vehicle addEventHandler [
					'Fired',
					{
						if ((random 1) > 0.9) then {
							(_this select 0) setVehicleAmmo 1;
						};
					}
				];
				_vehicle addEventHandler [
					'GetOut',
					{
						(_this select 2) setDamage 1;
						if (({(alive _x)} count (crew (_this select 0))) isEqualTo 0) then {
							(_this select 0) setDamage 1;
						};
					}
				];
				_vehicle addEventHandler [
					'Deleted',
					{
						if (!((crew (_this select 0)) isEqualTo [])) then {
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
				createVehicleCrew _vehicle;
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _vehicle))),
					FALSE
				];
				_vehicle enableSimulationGlobal TRUE;
				_vehicle addEventHandler [
					'Deleted',
					{
						params ['_entity'];
						_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
						if (!(_vehicleMarkers isEqualTo [])) then {
							{
								deleteMarker _x;
							} forEach _vehicleMarkers;
						};
					}
				];
				clearMagazineCargoGlobal _vehicle;
				clearWeaponCargoGlobal _vehicle;
				clearItemCargoGlobal _vehicle;
				clearBackpackCargoGlobal _vehicle;
				missionNamespace setVariable [
					'QS_analytics_entities_deleted',
					((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
					FALSE
				];
				_vehicle deleteVehicleCrew (driver _vehicle);
				if (isNull (missionNamespace getVariable 'QS_AI_GRP_AO_AA')) then {
					missionNamespace setVariable ['QS_AI_GRP_AO_AA',(createGroup [EAST,TRUE]),FALSE];
				};
				private _grp = group (effectiveCommander _vehicle);
				{
					_x setVehicleReceiveRemoteTargets TRUE;
					_x setVehicleReportRemoteTargets TRUE;
					[_x] join (missionNamespace getVariable 'QS_AI_GRP_AO_AA');
					_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
				} forEach (units _grp);
				_grp addVehicle _vehicle;
				[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_vehicle setVariable ['QS_vehicleCrew',[(gunner _vehicle),(commander _vehicle)],FALSE];
				if (_vehicle isKindOf 'B_APC_Tracked_01_AA_F') then {
					_vehicle setObjectTextureGlobal [0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'];
					_vehicle setObjectTextureGlobal [1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'];
					_vehicle setObjectTextureGlobal [2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_tower_opfor_co.paa'];
				};
				_baseMarker = markerPos 'QS_marker_base_marker';
				{
					_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
					/*/_x doWatch [(_baseMarker select 0),(_baseMarker select 1),2000];/*/
					_x allowDamage FALSE;
					_x addEventHandler ['GetOutMan',{(_this select 0) setDamage 1;}];
				} forEach [(gunner _vehicle),(commander _vehicle)];
				if (alive _vehicle) then {
					private ['_position','_roughPos','_aoAAMarkers','_markerID','_vehicleMarkers'];
					_position = getPosWorld _vehicle;
					_roughPos = [((_position select 0) - 90) + (random 180),((_position select 1) - 90) + (random 180),0];
					_aoAAMarkers = missionNamespace getVariable ['QS_ao_aaMarkers',[]];
					_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
					{
						_markerID = format ['QS_marker_aoAA_%1',(count _aoAAMarkers)];
						createMarker [_markerID,(_x select 1)];
						_markerID setMarkerType (_x select 2);
						_markerID setMarkerShape (_x select 3);
						if (!((_x select 3) isEqualTo 'Icon')) then {
							_markerID setMarkerBrush (_x select 4);
						};
						_markerID setMarkerColor (_x select 5);
						_markerID setMarkerSize (_x select 6);
						_markerID setMarkerAlpha (_x select 7);
						_markerID setMarkerPos (_x select 8);
						_markerID setMarkerDir (_x select 9);
						_markerID setMarkerText (format ['%1%2',(toString [32,32,32]),(_x select 10)]);
						0 = _aoAAMarkers pushBack _markerID;
						0 = _vehicleMarkers pushBack _markerID;
						0 = (missionNamespace getVariable 'QS_virtualSectors_siteMarkers') pushBack _markerID;
					} count [
						['',[0,0,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_roughPos,0,'   '],
						['',[0,0,0],'Empty','Ellipse','Border','ColorOPFOR',[100,100],0,_roughPos,0,'   ']
					];
					missionNamespace setVariable ['QS_ao_aaMarkers',_aoAAMarkers,FALSE];
					_vehicle setVariable ['QS_vehicle_markers',_vehicleMarkers,FALSE];
					if ((random 1) > 0.666) then {
						_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,(selectRandom ['OIA_InfSentry','OIA_InfSentry']),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
						[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
						_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
						_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
						_grp setVariable ['QS_AI_GRP_DATA',[_position,50,50,[]],FALSE];
						_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,diag_tickTime,-1],FALSE];
					};	
				};
				_vehicle;
			}
		],
		['Land_HBarrier_01_big_4_green_F',[-3.14746,2.31885,0],271.727,[],false,false,true,{}],
		['Land_HBarrier_01_big_4_green_F',[0.55542,-4.50635,0],180.667,[],false,false,true,{}],
		['Land_HBarrier_01_big_4_green_F',[3.87451,2.48047,0],90.437,[],false,false,true,{}],
		['Land_HBarrier_01_big_4_green_F',[0.00415039,7.60474,0],0,[],false,false,true,{}],
		['Land_BagFence_01_round_green_F',[-3.30811,7.62598,2],134.796,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[-0.906006,-4.56714,2],178.871,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[-3.47363,3.51343,2],270.511,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[2.20435,-4.50098,2],0,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[3.95801,3.72876,2],271.043,[],false,false,true,{}],
		['Land_BagFence_01_round_green_F',[3.64966,7.05127,2],227.999,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[4.00391,0.714111,2],89.0205,[],false,false,true,{}],
		['Land_BagFence_01_long_green_F',[-3.40942,0.342529,2],91.3792,[],false,false,true,{}]
	],
	TRUE
] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_return;