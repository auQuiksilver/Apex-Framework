/*/
File: fn_scGetNearestSector.sqf
Author: 

	Quiksilver

Last Modified:

	6/06/2017 A3 1.70 by Quiksilver

Description:

	Get Nearest Sector
	
_sectorData params [
0	'_sectorID',
1	'_isActive',
2	'_nextEvaluationTime',
3	'_increment',
4	'_minConversionTime',
5	'_interruptMultiplier',
6	'_areaType',
7	'_centerPos',
8	'_areaOrRadiusConvert',
9	'_areaOrRadiusInterrupt',
10	'_sidesOwnedBy',
11	'_sidesCanConvert',
12	'_sidesCanInterrupt',
13	'_conversionValue',
14	'_conversionValuePrior',
15	'_conversionAlgorithm',
16	'_importance',
17	'_flagData',
18	'_sectorAreaObjects',
19	'_locationData',
20	'_objectData',
21	'_markerData',
22	'_taskData',
23	'_initFunction',
24	'_manageFunction',
25	'_exitFunction',
26	'_conversionRate',
27 '_isBeingInterrupted'
];

____________________________________________________________________________/*/

params ['_type','_position'];
if (_type isEqualTo 0) exitWith {
	comment 'Get absolute nearest sector';
	private _var = 'QS_virtualSectors_data';
	if (!isDedicated) then {
		_var = 'QS_virtualSectors_data_public';
	};
	private _sectorsData = [];
	private _sectorPositions = [];
	private _sectorPosition = [];
	if ((missionNamespace getVariable _var) isNotEqualTo []) then {
		_sectorsData = missionNamespace getVariable [_var,[]];
		if (_sectorsData isNotEqualTo []) then {
			{
				_sectorPositions pushBack (_x # 7);
			} forEach _sectorsData;
			_sectorPosition = _sectorPositions # 0;
			if ((count _sectorPositions) > 1) then {
				private _dist = _position distance2D _sectorPosition;
				{
					if ((_position distance2D _x) < _dist) then {
						_dist = _position distance2D _x;
						_sectorPosition = _x;
					};
				} forEach _sectorPositions;
			};
		};
	};
	_sectorPosition;
};
if (_type isEqualTo 1) exitWith {
	comment 'Get nearest sector by side';
	_side = _this # 2;
	private _sectorsData = [];
	private _sectorsSide = [];
	private _sectorPositions = [];
	private _sectorPosition = [];
	if ((missionNamespace getVariable 'QS_virtualSectors_data') isNotEqualTo []) then {
		_sectorsData = missionNamespace getVariable ['QS_virtualSectors_data',[]];
		if (_sectorsData isNotEqualTo []) then {
			{
				if (_side in (_x # 10)) then {
					_sectorsSide pushBack _x;
				};
			} forEach _sectorsData;
		};
	};
	if (_sectorsSide isNotEqualTo []) then {
		{
			_sectorPositions pushBack (_x # 7);
		} forEach _sectorsSide;
		_sectorPosition = _sectorPositions # 0;
		if ((count _sectorPositions) > 1) then {
			private _dist = _position distance2D _sectorPosition;
			{
				if ((_position distance2D _x) < _dist) then {
					_dist = _position distance2D _x;
					_sectorPosition = _x;
				};
			} forEach _sectorPositions;
		};
	};
	_sectorPosition;
};
if (_type isEqualTo 2) exitWith {
	comment 'Get nearest LOSING sector';
	_side = _this # 2;
	private _sectorsData = [];
	private _sectorsLosing = [];
	private _sectorPosition = [];
	private _sectorPositions = [];
	if ((missionNamespace getVariable 'QS_virtualSectors_data') isNotEqualTo []) then {
		_sectorsData = missionNamespace getVariable ['QS_virtualSectors_data',[]];
		if (_sectorsData isNotEqualTo []) then {
			{
				if (_side in (_x # 10)) then {
					if ((_x # 14) > (_x # 13)) then {
						_sectorsLosing pushBack _x;
					};
				};
			} forEach _sectorsData;
		};
	};
	if (_sectorsLosing isNotEqualTo []) then {
		{
			_sectorPositions pushBack (_x # 7);
		} forEach _sectorsLosing;
		_sectorPosition = _sectorPositions # 0;
		if ((count _sectorPositions) > 1) then {
			private _dist = _position distance2D _sectorPosition;
			{
				if ((_position distance2D _x) < _dist) then {
					_dist = _position distance2D _x;
					_sectorPosition = _x;
				};
			} forEach _sectorPositions;
		};
	};
	_sectorPosition;
};
if (_type isEqualTo 3) exitWith {
	comment 'Get nearest TAKING sector';
	_side = _this # 2;
	private _sectorsData = [];
	private _sectorsTaking = [];
	private _sectorPosition = [];
	private _sectorPositions = [];
	if ((missionNamespace getVariable 'QS_virtualSectors_data') isNotEqualTo []) then {
		_sectorsData = missionNamespace getVariable ['QS_virtualSectors_data',[]];
		if (_sectorsData isNotEqualTo []) then {
			{
				if (_side in (_x # 11)) then {
					if ((_x # 14) > (_x # 13)) then {
						_sectorsTaking pushBack _x;
					};
				};
			} forEach _sectorsData;
		};
	};
	if (_sectorsTaking isNotEqualTo []) then {
		{
			_sectorPositions pushBack (_x # 7);
		} forEach _sectorsTaking;
		_sectorPosition = _sectorPositions # 0;
		if ((count _sectorPositions) > 1) then {
			private _dist = _position distance2D _sectorPosition;
			{
				if ((_position distance2D _x) < _dist) then {
					_dist = _position distance2D _x;
					_sectorPosition = _x;
				};
			} forEach _sectorPositions;
		};
	};
	_sectorPosition;
};
[]