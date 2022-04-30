/*
File: fn_clientMenuRadio.sqf
Author:
	
	Quiksilver
	
Last Modified:

	29/06/2016 A3 1.62 by Quiksilver

Description:

	Client Menu Radio
__________________________________________________________*/
disableSerialization;
_type = _this select 0;
if (_type isEqualTo 'onLoad') then {
	_display = _this select 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	{
		(_x select 0) ctrlSetText (_x select 1);
	} forEach [
		[(_display displayCtrl 1802),'Radio Management'],
		[(_display displayCtrl 1804),'Close'],
		[(_display displayCtrl 1805),'Channels'],
		[(_display displayCtrl 1806),'Status'],
		[(_display displayCtrl 1807),'Subscribe']
	];
	/*/CHANNEL 6 - GENERAL - 1808, 1816, 1827/*/
	(_display displayCtrl 1808) ctrlSetText 'Side channel';
	(_display displayCtrl 1808) ctrlSetTooltip 'Side channel';
	(_display displayCtrl 1816) ctrlSetText (if (1 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1827) cbSetChecked (1 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1827) ctrlSetTooltip '';
	(_display displayCtrl 1827) ctrlEnable FALSE;
	/*/
	if (6 in (missionNamespace getVariable 'QS_radioChannels')) then {
		(_display displayCtrl 1827) ctrlEnable TRUE;
	};
	/*/
	/*/CHANNEL 7 - AIRCRAFT - 1809, 1817, 1828/*/
	(_display displayCtrl 1809) ctrlSetText 'Aircraft';
	(_display displayCtrl 1809) ctrlSetTooltip 'Pilots and UAV operator';
	(_display displayCtrl 1817) ctrlSetText (if (2 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active - Encrypted'},{'Inactive - Encrypted'}]);
	(_display displayCtrl 1828) cbSetChecked (2 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1828) ctrlSetTooltip '';
	(_display displayCtrl 1828) ctrlEnable FALSE;
	/*/CHANNEL 8 - AO - 1810, 1818, 1829, 1837/*/
	(_display displayCtrl 1810) ctrlSetText 'Primary AO';
	(_display displayCtrl 1810) ctrlSetTooltip 'Main AO channel';
	(_display displayCtrl 1818) ctrlSetText (if (3 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1829) cbSetChecked ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0); /*/(3 in (missionNamespace getVariable 'QS_client_radioChannels'));/*/
	(_display displayCtrl 1837) cbSetChecked ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0);
	(_display displayCtrl 1829) ctrlSetTooltip '';
	(_display displayCtrl 1837) ctrlSetTooltip '';
	(_display displayCtrl 1837) ctrlEnable FALSE;
	(_display displayCtrl 1837) ctrlShow FALSE;
	/*/CHANNEL 9 - SM - 1811, 1819, 1830, 1838/*/
	(_display displayCtrl 1811) ctrlSetText 'Secondary AO';
	(_display displayCtrl 1811) ctrlSetTooltip 'Side Mission channel';
	(_display displayCtrl 1819) ctrlSetText (if (4 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1830) cbSetChecked ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1); /*/(4 in (missionNamespace getVariable 'QS_client_radioChannels'));/*/
	(_display displayCtrl 1838) cbSetChecked ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1);
	(_display displayCtrl 1830) ctrlSetTooltip '';
	(_display displayCtrl 1838) ctrlSetTooltip '';
	(_display displayCtrl 1838) ctrlEnable FALSE;
	(_display displayCtrl 1838) ctrlShow FALSE;
	/*/CHANNEL 10 - PLT A - 1812, 1820, 1831/*/
	(_display displayCtrl 1812) ctrlSetText 'PLT Alpha "Jungleers"';
	(_display displayCtrl 1812) ctrlSetTooltip '1st Platoon';
	(_display displayCtrl 1820) ctrlSetText (if (5 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1831) cbSetChecked (5 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1831) ctrlSetTooltip '';
	/*/CHANNEL 11 - PLT B - 1813, 1821, 1832/*/
	(_display displayCtrl 1813) ctrlSetText 'PLT Bravo "Buckeyes"';
	(_display displayCtrl 1813) ctrlSetTooltip '2nd Platoon';
	(_display displayCtrl 1821) ctrlSetText (if (6 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1832) cbSetChecked (6 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1832) ctrlSetTooltip '';
	/*/CHANNEL 12 - PLT C - 1814, 1841, 1833/*/
	(_display displayCtrl 1814) ctrlSetText 'PLT Charlie "Fighting Third"';
	(_display displayCtrl 1814) ctrlSetTooltip '3rd Platoon';
	(_display displayCtrl 1841) ctrlSetText (if (7 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1833) cbSetChecked (7 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1833) ctrlSetTooltip '';
	/*/CHANNEL 13 - Off-Duty - 1815, 1822, 1834/*/
	(_display displayCtrl 1815) ctrlSetText 'General';
	(_display displayCtrl 1815) ctrlSetTooltip 'NSFW';
	(_display displayCtrl 1822) ctrlSetText (if (8 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1834) cbSetChecked (8 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1834) ctrlSetTooltip '';
	/*/CHANNEL 14 - Disabled - 1823, 1824, 1835/*/
	(_display displayCtrl 1823) ctrlSetText 'N/A';
	(_display displayCtrl 1823) ctrlSetTooltip 'Unused channel';
	(_display displayCtrl 1823) ctrlSetTextColor [0.5,0.5,0.5,0.5];
	(_display displayCtrl 1824) ctrlSetText (if (9 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1824) ctrlSetTextColor [0.5,0.5,0.5,0.5];
	(_display displayCtrl 1835) cbSetChecked (9 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1835) ctrlSetTooltip 'Unused channel';
	(_display displayCtrl 1823) ctrlEnable FALSE;
	(_display displayCtrl 1824) ctrlEnable FALSE;
	(_display displayCtrl 1835) ctrlEnable FALSE;
	/*/CHANNEL 15 - Disabled - 1825, 1826, 1836/*/
	(_display displayCtrl 1825) ctrlSetText 'N/A';
	(_display displayCtrl 1825) ctrlSetTooltip 'Unused channel';
	(_display displayCtrl 1825) ctrlSetTextColor [0.5,0.5,0.5,0.5];
	(_display displayCtrl 1826) ctrlSetText (if (10 in (missionNamespace getVariable 'QS_radioChannels')) then [{'Active'},{'Inactive'}]);
	(_display displayCtrl 1826) ctrlSetTextColor [0.5,0.5,0.5,0.5];
	(_display displayCtrl 1836) cbSetChecked (10 in (missionNamespace getVariable 'QS_client_radioChannels'));
	(_display displayCtrl 1836) ctrlSetTooltip 'Unused channel';
	(_display displayCtrl 1836) ctrlEnable FALSE;
	(_display displayCtrl 1825) ctrlEnable FALSE;
	(_display displayCtrl 1826) ctrlEnable FALSE;
};
if (_type isEqualTo 'onUnload') then {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};
if (_type isEqualTo 'Manage') then {

};
if (_type isEqualTo 'Close') then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
	};
};
if (_type in [
	'Check_1','Check_2','Check_3','Check_4','Check_5','Check_6',
	'Check_7','Check_8','Check_9','Check_10','Check_11','Check_12'
]) then {
	_ctrl = _this select 1;
	_state = _this select 2;
	_display = ctrlParent _ctrl;
	/*/6 - SIDE/*/
	if (_type isEqualTo 'Check_1') then {
		if (_state isEqualTo 1) then {
			if (1 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(1 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,1] call (missionNamespace getVariable 'QS_fnc_clientRadio');
				};
			};
		} else {
			if (1 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (1 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,1] call (missionNamespace getVariable 'QS_fnc_clientRadio');
				};
			};
		};
	};
	/*/7 - AIRCRAFT/*/
	if (_type isEqualTo 'Check_2') then {
		if (_state isEqualTo 1) then {
			if (2 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
				};
			};		
		} else {
			if (2 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (2 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
				};
			};		
		};	
	};
	/*/8 - AO/*/
	if (_type isEqualTo 'Check_3') then {
		if (_state isEqualTo 1) then {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					TRUE,
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1)
				],
				FALSE
			];
			profileNamespace setVariable [
				'QS_client_radioChannels_profile',
				[
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
					TRUE,
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
				]
			];
			saveProfileNamespace;
		} else {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					FALSE,
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1)
				],
				FALSE
			];
			profileNamespace setVariable [
				'QS_client_radioChannels_profile',
				[
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
					FALSE,
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
				]
			];
			saveProfileNamespace;
		};
	};
	/*/9 - SM/*/
	if (_type isEqualTo 'Check_4') then {
		if (_state isEqualTo 1) then {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0),
					TRUE
				],
				FALSE
			];
			profileNamespace setVariable [
				'QS_client_radioChannels_profile',
				[
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
					TRUE,
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
				]
			];
			saveProfileNamespace;
		} else {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0),
					FALSE
				],
				FALSE
			];
			profileNamespace setVariable [
				'QS_client_radioChannels_profile',
				[
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
					FALSE,
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
					((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
				]
			];
			saveProfileNamespace;
		};
	};
	/*/10 - PLATOON A/*/
	if (_type isEqualTo 'Check_5') then {
		if (_state isEqualTo 1) then {
			if (5 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(5 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,5] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,6] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,7] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					(_display displayCtrl 1832) cbSetChecked (6 in (missionNamespace getVariable 'QS_client_radioChannels'));
					(_display displayCtrl 1833) cbSetChecked (7 in (missionNamespace getVariable 'QS_client_radioChannels'));		
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							TRUE,
							FALSE,
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};
		} else {
			if (5 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (5 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,5] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		};	
	};
	/*/11 - PLATOON B/*/
	if (_type isEqualTo 'Check_6') then {
		if (_state isEqualTo 1) then {
			if (6 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(6 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,6] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,5] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,7] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					(_display displayCtrl 1831) cbSetChecked (5 in (missionNamespace getVariable 'QS_client_radioChannels'));
					(_display displayCtrl 1833) cbSetChecked (7 in (missionNamespace getVariable 'QS_client_radioChannels'));
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							FALSE,
							TRUE,
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		} else {
			if (6 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (6 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,6] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		};	
	};
	/*/12 - PLATOON C/*/
	if (_type isEqualTo 'Check_7') then {
		if (_state isEqualTo 1) then {
			if (7 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(7 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,7] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,5] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					[0,6] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					(_display displayCtrl 1831) cbSetChecked (5 in (missionNamespace getVariable 'QS_client_radioChannels'));
					(_display displayCtrl 1832) cbSetChecked (6 in (missionNamespace getVariable 'QS_client_radioChannels'));
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							FALSE,
							FALSE,
							TRUE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		} else {
			if (7 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (7 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,7] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		};	
	};
	/*/13 - GENERAL/*/
	if (_type isEqualTo 'Check_8') then {
		if (_state isEqualTo 1) then {
			if (8 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(8 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,8] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							TRUE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};			
		} else {
			if (8 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (8 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,8] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		};
	};
	/*/14 - UNUSED/*/
	if (_type isEqualTo 'Check_9') then {
		if (_state isEqualTo 1) then {
			if (9 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(9 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,9] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							TRUE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		} else {
			if (9 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (9 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,9] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							FALSE,
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 9)
						]
					];
					saveProfileNamespace;
				};
			};		
		};	
	};
	/*/15 - UNUSED/*/
	if (_type isEqualTo 'Check_10') then {
		if (_state isEqualTo 1) then {
			if (10 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (!(10 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
					[1,10] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							TRUE
						]
					];
					saveProfileNamespace;
				};
			};		
		} else {
			if (10 in (missionNamespace getVariable 'QS_radioChannels')) then {
				if (10 in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,10] call (missionNamespace getVariable 'QS_fnc_clientRadio');
					profileNamespace setVariable [
						'QS_client_radioChannels_profile',
						[
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 0),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 1),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 2),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 3),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 4),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 5),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 6),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 7),
							((profileNamespace getVariable 'QS_client_radioChannels_profile') select 8),
							FALSE
						]
					];
					saveProfileNamespace;
				};
			};		
		};	
	};
	/*/AO DYNAMIC/*/
	if (_type isEqualTo 'Check_11') then {
		if (_state isEqualTo 1) then {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					TRUE,
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1)
				],
				FALSE
			];
		} else {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					FALSE,
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1)
				],
				FALSE
			];		
		};
	};
	/*/SM DYNAMIC/*/
	if (_type isEqualTo 'Check_12') then {
		if (_state isEqualTo 1) then {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0),
					TRUE
				],
				FALSE
			];
		} else {
			missionNamespace setVariable [
				'QS_client_radioChannels_dynamic',
				[
					((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0),
					FALSE
				],
				FALSE
			];		
		};	
	};
};