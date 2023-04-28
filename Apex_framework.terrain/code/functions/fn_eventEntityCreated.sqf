/*
File: fn_eventEntityDeleted.sqf
Author:

	Quiksilver
	
Last modified:

	27/05/2022 A3 2.10 by Quiksilver
	
Description:

	Entity Created mission event
	
Notes:

	This system can be used for adding modded units, and diagnostics
	We do not use it in regular play as it executes frequently and uses considerable CPU time for marginal gain
__________________________________________________*/

/*/
QS_hashmap_createdTypes = createHashMap;
removeAllMissionEventHandlers 'EntityCreated';
addMissionEventHandler [
	'EntityCreated',
	{
		params ['_entity'];
		diag_log (format ['Entity Created: %1',_this]);
		_modelInfo = (getModelInfo _entity) # 1;
		private _value = QS_hashmap_createdTypes getOrDefault [_modelInfo,[]];
		if (_value isEqualTo []) then {
			_value = [typeOf _entity,(getModelInfo _entity) # 1,isSimpleObject _entity,1];
			QS_hashmap_createdTypes set [_modelInfo,_value];
		} else {
			_count = (_value # 3) + 1;
			_value set [3,_count];
			QS_hashmap_createdTypes set [_modelInfo,_value];
			diag_log str _value;
		};	
	}
];

removeAllMissionEventHandlers 'EntityCreated';
private _array = QS_hashmap_createdTypes toArray FALSE;
_array = _array apply { [_x # 0,_x # 3] };
{
	diag_log str _x;
	uiSleep 0.1;
} forEach _array;






params ['_entity'];
diag_log (format ['Entity Created: %1',_this]);
_modelInfo = getModelInfo _entity;
private _value = QS_hashmap_createdTypes getOrDefault [_modelInfo,[]];
if (_value isEqualTo []) then {
	_value = [typeOf _entity,(getModelInfo _entity) # 1,isSimpleObject _entity,1];
	QS_hashmap_createdTypes set [_modelInfo,_value];
} else {
	_count = (_value # 3) + 1;
	_value set [3,_count];
	QS_hashmap_createdTypes set [_modelInfo,_value];
	systemchat str _value;
};
/*/







//hashMap set [key, value, insertOnly]















/*/
QS_analytics_entities_created = QS_analytics_entities_created + 1;
QS_analytics_entities_log = QS_analytics_entities_log select {!isNull _x};
QS_analytics_entities_log pushBack _entity;
/*/