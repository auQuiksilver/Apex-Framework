/*/
File: fn_wellHandleDamage.sqf
Author: 

	Quiksilver

Last Modified:

	23/12/2022 A3 2.10 by Quiksilver

Description:

	Well Handle Damage
_______________________________________________________/*/

params ['_entity','','_dmg'];
if (_dmg > 10) then {
	_entity setVariable ['QS_entity_sumDmg',((_entity getVariable ['QS_entity_sumDmg',0]) + _dmg),FALSE];
};
if ((_entity getVariable ['QS_entity_sumDmg',0]) >= (_entity getVariable ['QS_entity_reqDmg',1500])) then {
	params ['','','','','','','_instigator',''];
	private _info = [];
	_entity removeEventHandler [_thisEvent,_thisEventHandler];
	private _position = position _entity;
	_position set [2,0];
	_surfaceNormal = surfaceNormal _position;
	_attachedTo = attachedTo _entity;
	if (!isNull _attachedTo) then {
		{
			_x setDamage [1,FALSE];
			deleteVehicle _x;
		} forEach (attachedObjects _attachedTo);
	};
	deleteVehicle ((_this # 0) getVariable ['QS_entity_assocObjects',[]]);
	deleteVehicle (_this # 0);
	_craterType = selectRandomWeighted ['CraterLong',0.666,'CraterLong_small',0.333];
	_info = QS_hashmap_simpleObjectInfo getOrDefault [_craterType,[]];
	if (_info isEqualTo []) then {
		_configClass = configFile >> 'CfgVehicles' >> _craterType;
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
		QS_hashmap_simpleObjectInfo set [_craterType,_info];
	};
	_position = (AGLToASL _position) vectorAdd [0,0,((_info # 1) - (random [0,0.05,0.1]))];
	_crater = createSimpleObject [_info # 0,_position];
	_crater setDir (random 360);
	_crater setVectorUp _surfaceNormal;
	_smoke = createVehicle ['test_emptyObjectForSmoke',(position _crater),[],0,'NONE'];
	[1,_smoke,[_crater,[0,0,0]]] call QS_fnc_eventAttach;
	_smoke setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	[0,_smoke] call QS_fnc_eventAttach;
	(missionNamespace getVariable 'QS_grid_aoProps') pushBack _crater;
	(missionNamespace getVariable 'QS_grid_aoProps') pushBack _smoke;
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smoke,'DELAYED_DISCREET',(time + 900)];
	deleteVehicle _entity;
	
	
	if (diag_tickTime > (uiNamespace getVariable ['QS_grid_tunnelDestroyedMessageCooldown',-1])) then {
		uiNamespace setVariable ['QS_grid_tunnelDestroyedMessageCooldown',diag_tickTime + 0.5];
		missionNamespace setVariable ['QS_grid_AIRspDestroyed',((missionNamespace getVariable 'QS_grid_AIRspDestroyed') + 1),FALSE];
		['GRID_IG_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_116']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		if (!isNull _instigator) then {
			if (isPlayer _instigator) then {
				_instigator addScore 1;
				_text = format ['%1 (%2) %3',(name _instigator),(groupID (group _instigator)),localize 'STR_QS_Chat_163'];
				_text remoteExec ['systemChat',-2,FALSE];
			};
		};
	};
};
0;