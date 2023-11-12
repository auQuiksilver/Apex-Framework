/*
File: fn_zonePreset.sqf
Author: 

	Quiksilver

Last Modified:

	10/11/2023 A3 2.14 by Quiksilver

Description:

	-
_______________________________________________*/

params ['_mode'];
if (_mode isEqualTo 0) then {
	//comment 'MAIN BASE';
	private _safezoneRadius = 500;
	if (worldName isEqualTo 'Altis') then {_safezoneRadius = 750;};
	if (worldName isEqualTo 'Tanoa') then {_safezoneRadius = 500;};
	if (worldName isEqualTo 'Malden') then {_safezoneRadius = 500;};
	if (worldName isEqualTo 'Enoch') then {_safezoneRadius = 500;};
	if (worldName isEqualTo 'Stratis') then {_safezoneRadius = 500;};
	_szIn = {
		params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
		[1] call QS_fnc_clientEventFiredPrevent;
		private _newId = '';
		if (QS_baseProtection_polygons isNotEqualTo []) then {
			{
				_newId = format ['BASE_SPEEDZONE_%1',_forEachIndex];
				QS_system_zonesLocal pushBack [
					_newId,TRUE,'SPEED','POLY',1,[_x,30],
					{
						QS_limitspeed_EH = addMissionEventhandler ['EachFrame',{call QS_fnc_limitSpeed}];
					},
					{ 
						removeMissionEventHandler ['EachFrame',QS_limitspeed_EH];
					},{(!(cameraOn isKindOf 'CAManBase'))},{},[WEST]
				];
			} forEach QS_baseProtection_polygons;
		};
		//comment 'Default base safe-polygon';
		_centroid = QS_base_safePolygon call QS_fnc_geomPolygonCentroid;
		_zoneEval = {
			if (diag_tickTime > (localNamespace getVariable ['QS_spawnprotection_interval',-1])) then {
				localNamespace setVariable ['QS_spawnprotection_interval',diag_tickTime + (5 + (random 5))];
				_entities = entities [['LandVehicle','Air','Ship','StaticWeapon','Reammobox_F'],[],FALSE,FALSE];
				private _deleteDelay = FALSE;
				{
					if (local _x) then {
						if (
							(_x inPolygon QS_base_safePolygon) &&
							{(((getPos _x) # 2) < 2)} &&
							{!isObjectHidden _x}
						) then {
							_deleteDelay = FALSE;
							if (unitIsUav _x) then {
								deleteVehicleCrew _x;
							};
							if ((attachedObjects _x) isNotEqualTo []) then {
								{
									[0,_x] call QS_fnc_eventAttach;
									deleteVehicle _x;
								} foreach (attachedObjects _x);
							};
							if (!isNull (ropeAttachedTo _x)) then {
								if (_x isEqualTo (getSlingLoad (ropeAttachedTo _x))) then {
									(ropeAttachedTo _x) setSlingLoad objNull;
									_deleteDelay = TRUE;
								};
							};
							50 cutText [localize 'STR_QS_Utility_034','PLAIN DOWN',0.35];
							['systemChat',format [localize 'STR_QS_Utility_033',profileName,(getText ((configOf _x) >> 'displayName'))]] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							if (_deleteDelay) then {
								_x spawn {sleep 1; deleteVehicle _this;};
							} else {
								deleteVehicle _x;
							};
						};
					};
				} forEach _entities;
			};
		};
		['ADD_LOCAL',['SPAWNPROTECTION_0',TRUE,'V_DELETE','RAD',1,[_centroid,100],{},{},{TRUE},_zoneEval,[WEST]]] call QS_fnc_zoneManager;
	};
	_szOut = {
		params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
		[0] call QS_fnc_clientEventFiredPrevent;
		private _speedzoneIDs = [];
		private _newId = '';
		if (QS_baseProtection_polygons isNotEqualTo []) then {
			{
				_newId = format ['BASE_SPEEDZONE_%1',_forEachIndex];
				_speedzoneIDs pushBack _newId;
			} forEach QS_baseProtection_polygons;
			{
				if ((_x # 0) in _speedzoneIDs) then {
					QS_system_zonesLocal set [_forEachIndex,FALSE];
				};
			} forEach QS_system_zonesLocal;
		};
		QS_system_zonesLocal = QS_system_zonesLocal select { (_x isEqualType []) };
		['REMOVE_LOCAL','SPAWNPROTECTION_0'] call QS_fnc_zoneManager;
	};
	_szEval = {
		[1] call QS_fnc_clientEventFiredPrevent;
		if (
			(!isNull cameraOn) &&
			{(local cameraOn)} &&
			{(isManualFire cameraOn)}
		) then {
			action ['manualFireCancel',cameraOn];
		};
	};
	_szCondition = {
		TRUE
	};
	['ADD',['BASE_HIGHSEC_0',TRUE,'SAFE','RAD',2,['QS_marker_base_marker',_safezoneRadius],_szIn,_szOut,_szCondition,_szEval,[WEST]]] call QS_fnc_zoneManager;
};
if (_mode isEqualTo 1) then {
	//comment 'FOB';
	private _safezoneRadius = 100;
	_szIn = {
		
	};
	_szOut = {
		
	};
	_szEval = {
		
	};
	_szCondition = {
		TRUE
	};		
	['ADD',['FOB_LOWSEC_0',TRUE,'SAFE','RAD',1,['QS_marker_module_fob',_safezoneRadius],_szIn,_szOut,_szCondition,_szEval,[WEST]]] call QS_fnc_zoneManager;
};
if (_mode isEqualTo 2) then {
	//comment 'CARRIER';
	_szIn = {
		
	};
	_szOut = {
		
	};
	_szEval = {
		
	};
	_szCondition = {
		TRUE
	};
	_worldPolygon = [[-41.34,171.173,23.605],[-41.0483,-70.9946,23.5818],[45.5078,-63.2866,23.5561],[42.7202,150.547,23.5823]] apply { ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x) };
	['ADD',['CARRIER_0',TRUE,'SAFE','POLY',1,[_worldPolygon,100],_szIn,_szOut,_szCondition,_szEval,[WEST]]] call QS_fnc_zoneManager;
};
if (_mode isEqualTo 3) then {
	//comment 'DESTROYER';
	_szIn = {
		
	};
	_szOut = {
		
	};
	_szEval = {
		
	};
	_szCondition = {
		TRUE
	};	
	_worldPolygon = [[13.0117,92.106,8.71204],[-13.0034,92.1133,8.74377],[-15.9448,42.8906,8.58817],[-14.6387,-16.2246,8.67601],[-9.54688,-67.8555,8.99917],[-0.864258,-110.585,13.127],[1.05225,-110.629,12.7627],[9.64355,-65.5073,12.7884],[12.6826,-37.0854,12.8368],[15.8574,6.70361,8.00518],[14.5059,69.4863,8.44093]] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
	['ADD',['DESTROYER_0',TRUE,'SAFE','POLY',1,[_worldPolygon,100],_szIn,_szOut,_szCondition,_szEval,[WEST]]] call QS_fnc_zoneManager;
};