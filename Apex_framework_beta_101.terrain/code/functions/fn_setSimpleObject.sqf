/*
File: fn_setSimpleObject.sqf
Author:

	Quiksilver
	
Last Modified: 

	1/05/2016 A3 1.58 by Quiksilver
	
Description:

	Replace vehicle with simple object
__________________________________________________*/

_oldObj = param [0,objNull];
_alternate = param [1,FALSE];
if (isNull _oldObj) exitWith {diag_log '***** DEBUG ***** fn_setSimpleObject ***** Object is null';_oldObj};
private _position = getPosWorld _oldObj;
/*/
if (_alternate) then {
	_position = getPosASL _oldObj;
};
/*/
_vectorDirUp = [(vectorDir _oldObj),(vectorUp _oldObj)];
_modelInfo = getModelInfo _oldObj;
if (_modelInfo isEqualTo []) exitWith {diag_log format ['***** DEBUG ***** fn_setSimpleObject ***** No model info for %1 *****',(typeOf _oldObj)];_oldObj};
private _model = _modelInfo select 1;
if (_alternate) then {
	_model = typeOf _oldObj;
};
missionNamespace setVariable [
	'QS_analytics_entities_deleted',
	((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
	FALSE
];
deleteVehicle _oldObj;
_obj = createSimpleObject [_model,_position];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_obj setVectorDirAndUp _vectorDirUp;
_obj;