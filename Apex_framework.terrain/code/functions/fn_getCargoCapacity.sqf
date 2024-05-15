/*/
File: fn_getCargoCapacity.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
	
Notes:

	maxLoadMass = 10000;
	cargoBayDimensions[] = {"VVT_cargo_1","VVT_cargo_2"};
	
	20' shipping container volume:
		
		40
		
	10' shipping container volume:
	
		20
		
	40' shipping container volume:
	
		80
		
	red cargo box:
	
		3.5
______________________________________________________/*/

params ['_vehicle',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	//comment 'Physical';
	private _cargoMaxCapacity = 0;
	private _cargoMaxMass = 0;
	private _cargoMaxCoef = 0;
	private _result = [];
	_coefTable = [
		['Cargo_base_F',2],
		['B_Slingload_01_Cargo_F',2],
		['Land_Pod_Heli_Transport_04_box_F',2],
		['LandVehicle',0.25],
		['Air',0.1],
		['Ship',0.1]
	];
	if (isNil 'QS_hashmap_maxCargoCapacity') then {
		QS_hashmap_maxCargoCapacity = createHashMap;
	};
	if (_vehicle isEqualType objNull) then {
		_result = QS_hashmap_maxCargoCapacity getOrDefault [toLowerANSI (typeOf _vehicle),[]];
	} else {
		_result = QS_hashmap_maxCargoCapacity getOrDefault [toLowerANSI _vehicle,[]];
	};
	if (_result isNotEqualTo []) then {
		_cargoMaxCapacity = _result # 0;
		_cargoMaxMass = _result # 1;
		_cargoMaxCoef = _result # 2;
	};
	if (
		(_cargoMaxCapacity isEqualTo 0) &&
		{(_vehicle isEqualType objNull)} &&
		{(isClass ((configOf _vehicle) >> 'VehicleTransport' >> 'Carrier'))}
	) then {
		private _cargoPoints = getArray ((configOf _vehicle) >> 'VehicleTransport' >> 'Carrier' >> 'cargoBayDimensions');
		_cargoPoints = _cargoPoints apply { _vehicle selectionPosition _x };
		_cargoPoints params ['_cargoPoint1','_cargoPoint2'];
		(_cargoPoint2 vectorDiff _cargoPoint1) params ['_dimX','_dimY','_dimZ'];
		_cargoMaxCapacity = abs (_dimX * _dimY * _dimZ);
		_cargoMaxMass = getNumber ((configOf _vehicle) >> 'VehicleTransport' >> 'Carrier' >> 'maxLoadMass');
		{
			if (_vehicle isKindOf (_x # 0)) exitWith {
				_cargoMaxCoef = _x # 1;
			};
		} forEach _coefTable;
		QS_hashmap_maxCargoCapacity set [toLowerANSI (typeOf _vehicle),[_cargoMaxCapacity,_cargoMaxMass,_cargoMaxCoef]];
	};
	if (
		(_cargoMaxCapacity isEqualTo 0) &&
		{(_vehicle isEqualType '')} &&
		{(isClass (configFile >> 'CfgVehicles' >> _vehicle >> 'VehicleTransport' >> 'Carrier'))}
	) then {
		_obj = createSimpleObject [_vehicle,[-5000,-5000,100 + (random 1000)],TRUE];
		private _cargoPoints = getArray ((configOf _obj) >> 'VehicleTransport' >> 'Carrier' >> 'cargoBayDimensions');
		_cargoPoints = _cargoPoints apply { _obj selectionPosition _x };
		_cargoPoints params ['_cargoPoint1','_cargoPoint2'];
		(_cargoPoint2 vectorDiff _cargoPoint1) params ['_dimX','_dimY','_dimZ'];
		_cargoMaxCapacity = abs (_dimX * _dimY * _dimZ);
		_cargoMaxMass = getNumber ((configOf _obj) >> 'VehicleTransport' >> 'Carrier' >> 'maxLoadMass');
		{
			if (_obj isKindOf (_x # 0)) exitWith {
				_cargoMaxCoef = _x # 1;
			};
		} forEach _coefTable;
		QS_hashmap_maxCargoCapacity set [toLowerANSI _vehicle,[_cargoMaxCapacity,_cargoMaxMass,_cargoMaxCoef]];
		deleteVehicle _obj;
	};
	if (_cargoMaxCapacity isEqualTo 0) then {
		if (([
			'LandVehicle',
			'Air',
			'Ship',
			'Cargo_base_F',
			'B_Slingload_01_Cargo_F',
			'Land_Pod_Heli_Transport_04_box_F'
		] findIf { _vehicle isKindOf _x }) isNotEqualTo -1) then {
			{
				if (_vehicle isKindOf (_x # 0)) exitWith {
					_cargoMaxCoef = _x # 1;
				};
			} forEach _coefTable;
			if (_vehicle isEqualType objNull) then {
				_vehicleVolume = [_vehicle] call QS_fnc_getObjectVolume;
				_cargoMaxCapacity = _vehicleVolume * _cargoMaxCoef;
				_cargoMaxMass = ((getModelInfo _vehicle) # 4) * _cargoMaxCoef;				
				QS_hashmap_maxCargoCapacity set [toLowerANSI (typeOf _vehicle),[_cargoMaxCapacity,_cargoMaxMass max 1000,_cargoMaxCoef]];
			} else {
				_obj = createVehicleLocal [_vehicle,[-5000,-5000,100 + (random 1000)]];
				_vehicleVolume = [_obj] call QS_fnc_getObjectVolume;
				_cargoMaxCapacity = _vehicleVolume * _cargoMaxCoef;
				_cargoMaxMass = (getMass _obj) * _cargoMaxCoef;
				QS_hashmap_maxCargoCapacity set [toLowerANSI _vehicle,[_cargoMaxCapacity,_cargoMaxMass max 1000,_cargoMaxCoef]];
				deleteVehicle _obj;
			};
		};
	};
	_customCargoCapacity = _vehicle getVariable ['QS_customCargoCapacity',[]];
	if (_customCargoCapacity isNotEqualTo []) then {
		_cargoMaxCapacity = _customCargoCapacity # 0;
		_cargoMaxMass = _customCargoCapacity # 1;
		_cargoMaxCoef = _customCargoCapacity # 2;
	};
	[_cargoMaxCapacity,_cargoMaxMass,_cargoMaxCoef]
};
if (_mode isEqualTo 1) exitWith {
	//comment 'Virtual';
	[0,0,0]
};

