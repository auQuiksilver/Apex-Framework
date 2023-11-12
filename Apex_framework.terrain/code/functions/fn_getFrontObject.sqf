/*/
File: fn_getFrontObject.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/11/2023 A3 2.14 by Quiksilver
	
Description:

	Get object infront
______________________________________________________/*/

params ['_mode','_vehicle'];
if (_mode isEqualTo 0) exitWith {
	_cursor = cursorObject;
	private _target = objNull;
	(0 boundingBoxReal _vehicle) params ['_p1','_p2','_rad'];
	_modelXhalf = ((_p1 # 0) + (_p2 # 0)) / 2;
	_modelY = _p2 # 1;
	_modelZ = _p1 # 2;
	_frontModelPos = [_modelXhalf,_modelY,_modelZ] vectorAdd [0,2,0.1];
	_frontModelPos2 = _frontModelPos vectorAdd [0,0,10];
	_frontModelPos3 = _frontModelPos vectorAdd [0,0,-1];
	_frontModelPos4 = [_modelXhalf,_modelY,_modelZ] vectorAdd [0,1,0.1];
	_frontModelPos5 = _frontModelPos4 vectorAdd [0,0,10];
	_frontModelPos6 = _frontModelPos4 vectorAdd [0,0,-1];
	private _intersections = lineIntersectsSurfaces [
		_vehicle modelToWorldWorld _frontModelPos2,
		_vehicle modelToWorldWorld _frontModelPos3
	];
	_intersections = _intersections + (
		lineIntersectsSurfaces [
			_vehicle modelToWorldWorld _frontModelPos5,
			_vehicle modelToWorldWorld _frontModelPos6
		]
	);
	if (_intersections isNotEqualTo []) then {
		private _test = objNull;
		_intersections = _intersections select {
			_test = _x # 3;
			(
				(!isNull _test) &&
				{(!isPlayer _test)} &&
				{((crew _test) isEqualTo [])} &&
				{(simulationEnabled _test)} &&
				{(!(_test getVariable ['QS_lockedInventory',FALSE]))} &&
				{(
					(_test getVariable ['QS_logistics',FALSE]) || 
					(_test getVariable ['QS_logistics_wreck',FALSE]) ||
					(_test isKindOf 'Reammobox_F') ||
					(_test isKindOf 'Cargo_base_F') ||
					(_test isKindOf 'Slingload_base_F')
				)} &&
				{(!(_test getVariable ['QS_logistics_deployed',FALSE]))} &&
				{((getObjectType _test) isEqualTo 8)} &&
				{((getMass _test) <= (_vehicle getVariable ['QS_vehicle_lift',-1]))} &&
				{(!(_test getVariable ['attached',FALSE]))} &&
				{(!((locked _test) in [2,3]))} &&
				//{(!(lockedInventory _test))} &&
				{(!(_test in (attachedObjects _vehicle)))} &&
				{(isNull (ropeAttachedTo _test))}// &&
				//{((attachedObjects _test) isEqualTo [])}
			)
		};
		if (_intersections isNotEqualTo []) then {
			{
				if (_cursor isEqualTo (_x # 3)) exitWith {
					_target = _cursor;
				};
			} forEach _intersections;
			if (isNull _target) then {
				_target = (_intersections # 0) # 3;
			};
		};
	};
	_target;
};