_QS_fnc_serverObjectsGrabber = {
	params ['_anchorPos','_anchorDim','_grabOrientation'];
	private ['_type','_objs','_br','_tab','_outputText','_allDynamic','_sim','_objPos','_dX','_dY','_z','_azimuth','_orientation','_outputArray','_simulated'];
	_objs = nearestObjects [_anchorPos,['All'],_anchorDim,TRUE];
	_br = toString [13,10];
	_tab = toString [9];
	_outputText = '/*' + _br + 'Grab data:' + _br;
	_outputText = _outputText + 'Mission: ' + (if (missionName isEqualTo '') then {'Unnamed'} else {missionName}) + _br;
	_outputText = _outputText + 'World: ' + worldName + _br;
	_outputText = _outputText + 'Anchor position: [' + (str (_anchorPos # 0)) + ', ' + (str (_anchorPos # 1)) + ']' + _br;
	_outputText = _outputText + 'Area size: ' + (str _anchorDim) + _br;
	_outputText = _outputText + 'Using orientation of objects: ' + (if (_grabOrientation) then {'yes'} else {'no'}) + _br + '*/' + _br + _br;
	_outputText = _outputText + '[' + _br;
	{
		_allDynamic = allMissionObjects 'All';
		if (_x in _allDynamic) then {
			_sim = getText ((configOf _x) >> 'simulation');
			if (_sim in ['soldier']) then {
				_objs set [_forEachIndex, -1];
			};
		} else {
			_objs set [_forEachIndex, -1];
		};
	} forEach _objs;
	_objs = _objs - [-1];
	{
		_type = typeOf _x;
		_objPos = getPosATL _x; //_objPos = position _x;
		_dX = (_objPos # 0) - (_anchorPos # 0);
		_dY = (_objPos # 1) - (_anchorPos # 1);
		_z = _objPos # 2;
		_azimuth = getDir _x;
		if (_grabOrientation) then {
			_orientation = _x call (missionNamespace getVariable 'BIS_fnc_getPitchBank');
		} else {
			_orientation = [];
		};
		_simulated = simulationEnabled _x;
		_outputArray = [_type,[_dX,_dY,_z],_azimuth,_orientation,FALSE,_simulated,FALSE,{}];
		_outputText = _outputText + _tab + (str _outputArray);
		_outputText = if (_forEachIndex < ((count _objs) - 1)) then {_outputText + ', ' + _br} else {_outputText + _br};
	} forEach _objs;
	_outputText = _outputText + ']';
	copyToClipboard _outputText;
	//systemChat 'done';
	_outputText;
};
[(position player),75,FALSE] call _QS_fnc_serverObjectsGrabber;