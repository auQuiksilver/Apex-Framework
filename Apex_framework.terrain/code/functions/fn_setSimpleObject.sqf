/*
File: fn_setSimpleObject.sqf
Author:

	Quiksilver
	
Last Modified: 

	01/05/2023 A3 1.58 by Quiksilver
	
Description:

	Replace vehicle with simple object
__________________________________________________*/

_oldObj = param [0,objNull];
_alternate = param [1,FALSE];
if (isNull _oldObj) exitWith {diag_log localize 'STR_QS_DiagLogs_172';_oldObj};
private _position = getPosWorld _oldObj;
/*/
if (_alternate) then {
	_position = getPosASL _oldObj;
};
/*/
_vectorDirUp = [(vectorDir _oldObj),(vectorUp _oldObj)];
_modelInfo = getModelInfo _oldObj;
if (_modelInfo isEqualTo []) exitWith {diag_log (format [localize 'STR_QS_DiagLogs_173',(typeOf _oldObj)]);_oldObj};
private _model = _modelInfo # 1;
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
_obj setVectorDirAndUp _vectorDirUp;
_obj;