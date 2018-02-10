/*
File: fn_aoFires.sqf
Author: 

	Quiksilver

Last Modified:

	5/10/2016 A3 1.64 by Quiksilver

Description:

	AO Fires
____________________________________________________________________________*/

params ['_type','_pos','_radius','_qty'];
if (isDedicated) then {
	if (_type isEqualTo 0) then {
		if (!((missionNamespace getVariable 'QS_firesStuff') isEqualTo [])) then {
			{
				if (!isNull _x) then {
					if ((toLower (typeOf _x)) isEqualTo 'test_emptyobjectforfirebig') then {
						_x setDamage 1;
						deleteVehicle _x;
					} else {
						missionNamespace setVariable [
							'QS_analytics_entities_deleted',
							((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
							FALSE
						];
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
		if (!(_fires isEqualTo [])) exitWith {diag_log '***** FIRES ***** already active *****';};
		_wreckTypes = [	
			'Land_Wreck_Hunter_F','Land_Wreck_Truck_F','Land_Bulldozer_01_wreck_F','Land_CombineHarvester_01_wreck_F','Land_Excavator_01_wreck_F','Land_Bulldozer_01_abandoned_F',
			'Land_Wreck_Slammer_F','Land_RailwayCar_01_tank_F','Land_RailwayCar_01_sugarcane_F'
		];
		_wreckType = '';
		_wreck = objNull;
		_fireObj = objNull;
		_dir = random 360;
		for '_x' from 0 to (_qty - 1) step 1 do {
			_position = _pos getPos [((missionNamespace getVariable 'QS_aoSize') * 0.8),_dir];
			if (!(surfaceIsWater _position)) then {
				_randomPos = ['RADIUS',_position,_radius,'LAND',[0,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
				if ((_randomPos distance2D (missionNamespace getVariable 'QS_AOpos')) < 2000) then {
					_wreckType = selectRandom _wreckTypes;
					_randomPos set [2,0];
					_randomPos = AGLToASL _randomPos;
					_configClass = configFile >> 'CfgVehicles' >> _wreckType;
					_model = getText (_configClass >> 'model');
					if ((_model select [0,1]) isEqualTo '\') then {
						_model = _model select [1];
					};
					if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
						_model = _model + '.p3d';
					};
					_randomPos set [2,((_randomPos select 2) + (getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')))];
					_wreck = createSimpleObject [_model,_randomPos];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					_wreck setVectorUp (surfaceNormal _randomPos);
					_array pushBack _wreck;
					_fireObj = createVehicle ['test_EmptyObjectForFireBig',_randomPos,[],0,'NONE'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					_fireObj setDir (getDir _wreck);
					_fireObj allowDamage FALSE;
					_fireObj setVariable ['QS_dynSim_ignore',TRUE,TRUE];
					_fireObj addMPEventHandler [
						'MPKilled', 
						{
							_killed = _this select 0;
							{
								missionNamespace setVariable [
									'QS_analytics_entities_deleted',
									((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
									FALSE
								];
								deleteVehicle _x;
							} forEach (_killed getVariable ['effects',[]]);
							if (isServer) then {
								_killed spawn {
									sleep 1;
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									deleteVehicle _this;
								};
							};
						}
					];
					_fireObj attachTo [_wreck,[0,0,0]];
					detach _fireObj;
					_fires pushBack _fireObj;
					_array pushBack _fireObj;
					_dir = _dir + 120;
				};
			};
		};
		missionNamespace setVariable ['QS_firesStuff',_array,FALSE];
		missionNamespace setVariable ['QS_fires',_fires,TRUE];
		[1] remoteExec ['QS_fnc_aoFires',-2,FALSE];
		_array;
	};
} else {
	if (hasInterface) then {
		if (_type isEqualTo 0) then {

		};
		if (_type isEqualTo 1) then {
			private ['_fire','_pos01','_li'];
			if (!((missionNamespace getVariable 'QS_fires') isEqualTo [])) then {
				{
					if (!isNull _x) then {
						_fire = _x;
						if (!isNil {_fire getVariable 'effects'}) then {
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