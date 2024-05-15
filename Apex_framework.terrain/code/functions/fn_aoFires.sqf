/*
File: fn_aoFires.sqf
Author: 

	Quiksilver

Last Modified:

	7/11/2022 A3 2.10 by Quiksilver

Description:

	AO Fires
____________________________________________________________________________*/

params ['_type','_pos','_radius','_qty'];
if (isDedicated) then {
	if (_type isEqualTo 0) then {
		if ((missionNamespace getVariable 'QS_firesStuff') isNotEqualTo []) then {
			{
				if (!isNull _x) then {
					if ((toLowerANSI (typeOf _x)) isEqualTo 'test_emptyobjectforfirebig') then {
						_x setDamage 1;
						deleteVehicle _x;
					} else {
						deleteVehicle _x;
					};
				};
			} forEach (missionNamespace getVariable 'QS_firesStuff');
			missionNamespace setVariable ['QS_firesStuff',[],FALSE];
			missionNamespace setVariable ['QS_fires',[],TRUE];
		};
	};
	if (_type isEqualTo 1) then {
		private ['_array','_vehicle','_fire','_wreckType','_wreck','_fireObj','_randomPos','_position','_fires','_dir','_configClass','_model'];
		_array = missionNamespace getVariable ['QS_firesStuff',[]];
		_fires = missionNamespace getVariable ['QS_fires',[]];
		if (_fires isNotEqualTo []) exitWith {diag_log '***** FIRES ***** already active *****';};
		_wreckTypes = ['fires_wrecktypes_1'] call QS_data_listVehicles;
		_wreckType = '';
		_wreck = objNull;
		_fireObj = objNull;
		_dir = random 360;
		private _usedPositions = [[-5000,-5000,0]];
		private _spawned = 0;
		private _info = [];
		private _model = '';
		private _configClass = '';
		for '_x' from 0 to 99 step 1 do {
			_position = _pos getPos [(missionNamespace getVariable 'QS_aoSize') * 0.75,_dir];
			_randomPos = ['RADIUS',_position,_radius,'LAND',[0,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				(!([_randomPos,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) &&
				{((_randomPos distance2D (missionNamespace getVariable 'QS_aoPos')) < 1500)} &&
				{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_randomPos,100,100,0,FALSE]) isEqualTo [])} &&
				{((_usedPositions inAreaArray [_randomPos,100,100,0,FALSE]) isEqualTo [])}
			) then {
				_spawned = _spawned + 1;
				_wreckType = selectRandomWeighted _wreckTypes;
				_randomPos set [2,0];
				_usedPositions pushBack _randomPos;
				_randomPos = AGLToASL _randomPos;
				_info = QS_hashmap_simpleObjectInfo getOrDefault [_wreckType,[]];
				if (_info isEqualTo []) then {
					_configClass = configFile >> 'CfgVehicles' >> _wreckType;
					_model = getText (_configClass >> 'model');
					if ((_model select [0,1]) isEqualTo '\') then {
						_model = _model select [1];
					};
					if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
						_model = _model + '.p3d';
					};
					_info = [
						_model,
						(getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')),
						(toLowerANSI (getText (_configClass >> 'vehicleClass')))
					];
					QS_hashmap_simpleObjectInfo set [_wreckType,_info];
				};
				_randomPos = _randomPos vectorAdd [0,0,_info # 1];
				_wreck = createSimpleObject [_info # 0,_randomPos];
				_wreck setDir (random 360);
				_wreck setVectorUp (surfaceNormal _randomPos);
				_array pushBack _wreck;
				_fireObj = createVehicle ['test_EmptyObjectForFireBig',_randomPos,[],0,'NONE'];
				_fireObj setDir (getDir _wreck);
				_fireObj allowDamage FALSE;
				_fireObj setVariable ['QS_dynSim_ignore',TRUE,TRUE];
				_fireObj addMPEventHandler [
					'MPKilled', 
					{
						_killed = _this # 0;
						deleteVehicle (_killed getVariable ['effects',[]]);
						if (isServer) then {
							_killed spawn {
								sleep 1;
								deleteVehicle _this;
							};
						};
					}
				];
				[1,_fireObj,[_wreck,[0,0,0]]] call QS_fnc_eventAttach;
				[0,_fireObj] call QS_fnc_eventAttach;
				_fires pushBack _fireObj;
				_array pushBack _fireObj;
				_dir = _dir + (random [100,120,140]);		
			};
			if (_spawned >= _qty) exitWith {};
		};
		missionNamespace setVariable ['QS_firesStuff',_array,FALSE];
		missionNamespace setVariable ['QS_fires',_fires,TRUE];
		0 spawn {
			sleep 2;
			[1] remoteExec ['QS_fnc_aoFires',-2,FALSE];
		};
		_array;
	};
} else {
	if (hasInterface) then {
		if (_type isEqualTo 0) then {

		};
		if (_type isEqualTo 1) then {
			if ((missionNamespace getVariable 'QS_fires') isNotEqualTo []) then {
				private _fire = objNull;
				{
					if (!isNull _x) then {
						_fire = _x;
						if !(_fire isNil 'effects') then {
							{
								if ((typeOf _x) isEqualTo '#lightpoint') then {
									_x setLightBrightness 2.75;
									_x setLightAmbient [1,0.28,0.05];
									_x setLightColor [1,0.28,0.05];
									_x setLightAttenuation [3,4,6,0.0125,5,600];
								};
							} count (_fire getVariable 'effects');
						};
					};
				} forEach (missionNamespace getVariable 'QS_fires');
			};
		};
	};
};