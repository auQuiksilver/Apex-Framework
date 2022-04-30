/*/
File: fn_wellHandleDamage.sqf
Author: 

	Quiksilver

Last Modified:

	23/11/2017 A3 1.78 by Quiksilver

Description:

	Well Handle Damage
____________________________________________________________________________/*/

params ['_entity','','_dmg'];
if (_dmg > 10) then {
	_entity setVariable ['QS_entity_sumDmg',((_entity getVariable ['QS_entity_sumDmg',0]) + _dmg),TRUE];
};
if ((_entity getVariable ['QS_entity_sumDmg',0]) >= (_entity getVariable ['QS_entity_reqDmg',1500])) then {
	params ['','','','','','','_instigator',''];
	_entity removeEventHandler ['HandleDamage',_thisEventHandler];
	private _position = position _entity;
	_position set [2,0];
	_surfaceNormal = surfaceNormal _position;
	{
		deleteVehicle _x;
	} forEach ((_this select 0) getVariable ['QS_entity_assocObjects',[]]);
	deleteVehicle (_this select 0);
	_craterType = selectRandomWeighted ['CraterLong',0.666,'CraterLong_small',0.333];
	_configClass = configFile >> 'CfgVehicles' >> _craterType;
	_model = getText (_configClass >> 'model');
	if ((_model select [0,1]) isEqualTo '\') then {
		_model = _model select [1];
	};
	if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
		_model = _model + '.p3d';
	};
	_position = AGLToASL _position;
	_position set [2,((_position select 2) + ((getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')) - (random [0,0.05,0.1])))];
	_crater = createSimpleObject [_model,_position];
	_crater setDir (random 360);
	_crater setVectorUp _surfaceNormal;
	_smoke = createVehicle ['test_emptyObjectForSmoke',(position _crater),[],0,'NONE'];
	_smoke attachTo [_crater,[0,0,0]];
	_smoke setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	detach _smoke;
	(missionNamespace getVariable 'QS_grid_aoProps') pushBack _crater;
	(missionNamespace getVariable 'QS_grid_aoProps') pushBack _smoke;
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smoke,'DELAYED_FORCED',(time + 600)];
	deleteVehicle _entity;
	missionNamespace setVariable ['QS_grid_AIRspDestroyed',((missionNamespace getVariable 'QS_grid_AIRspDestroyed') + 1),FALSE];
	['GRID_IG_UPDATE',['Area of Operations','Respawn tunnel destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	if (!isNull _instigator) then {
		if (isPlayer _instigator) then {
			_instigator addScore 1;
			_text = format ['%1 (%2) destroyed an enemy tunnel entrance',(name _instigator),(groupID (group _instigator))];
			_text remoteExec ['systemChat',-2,FALSE];
		};
	};
};
0;