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
_vehicleType = toLowerANSI (typeOf _vehicle);
_vehicle allowCrewInImmobile [TRUE,TRUE];
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
	['QS_reportTarget_disable',TRUE,TRUE],
	['QS_AI_disableSuppFire',TRUE,FALSE]
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
			if ((_killed getVariable ['QS_vehicle_markers',[]]) isNotEqualTo []) then {
				{
					_x setMarkerAlpha 0;
				} count (_killed getVariable 'QS_vehicle_markers');
			};
			deleteVehicleCrew _killed;
			if !(_killed isNil 'QS_vehicleCrew') then {
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
						_killerDisplayName = getText ((configOf (vehicle _instigator)) >> 'displayName');
						_objDisplayName = getText ((configOf _killed) >> 'displayName');
						_name = name _instigator;
						['sideChat',[WEST,'BLU'],(format ['%1 %4 %2 %5 %3!',_name,_objDisplayName,_killerDisplayName,localize 'STR_QS_Chat_045',localize 'STR_QS_Chat_046'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			};
			if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
				['SC_SUB_COMPLETED',['',localize 'STR_QS_Notif_051']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			} else {
				['CompletedSub',[localize 'STR_QS_Notif_052']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			};
		}
	],
	[
		'Fired',
		{
			if ((random 1) > 0.95) then {
				(_this # 0) setVehicleAmmo 1;
			};
		}
	],
	[
		'GetOut',
		{
			(_this # 2) setDamage 1;
			if (((crew (_this # 0)) findIf {(alive _x)}) isEqualTo -1) then {
				(_this # 0) setDamage 1;
			};
		}
	],
	[
		'Deleted',
		{
			params ['_entity'];
			if ((crew _entity) isNotEqualTo []) then {
				deleteVehicleCrew _entity;
			};
			_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
			if (_vehicleMarkers isNotEqualTo []) then {
				{
					deleteMarker _x;
				} forEach _vehicleMarkers;
			};
		}
	]
];
createVehicleCrew _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
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
	_x setVariable ['QS_AI_disableSuppFire',TRUE,FALSE];
} forEach (units _grp);
_grp setVariable ['QS_AI_disableSuppFire',TRUE,FALSE];
_grp addVehicle _vehicle;
_grp enableAttack FALSE;
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_vehicle setVariable ['QS_vehicleCrew',[(gunner _vehicle),(commander _vehicle)],FALSE];
if ((random 1) > 0.666) then {
	_vehicle removeWeapon 'autocannon_35mm';
	_vehicle addEventHandler [
		'Fired',
		{
			if (((_this # 0) ammo 'missiles_titan_AA') isEqualTo 0) then {
				(_this # 0) setVehicleAmmo 1;
			};
		}
	];
};
_baseMarker = markerPos 'QS_marker_base_marker';
{
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_x allowDamage FALSE;
	_x addEventHandler ['GetOutMan',{(_this # 0) setDamage 1;}];
} forEach (crew _vehicle);
if (alive _vehicle) then {
	_position = getPosWorld _vehicle;
	_roughPos = [((_position # 0) - 90) + (random 180),((_position # 1) - 90) + (random 180),0];
	_aoAAMarkers = missionNamespace getVariable ['QS_ao_aaMarkers',[]];
	_vehicleMarkers = _vehicle getVariable ['QS_vehicle_markers',[]];
	private _markerID = '';
	{
		_markerID = format ['QS_marker_aoAA_%1',(count _aoAAMarkers)];
		createMarker [_markerID,(_x # 1)];
		_markerID setMarkerTypeLocal (_x # 2);
		_markerID setMarkerShapeLocal (_x # 3);
		if ((_x # 3) isNotEqualTo 'Icon') then {
			_markerID setMarkerBrushLocal (_x # 4);
		};
		_markerID setMarkerColorLocal (_x # 5);
		_markerID setMarkerSizeLocal (_x # 6);
		_markerID setMarkerAlphaLocal (_x # 7);
		_markerID setMarkerPosLocal (_x # 8);
		_markerID setMarkerDirLocal (_x # 9);
		_markerID setMarkerText (format ['%1%2',(toString [32,32,32]),(_x # 10)]);
		0 = _aoAAMarkers pushBack _markerID;
		0 = _vehicleMarkers pushBack _markerID;
		0 = (missionNamespace getVariable 'QS_virtualSectors_siteMarkers') pushBack _markerID;
	} count [
		['',[0,0,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_roughPos,0,'   '],
		['',[0,0,0],'Empty','Ellipse','Border','ColorOPFOR',[100,100],0,_roughPos,0,'   ']
	];
	missionNamespace setVariable ['QS_ao_aaMarkers',_aoAAMarkers,FALSE];
	_vehicle setVariable ['QS_vehicle_markers',_vehicleMarkers,FALSE];
};
_vehicle;