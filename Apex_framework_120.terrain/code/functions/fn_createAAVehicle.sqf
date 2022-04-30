/*/
File: fn_createAAVehicle.sqf
Author: 

	Quiksilver
	
Last modified:

	24/04/2022 A3 2.08 by Quiksilver
	
Description:

	Create AA Vehicle for AA Sites
___________________________________________________________________/*/

params ['_vehicle'];
_vehicleType = toLower (typeOf _vehicle);
_vehicle allowCrewInImmobile TRUE;
_vehicle lock 2;
_vehicle lockDriver TRUE;
_vehicle allowDamage FALSE;
_vehicle spawn {uiSleep 3;_this enableSimulationGlobal TRUE;uiSleep 3;_this allowDamage TRUE;};
{
	_vehicle setVariable _x;
} forEach [
	['QS_disableRefuel',TRUE,FALSE],
	['QS_vehicle_markers',[],FALSE],
	['QS_hidden',TRUE,TRUE],
	['QS_reportTarget_disable',TRUE,TRUE]
];
_vehicle setVehicleReceiveRemoteTargets TRUE;
_vehicle setVehicleReportRemoteTargets TRUE;
//_vehicle setVehicleRadar (selectRandomWeighted [0,0.5,1,0.5]);
[0,_vehicle,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
{
	_vehicle addEventHandler _x;
} forEach [
	[
		'Killed',
		{
			params ['_killed','_killer','_instigator','_useEffects'];
			if (!((_killed getVariable ['QS_vehicle_markers',[]]) isEqualTo [])) then {
				{
					_x setMarkerAlpha 0;
				} count (_killed getVariable 'QS_vehicle_markers');
			};
			{
				_x setDamage [1,FALSE];
			} forEach (crew _killed);
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
						['sideChat',[WEST,'BLU'],(format ['%1 has destroyed a(n) %2 with a(n) %3!',_name,_objDisplayName,_killerDisplayName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			};
			if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
				['SC_SUB_COMPLETED',['','AA Site destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			} else {
				['CompletedSub',['AA Site Destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			};
		}
	],
	[
		'Fired',
		{
			if ((random 1) > 0.95) then {
				(_this select 0) setVehicleAmmo 1;
			};
		}
	],
	[
		'GetOut',
		{
			(_this select 2) setDamage 1;
			if (((crew (_this select 0)) findIf {(alive _x)}) isEqualTo -1) then {
				(_this select 0) setDamage 1;
			};
		}
	],
	[
		'Deleted',
		{
			params ['_entity'];
			if (!((crew _entity) isEqualTo [])) then {
				{
					missionNamespace setVariable [
						'QS_analytics_entities_deleted',
						((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
						FALSE
					];
					deleteVehicle _x;
				} count (crew _entity);
			};
			_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
			if (!(_vehicleMarkers isEqualTo [])) then {
				{
					deleteMarker _x;
				} forEach _vehicleMarkers;
			};
		}
	]
];
createVehicleCrew _vehicle;
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _vehicle))),
	FALSE
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
private _grp = createGroup [EAST,TRUE];
(crew _vehicle) joinSilent _grp;
{
	_x setVehicleReceiveRemoteTargets TRUE;
	_x setVehicleReportRemoteTargets TRUE;
	_x setVariable ['QS_hidden',TRUE,TRUE];
	[_x] join (missionNamespace getVariable 'QS_AI_GRP_AO_AA');
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} forEach (units _grp);
_grp addVehicle _vehicle;
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_vehicle setVariable ['QS_vehicleCrew',[(gunner _vehicle),(commander _vehicle)],FALSE];
if ((random 1) > 0.666) then {
	_vehicle removeWeapon 'autocannon_35mm';
	_vehicle addEventHandler [
		'Fired',
		{
			if (((_this select 0) ammo 'missiles_titan_AA') isEqualTo 0) then {
				(_this select 0) setVehicleAmmo 1;
			};
		}
	];
};
_baseMarker = markerPos 'QS_marker_base_marker';
{
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_x allowDamage FALSE;
	_x addEventHandler ['GetOutMan',{(_this select 0) setDamage 1;}];
} forEach (crew _vehicle);
if (alive _vehicle) then {
	_position = getPosWorld _vehicle;
	_roughPos = [((_position select 0) - 90) + (random 180),((_position select 1) - 90) + (random 180),0];
	_aoAAMarkers = missionNamespace getVariable ['QS_ao_aaMarkers',[]];
	_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
	private _markerID = '';
	{
		_markerID = format ['QS_marker_aoAA_%1',(count _aoAAMarkers)];
		createMarker [_markerID,(_x select 1)];
		_markerID setMarkerTypeLocal (_x select 2);
		_markerID setMarkerShapeLocal (_x select 3);
		if (!((_x select 3) isEqualTo 'Icon')) then {
			_markerID setMarkerBrushLocal (_x select 4);
		};
		_markerID setMarkerColorLocal (_x select 5);
		_markerID setMarkerSizeLocal (_x select 6);
		_markerID setMarkerAlphaLocal (_x select 7);
		_markerID setMarkerPosLocal (_x select 8);
		_markerID setMarkerDirLocal (_x select 9);
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
	if ((random 1) > 0.5) then {
		_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,'OI_support_ENG',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		{
			if ((random 1) < 0.666) then {
				[_unit,(['launch_rpg32_f','launch_rpg32_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),2] call (missionNamespace getVariable 'QS_fnc_addWeapon');
			};
			if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
				(missionNamespace getVariable 'QS_virtualSectors_entities') pushBack _x;
			} else {
				(missionNamespace getVariable 'QS_classic_AI_enemy_0') pushBack _x;
			};
		} forEach (units _grp);
		_grp addVehicle _vehicle;
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[_position,30,30,[]],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,diag_tickTime,-1],FALSE];
	};	
};
_vehicle;