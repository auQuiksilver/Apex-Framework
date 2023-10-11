/*/
File: fn_clientViewOptions.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	Client View Options
__________________________________________________________/*/

params ['_type','_mode','_value'];
private _setting = -1;
_QS_worldName = worldName;
if (_type isEqualTo 'onLoad') exitWith {
	uiSleep 0.01;
	_display = findDisplay 3000;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	if ((cameraOn isKindOf 'CAManBase') || {(isNull cameraOn)}) exitWith {
		['onButtonClick',0] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,1]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,0.333]]
		];
	};
	if ((cameraOn isKindOf 'LandVehicle') || {(cameraOn isKindOf 'Ship')}) exitWith {
		['onButtonClick',1] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,1]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,0.333]]
		];
	};
	if (cameraOn isKindOf 'Helicopter') exitWith {
		['onButtonClick',2] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,1]],
			[1820,[1,1,1,0.333]]
		];
	};
	if (cameraOn isKindOf 'Plane') exitWith {
		['onButtonClick',3] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,1]]
		];
	};
};
if (_type isEqualTo 'onButtonClick') exitWith {
	playSound 'ClickSoft';
	_display = findDisplay 3000;
	if (_mode isEqualTo 0) then {
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,1]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,0.333]]
		];
	};
	if (_mode isEqualTo 1) then {
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,1]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,0.333]]
		];
	};
	if (_mode isEqualTo 2) then {
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,1]],
			[1820,[1,1,1,0.333]]
		];
	};
	if (_mode isEqualTo 3) then {
		{
			(_display displayCtrl (_x # 0)) ctrlSetTextColor (_x # 1);
		} forEach [
			[1805,[1,1,1,0.333]],
			[1810,[1,1,1,0.333]],
			[1815,[1,1,1,0.333]],
			[1820,[1,1,1,1]]
		];
	};
	_QS_client_viewSettings = player getVariable [
		(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
		[
			[1000,2400,3200,6400],
			[800,1400,2400,3000],
			[50,50,50,50],
			[45,45,45,45],
			[TRUE,TRUE,FALSE,FALSE]
		]
	];
	player setVariable ['QS_RD_client_viewSettings_currentMode',_mode,FALSE];
	_QS_client_viewSettings_overall = (_QS_client_viewSettings # 0) # _mode;
	_QS_client_viewSettings_object = (_QS_client_viewSettings # 1) # _mode;
	_QS_client_viewSettings_shadow = (_QS_client_viewSettings # 2) # _mode;
	_QS_client_viewSettings_terrain = (_QS_client_viewSettings # 3) # _mode;
	ctrlSetText [1808,format['%1',_QS_client_viewSettings_overall]];
	ctrlSetText [1813,format['%1',_QS_client_viewSettings_object]];
	ctrlSetText [1818,format['%1',_QS_client_viewSettings_shadow]];
	ctrlSetText [1823,format['%1',_QS_client_viewSettings_terrain]];
	sliderSetRange [1807,100,12000];
	sliderSetRange [1812,100,6000];
	sliderSetRange [1817,0,200];
	sliderSetRange [1822,3.125,47.5];
	sliderSetSpeed [1807,100,100];
	sliderSetSpeed [1812,100,100];
	sliderSetSpeed [1817,5,5];
	sliderSetSpeed [1822,0.25,0.25];
	sliderSetPosition [1807,(_QS_client_viewSettings_overall - _QS_client_viewSettings_overall % 10)];
	sliderSetPosition [1812,(_QS_client_viewSettings_object - _QS_client_viewSettings_object % 10)];
	sliderSetPosition [1817,(_QS_client_viewSettings_shadow - _QS_client_viewSettings_shadow % 10)];
	sliderSetPosition [1822,_QS_client_viewSettings_terrain];
};
if (_type isEqualTo 'onSliderPosChange') exitWith {
	uiNamespace setVariable ['QS_RD_viewSettings_update',TRUE];
	private _cameraOn = cameraOn;
	_setting = player getVariable 'QS_RD_client_viewSettings_currentMode';
	if (_mode isEqualTo 0) then {
		/*/Overall VD/*/
		ctrlSetText [1808,format['%1',(round (_value - _value % 100))]];
		if (_setting isEqualTo 0) then {
			if (_cameraOn isKindOf 'CAManBase') then {
				setViewDistance (round (_value - _value % 100));
			};
			/*/ On foot/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					[
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 1) then {
			if ((_cameraOn isKindOf 'LandVehicle') || {(_cameraOn isKindOf 'Ship')}) then {
				setViewDistance (round (_value - _value % 100));
			};
			/*/ Vehicle/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 0),
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 2) then {
			/*/ Heli/*/
			if (_cameraOn isKindOf 'Helicopter') then {
				setViewDistance (round (_value - _value % 100));
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 1),
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 3) then {
			/*/ Plane/*/
			if (_cameraOn isKindOf 'Plane') then {
				setViewDistance (round (_value - _value % 100));
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0) # 2),
						(round (_value - _value % 100))
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
	};
	if (_mode isEqualTo 1) then {
		/*/Object VD/*/
		ctrlSetText [1813,format['%1',(round (_value - _value % 100))]];
		if (_setting isEqualTo 0) then {
			if (_cameraOn isKindOf 'CAManBase') then {
				setObjectViewDistance (round (_value - _value % 100));
			};
			/*/On foot/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					[
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 1) then {
			/*/ Vehicle/*/
			if ((_cameraOn isKindOf 'LandVehicle') || {(_cameraOn isKindOf 'Ship')}) then {
				setObjectViewDistance (round (_value - _value % 100));
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 0),
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 2) then {
			if (_cameraOn isKindOf 'Helicopter') then {
				setObjectViewDistance (round (_value - _value % 100));
			};
			/*/ Heli/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 1),
						(round (_value - _value % 100)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 3) then {
			if (_cameraOn isKindOf 'Plane') then {
				setObjectViewDistance (round (_value - _value % 100));
			};
			/*/ Plane/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1) # 2),
						(round (_value - _value % 100))
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
	};
	if (_mode isEqualTo 2) then {
		/*/ Shadow Dist/*/
		ctrlSetText [1818,format['%1',(round (_value - _value % 10))]];
		if (_setting isEqualTo 0) then {
			if (_cameraOn isKindOf 'CAManBase') then {
				setShadowDistance (round (_value - _value % 10));
			};
			/*/ On foot/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					[
						(round (_value - _value % 10)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 1) then {
			/*/ Vehicle/*/
			if ((_cameraOn isKindOf 'LandVehicle') || {(_cameraOn isKindOf 'Ship')}) then {
				setShadowDistance (round (_value - _value % 10));
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 0),
						(round (_value - _value % 10)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 2) then {
			/*/ Heli/*/
			if (_cameraOn isKindOf 'Helicopter') then {
				setShadowDistance (round (_value - _value % 10));
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 1),
						(round (_value - _value % 10)),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 3) then {
			if (_cameraOn isKindOf 'Plane') then {
				setShadowDistance (round (_value - _value % 10));
			};
			/*/ Plane/*/
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2) # 2),
						(round (_value - _value % 10))
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
	};
	if (_mode isEqualTo 3) then {
		/*/ Terrain Grid/*/
		ctrlSetText [1823,format['%1',round _value]];
		if (_setting isEqualTo 0) then {
			/*/ On foot/*/
			if (_cameraOn isKindOf 'CAManBase') then {
				setTerrainGrid _value;
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					[
						(round _value),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 1) then {
			/*/Vehicle/*/
			if ((_cameraOn isKindOf 'LandVehicle') || {(_cameraOn isKindOf 'Ship')}) then {
				setTerrainGrid _value;
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 0),
						(round _value),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 2),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 2) then {
			/*/ Heli/*/
			if (_cameraOn isKindOf 'Helicopter') then {
				setTerrainGrid _value;
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 1),
						(round _value),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 3)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
		if (_setting isEqualTo 3) then {
			/*/ Plane/*/
			if (_cameraOn isKindOf 'Plane') then {
				setTerrainGrid _value;
			};
			player setVariable [
				(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),
				[
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 0),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 1),
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 2),
					[
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 0),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 1),
						(((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 3) # 2),
						(round _value)
					],
					((player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName])) # 4)
				],
				FALSE
			];
		};
	};
};
if (_type isEqualTo 'Unload') exitWith {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_main';
	};
	missionProfileNamespace setVariable [(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),(player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName]))];
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
	missionProfileNamespace setVariable [(format ['QS_RD_client_viewSettings_%1',_QS_worldName]),(player getVariable (format ['QS_RD_client_viewSettings_%1',_QS_worldName]))];
	saveMissionProfileNamespace;
};