/*/
File: fn_smDebrief2.sqf
Author:

	Quiksilver
	
Last modified: 

	15/05/2023 A3 2.12 by Quiksilver

Description:

	Operant conditioning ( https://www.youtube.com/watch?v=I_ctJqjlrHA&t=130s )
	
	
	[1,[0,0,0],33] call QS_fnc_smDebrief
______________________________________________________________________/*/

params [['_type',1],['_smPos',[0,0,0]],['_reward',-1]];
missionNamespace setVariable ['QS_evacPosition_2',_smPos,TRUE];
['QS_IA_TASK_SM_0'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
if (_type isEqualTo 0) exitWith {
	['playMusic','EventTrack02_F_Curator'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	_failedText = parseText "<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#b60000'>FAILED</t><br/>____________________<br/>
		You'll have to do better than that next time!<br/><br/><br/>Focus on the main objective for now; we'll relay the bad news to HQ, with some luck we'll have another objective lined up. 
		We'll get back to you in 15 - 30 minutes.</t>";
	['hint',_failedText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
};
if (_type isEqualTo 1) then {
	['playMusic','EventTrack03_F_Curator'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	['CompletedSideMission',[(markerText 'QS_marker_sideMarker')]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	private ['_rewardText','_rewardVeh','_landRewardLocations','_shipRewardLocations','_rewardType','_rewardPosition','_newRewardArray'];
	if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
		private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
		_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
		_scoreEast = _QS_virtualSectors_scoreSides # 0;
		if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
			_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_sideTask',0.1]);
			_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
			missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
		};
	};
	if (!(worldName in ['Altis','Stratis','Tanoa','Malden','Enoch'])) exitWith {};		// Not set up for DLC/mods yet
	private _isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',FALSE];
	if ((random 1) < 0.25) exitWith {
		['Reward',[localize 'STR_QS_Notif_076']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};
	_rewardVeh = objNull;
	if ((count (missionNamespace getVariable 'QS_smReward_array')) > 2) then {
		if (_isArmedAirEnabled) then {
			_newRewardArray = missionNamespace getVariable ['QS_smReward_array',[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]];
		} else {
			_newRewardArray = missionNamespace getVariable ['QS_smReward_array',[5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,23,28,29,30,31,32,33]];
		};
	} else {
		if (_isArmedAirEnabled) then {
			_newRewardArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33];
		} else {
			_newRewardArray = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,23,28,29,30,31,32,33];
		};
	};
	if (_reward isEqualTo -1) then {
		_reward = selectRandom _newRewardArray;
	};
	_rewardText = '';
	_landRewardLocations = [];
	_shipRewardLocations = [];
	if (worldName isEqualTo 'Altis') then {
		_landRewardLocations = [
			[14774.6,16711.8,0],
			[14801.8,16733.7,0],[14788.4,16720.7,0],[14856.5,16699.2,0],[14850,16692.5,0],[14843.7,16685.5,0],
			[14833.3,16677.8,0],[14875.7,16665,0],[14868.5,16656.5,0],[14860.2,16647.4,0],[14850.8,16640,0],
			[14841.5,16632.9,0],[14834.7,16624.4,0],[14827.2,16617.4,0],[14819.6,16609.6,0],[14812.4,16601.1,0],
			[14803.7,16593.6,0],[14797.3,16585.2,0],[14789.2,16578.8,0],[14783.2,16570.2,0],[14775.6,16563.1,0],
			[14768.2,16555.3,0],[14767.1,16607.7,0],[14760,16598.1,0],[14748.9,16588.7,0],[14742.2,16579.5,0]	
		];
		_shipRewardLocations = [];
		_rewardPosition = selectRandom _landRewardLocations;
	};
	if (worldName isEqualTo 'Tanoa') then {
		_landRewardLocations = [
			[7091.07,7453.14,0.00143886],[7094.66,7437.83,0.00143886],[7100.06,7418.66,0.00143886],[7104.88,7400.82,0.00143886],
			[7108.83,7382.83,0.00143886],[7113.66,7360.61,0.00143886],[7106.89,7345.06,0.00143886],[7092.27,7357.36,0.00143886],
			[7072.73,7426.81,0.00143886],[7064.93,7443.03,0.00143886],[7056.86,7461.56,0.00143886]
		];
		_shipRewardLocations = [
			[6600.64,6881.3,1.83849],
			[6578.21,6893.31,1.03625],
			[6563.31,6907.3,0.606301]
		];
		_rewardPosition = selectRandom _landRewardLocations;
	};
	if (_landRewardLocations isEqualTo []) then {
		for '_x' from 0 to 19 step 1 do {
			_landRewardLocations pushBack (markerPos 'QS_marker_side_rewards');
		};
		_rewardPosition = markerPos 'QS_marker_side_rewards';
	};
	if (_shipRewardLocations isEqualTo []) then {
		for '_x' from 0 to 19 step 1 do {
			_shipRewardLocations pushBack (markerPos 'QS_marker_side_rewards');
		};
		_rewardPosition = markerPos 'QS_marker_side_rewards';
	};
	if (_reward isEqualTo 0) then {
		//comment 'AH 9 Pawnee with flares';
		_rewardType = 'B_Heli_Light_01_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh addWeaponTurret ['CMFlareLauncher', [-1]];
		_rewardVeh addMagazineTurret ['60Rnd_CMFlare_Chaff_Magazine', [-1]];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'an AH-9 Pawnee (+ flares)';
		_rewardVeh setVariable ['QS_ST_customDN','AH-9+',TRUE];
	};
	if (_reward isEqualTo 1) then {
		//comment 'AH 99 Blackfoot';
		_rewardType = 'B_Heli_Attack_01_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'an AH-99 Blackfoot';
	};
	if (_reward isEqualTo 2) then {
		//comment 'Mi 48 Kajman';
		_rewardType = 'O_Heli_Attack_02_black_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'an Mi-48 Kajman';
	};
	if (_reward isEqualTo 3) then {
		//comment 'PO 30 Orca - random type';
		_rewardType = selectRandom ['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F'];
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a PO-30 Orca';
	};
	if (_reward isEqualTo 4) then {
		//comment 'WY-55 Hellcat';
		_rewardType = ['i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f'] select (worldName in ['Tanoa','Enoch']);
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a WY-55 Hellcat';
	};
	if (_reward isEqualTo 5) then {
		//comment 'MH 9 with flares';
		_rewardType = 'B_Heli_Light_01_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh addWeaponTurret ['CMFlareLauncher',[-1]];
		_rewardVeh addMagazineTurret ['60Rnd_CMFlare_Chaff_Magazine',[-1]];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'an MH-9 (+ flares)';
		_rewardVeh setVariable ['QS_ST_customDN','MH-9+',TRUE];
	};
	if (_reward isEqualTo 6) then {
		//comment 'Ifrit GMG';
		_rewardType = 'O_MRAP_02_gmg_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'an Ifrit GMG';
	};
	if (_reward isEqualTo 7) then {
		//comment 'Strider GMG';
		_rewardType = 'I_MRAP_03_gmg_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) Strider GMG';
	};
	if (_reward isEqualTo 8) then {
		//comment 'MBT-52 Kuma';
		_rewardType = 'I_MBT_03_cannon_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) MBT-52 Kuma';
	};
	if (_reward isEqualTo 9) then {
		//comment 'BTR-K Kamysh';
		if (worldName in ['Tanoa','Enoch']) then {
			_rewardType = 'O_T_APC_Tracked_02_cannon_ghex_F';
		} else {
			_rewardType = 'O_APC_Tracked_02_cannon_F';
		};
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) BTR-K Kamysh';
	};
	if (_reward isEqualTo 10) then {
		//comment 'AFV-4 Gorgon';
		_rewardType = 'I_APC_Wheeled_03_cannon_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) AFV-4 Gorgon';
	};
	if (_reward isEqualTo 11) then {
		//comment 'MSE-3 Marid';
		if (worldName in ['Tanoa','Enoch']) then {
			_rewardType = 'O_T_APC_Wheeled_02_rcws_v2_ghex_F';
		} else {
			_rewardType = 'O_APC_Wheeled_02_rcws_v2_F';
		};
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) MSE-3 Marid';
	};
	if (_reward isEqualTo 12) then {
		//comment 'IFV-6a Cheetah';
		_rewardType = 'B_APC_Tracked_01_AA_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _rewardType,_rewardType],_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) IFV-6a Cheetah';
	};
	if (_reward isEqualTo 13) then {
		//comment 'Truck with mortar and stronger wheels';
		_rewardType = 'B_G_Van_01_transport_F';
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_mortar = createVehicle ['B_G_Mortar_01_F',[0,0,0],[],0,'NONE'];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_cleanup_protected',TRUE,TRUE];
		[1,_mortar,[_rewardVeh,[0,-2.5,0.1]]] call QS_fnc_eventAttach;
		_mortar setVariable ['QS_attached',TRUE,TRUE];
		_mortar allowDamage FALSE;
		_mortar setVariable ['QS_ST_customDN','',TRUE];
		_mortar addEventHandler [
			'GetOut',
			{
				params ['_vehicle','','_unit',''];
				if (!isNull (attachedTo _vehicle)) then {
					if (alive (attachedTo _vehicle)) then {
						if (((attachedTo _vehicle) emptyPositions 'cargo') > 0) then {
							if (local _unit) then {
								_unit moveInCargo (attachedTo _vehicle);
							} else {
								[[_unit,(attachedTo _vehicle)],{(_this # 0) moveInCargo (_this # 1);}] remoteExec ['call',_unit,FALSE];
							};
						} else {
							_unit setPosASL ((attachedTo _vehicle) modelToWorldWorld ((attachedTo _vehicle) selectionPosition 'pos cargo'));
						};
					};
				};
			}
		];
		_rewardVeh setVariable ['QS_attachedObjects',[_mortar],FALSE];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		_rewardVeh setVariable ['QS_ST_customDN','Mortar Truck',TRUE];
		_rewardText = 'a(n) Mortar Truck';
	};
	if (_reward isEqualTo 14) then {
		//comment 'HEMTT with Static weapons and increased armor';
		_rewardType = ['B_Truck_01_transport_F','B_T_Truck_01_transport_F'] select (worldName in ['Tanoa','Enoch']);
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_static1 = createVehicle ['B_GMG_01_A_F',[0,0,0],[],0,'NONE'];
		[1,_static1,[_rewardVeh,[0.5,3.75,1.6]]] call QS_fnc_eventAttach;
		_static1 setVariable ['QS_attached',TRUE,TRUE];
		_static1 enableWeaponDisassembly FALSE;
		_static1 setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static1 setVariable ['QS_uav_protected',TRUE,FALSE];
		_static1 setVariable ['QS_ST_customDN','',TRUE];
		_static1 allowDamage FALSE;
		createVehicleCrew _static1;
		_static1 setVariable ['QS_hidden',TRUE,TRUE];
		{
			_x setVariable ['QS_hidden',TRUE,TRUE];
		} forEach (crew _static1);
		_static2 = createVehicle ['B_G_HMG_02_high_F',[0,0,0],[],0,'NONE'];
		[1,_static2,[_rewardVeh,[0.2,-0.9,1.125]]] call QS_fnc_eventAttach;
		_static2 setVariable ['QS_attached',TRUE,TRUE];
		_static2 enableWeaponDisassembly FALSE;
		_static2 setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static2 allowDamage FALSE;
		_static2 disableTIEquipment TRUE;
		_static2 setVariable ['QS_ST_customDN','',TRUE];
		_static2 addEventHandler [
			'GetOut',
			{
				params ['_vehicle','','_unit',''];
				if (!isNull (attachedTo _vehicle)) then {
					if (alive (attachedTo _vehicle)) then {
						if (((attachedTo _vehicle) emptyPositions 'cargo') > 0) then {
							if (local _unit) then {
								_unit moveInCargo (attachedTo _vehicle);
							} else {
								[[_unit,(attachedTo _vehicle)],{(_this # 0) moveInCargo (_this # 1);}] remoteExec ['call',_unit,FALSE];
							};
						} else {
							_unit setPosASL ((attachedTo _vehicle) modelToWorldWorld ((attachedTo _vehicle) selectionPosition 'pos cargo'));
						};
					};
				};
			}
		];
		_static3 = createVehicle ['B_G_HMG_02_high_F',[0,0,0],[],0,'NONE'];
		[1,_static3,[_rewardVeh,[0.2,-4,1.125]]] call QS_fnc_eventAttach;
		_static3 setVariable ['QS_attached',TRUE,TRUE];
		_static3 enableWeaponDisassembly FALSE;
		_static3 setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static3 allowDamage FALSE;
		_static3 disableTIEquipment TRUE;
		_static3 setVariable ['QS_ST_customDN','',TRUE];
		_static3 addEventHandler [
			'GetOut',
			{
				params ['_vehicle','','_unit',''];
				if (!isNull (attachedTo _vehicle)) then {
					if (alive (attachedTo _vehicle)) then {
						if (((attachedTo _vehicle) emptyPositions 'cargo') > 0) then {
							if (local _unit) then {
								_unit moveInCargo (attachedTo _vehicle);
							} else {
								[[_unit,(attachedTo _vehicle)],{(_this # 0) moveInCargo (_this # 1);}] remoteExec ['call',_unit,FALSE];
							};
						} else {
							_unit setPosASL ((attachedTo _vehicle) modelToWorldWorld ((attachedTo _vehicle) selectionPosition 'pos cargo'));
						};
					};
				};
			}
		];
		_rewardVeh removeWeaponTurret ['TruckHorn2',[-1]];
		_rewardVeh addWeaponTurret ['TruckHorn3',[-1]];
		missionNamespace setVariable ['QS_bushPig',_rewardVeh,TRUE];
		_rewardVeh setVariable ['QS_attachedObjects',[_static1,_static2,_static3],FALSE];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		private ['_obj','_bagFenceRoundType','_bagFenceLongType'];
		if (worldName in ['Tanoa','Enoch']) then {
			_bagFenceRoundType = 'Land_BagFence_01_round_green_F';
			_bagFenceLongType = 'Land_BagFence_01_long_green_F';		
		} else {
			_bagFenceRoundType = 'Land_BagFence_Round_F';
			_bagFenceLongType = 'Land_BagFence_Long_F';		
		};
		_position = getPosASL _rewardVeh;
		{
			private _model = getText (configFile >> 'CfgVehicles' >> (_x # 0) >> 'model');
			if ((_model select [0,1]) isEqualTo '\') then {
				_model = _model select [1];
			};
			if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
				_model = _model + '.p3d';
			};
			_obj = createSimpleObject [_model,_position];
			[1,_obj,[_rewardVeh,(_x # 1)]] call QS_fnc_eventAttach;
			_obj setVariable ['QS_attached',TRUE,TRUE];
			_obj setDir (_x # 2);
			_rewardVeh setVariable [
				'QS_attachedObjects',
				((_rewardVeh getVariable 'QS_attachedObjects') + [_obj]),
				FALSE
			];
		} forEach [
			[_bagFenceRoundType,[0,5.2,-0.75],180],
			[_bagFenceLongType,[1.4,-0.5,0],90],
			[_bagFenceLongType,[-1.4,-0.5,0],90],
			[_bagFenceLongType,[1.4,-3.5,0],90],
			[_bagFenceLongType,[-1.4,-3.5,0],90],
			['Land_Pallet_vertical_F',[1.35,1.75,-1],90],
			['Land_Pallet_vertical_F',[1.35,3.31,-1],90],
			['Land_Pallet_vertical_F',[1.35,-3.65,-1],90],
			['Land_Pallet_vertical_F',[1.35,-2.1,-1],90],
			['Land_Pallet_vertical_F',[-1.3,-2.1,-1],270],
			['Land_Pallet_vertical_F',[-1.3,-3.65,-1],270],
			['Land_Pallet_vertical_F',[-1.3,1.75,-1],270],
			['Land_Pallet_vertical_F',[-1.3,3.31,-1],270]
		];
		_rewardVeh setMass ((getMass _rewardVeh) * 1.25);
		_rewardText = 'a(n) HEMTT Bush Pig';
		_rewardVeh setVariable ['QS_ST_customDN','HEMTT (Bush Pig)',TRUE];
	};
	if (_reward isEqualTo 15) then {
		//comment 'Boat with mortar';
		if (worldName in ['Tanoa','Enoch']) then {
			_rewardType = 'B_T_Boat_Transport_01_F';
		} else {
			_rewardType = 'B_Boat_Transport_01_F';
		};
		_rewardPosition = selectRandom _shipRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh enableRopeAttach TRUE;
		_rewardVeh enableVehicleCargo TRUE;
		_mortar = createVehicle ['B_Mortar_01_F',[0,0,0],[],0,'NONE'];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_cleanup_protected',TRUE,TRUE];
		[1,_mortar,[_rewardVeh,[0,0,-0.3]]] call QS_fnc_eventAttach;
		_mortar setVariable ['QS_attached',TRUE,TRUE];
		_mortar allowDamage FALSE;
		_mortar setVariable ['QS_ST_customDN','',TRUE];
		_mortar addEventHandler [
			'GetOut',
			{
				params ['_vehicle','','_unit',''];
				if (!isNull (attachedTo _vehicle)) then {
					if (alive (attachedTo _vehicle)) then {
						if (((attachedTo _vehicle) emptyPositions 'cargo') > 0) then {
							if (local _unit) then {
								_unit moveInCargo (attachedTo _vehicle);
							} else {
								[[_unit,(attachedTo _vehicle)],{(_this # 0) moveInCargo (_this # 1);}] remoteExec ['call',_unit,FALSE];
							};
						} else {
							_unit setPosASL ((attachedTo _vehicle) modelToWorldWorld ((attachedTo _vehicle) selectionPosition 'pos cargo'));
						};
					};
				};
			}
		];
		_rewardVeh setVariable ['QS_attachedObjects',[_mortar],FALSE];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		_rewardVeh setVariable ['QS_ST_customDN','Mortar Boat',TRUE];
		_rewardText = 'a(n) Mortar Boat';
	};
	if (_reward isEqualTo 16) then {
		//comment 'Quadbikes (pair) with autoturret and stronger wheels';
		for '_x' from 0 to 1 step 1 do {
			if (worldName in ['Tanoa','Enoch']) then {
				_rewardType = 'B_T_Quadbike_01_F';
			} else {
				_rewardType = 'B_G_Quadbike_01_F';
			};
			private _rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
			[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
			_rewardVeh setDir (random 360);
			_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
			_rewardVeh lockCargo TRUE;
			private _static1 = createVehicle ['B_G_HMG_02_high_F',[0,0,0],[],0,'NONE'];
			[1,_static1,[_rewardVeh,[0.17,-0.4,1.1]]] call QS_fnc_eventAttach;
			_static1 setVariable ['QS_attached',TRUE,TRUE];
			_static1 setVariable ['QS_cleanup_protected',TRUE,TRUE];
			_static1 enableWeaponDisassembly FALSE;
			_static1 disableTIEquipment TRUE; 
			_static1 allowDamage FALSE;
			_rewardVeh setVariable ['QS_attachedObjects',[_static1],FALSE];
			_rewardVeh addEventHandler [
				'Deleted',
				{
					params ['_vehicle'];
					{
						[0,_x] call QS_fnc_eventAttach;
						deleteVehicle _x;
					} count (attachedObjects _vehicle);
				}
			];
			_rewardVeh addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
				}
			];
			_rewardVeh setVariable ['QS_ST_customDN','Recon Quad',TRUE];
		};
		_rewardText = 'Recon Quad Bikes (x2)';
	};
	if (_reward isEqualTo 17) then {
		//comment 'SUV with autoturret and stronger wheels and paint job and lower center of gravity';
		_rewardType = 'C_SUV_01_F';
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_centerOfMass = getCenterOfMass _rewardVeh;
		_centerOfMass set [2,-0.658];
		_rewardVeh setCenterOfMass _centerOfMass;
		_rewardVeh setVariable ['QS_vehicle_missilewarning',TRUE,TRUE];
		_rewardVeh setObjectTextureGlobal [0,'a3\soft_f_gamma\suv_01\data\suv_01_ext_02_co.paa'];
		_static = createVehicle ['B_Static_Designator_01_F',[0,0,0],[],0,'NONE'];
		_static setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static setVariable ['QS_uav_protected',TRUE,FALSE];
		_static enableWeaponDisassembly FALSE;
		[1,_static,[_rewardVeh,[-0.45,-2.5,0.5]]] call QS_fnc_eventAttach;
		_static setVariable ['QS_attached',TRUE,TRUE];
		_static allowDamage FALSE;
		createVehicleCrew _static;
		_static setVariable ['QS_hidden',TRUE,TRUE];
		{
			_x setVariable ['QS_hidden',TRUE,TRUE];
		} forEach (crew _static);
		_static1 = createVehicle ['B_HMG_01_A_F',[0,0,0],[],0,'NONE'];
		[1,_static1,[_rewardVeh,[0.1,-0.8,1.45]]] call QS_fnc_eventAttach;
		_static1 setVariable ['QS_attached',TRUE,TRUE];
		_static1 setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static1 setVariable ['QS_uav_protected',TRUE,FALSE];
		_static1 enableWeaponDisassembly FALSE;
		_static1 allowDamage FALSE;
		createVehicleCrew _static1;
		_static1 setVariable ['QS_hidden',TRUE,TRUE];
		{
			_x setVariable ['QS_hidden',TRUE,TRUE];
		} forEach (crew _static1);
		{_x setSkill 1;} forEach (crew _static1);
		_rewardVeh setVariable ['QS_attachedObjects',[_static,_static1],FALSE];
		_rewardText = 'a(n) Recon Utility Vehicle (Armed)';
		_rewardVeh setVariable ['QS_ST_customDN','Recon Utility Vehicle',TRUE];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
	};
	if (_reward isEqualTo 18) then {
		//comment 'Qilin (Armed)';
		_rewardVeh = createVehicle ['O_T_LSV_02_armed_black_F',_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardText = 'a(n) Qilin (Armed)';
	};	
	if (_reward isEqualTo 19) then {
		//comment 'O_T_VTOL_02_infantry_grey_F';
		_rewardType = 'O_T_VTOL_02_infantry_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		{
			_rewardVeh setObjectTextureGlobal _x;
		} forEach [
			[0,"\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT01_CO.paa"],
			[1,"\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT02_CO.paa"],
			[2,"\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_L_CO.paa"],
			[3,"\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_R_CO.paa"]
		];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = "a(n) Y-32 Xi'an (Infantry Transport)";
	};
	if (_reward isEqualTo 20) then {
		//comment 'Armed VTOL NATO';
		_rewardType = 'B_T_VTOL_01_armed_blue_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) V-44 X Blackfish (Armed)';
	};
	if (_reward isEqualTo 21) then {
		//comment 'Armed jeep';
		_rewardType = 'I_C_Offroad_02_unarmed_olive_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh animateSource ['hideSeatsRear',1];
		_rewardVeh animateSource ['hideRearDoor',1];
		_rewardVeh lockCargo [1,TRUE];
		_rewardVeh lockCargo [2,TRUE];
		_static1 = createVehicle [(selectRandom ['B_static_AA_F','B_static_AT_F','B_static_AT_F']),[(random 10),(random 10),(random 10)],[],0,'NONE'];
		[1,_static1,[_rewardVeh,[0,-0.7,0.175]]] call QS_fnc_eventAttach;
		_static1 setVariable ['QS_attached',TRUE,TRUE];
		_static1 setDir 180;
		_static1 allowDamage FALSE;
		_static1 enableWeaponDisassembly FALSE;
		_static1 setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh setVariable ['QS_attachedObjects',[_static1],FALSE];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		_rewardText = 'a(n) MB 4WD Stalker';
		_rewardVeh setVariable ['QS_ST_customDN','MB 4WD Stalker',TRUE];
	};	
	if (_reward isEqualTo 22) then {
		//comment "'c_plane_civil_01_racing_f','i_c_plane_civil_01_f'";
		_rewardType = selectRandom ['i_c_plane_civil_01_f','i_c_plane_civil_01_f'];
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_Q51');
		_rewardText = 'a(n) Q-51 Mosquito';
		_rewardVeh setVariable ['QS_ST_customDN','Q-51 Mosquito',TRUE];
	};
	if (_reward isEqualTo 23) then {
		//comment 'AA truck';
		_rewardType = selectRandomWeighted [
			'B_SAM_System_01_F',0.666,
			'B_AAA_System_01_F',0.333
		];
		_rewardText = 'HEMTT (AA)';
		if ((toLowerANSI _rewardType) isEqualTo 'b_sam_system_01_f') then {
			_rewardText = 'HEMTT (Mk49 Spartan)';
		} else {
			if ((toLowerANSI _rewardType) isEqualTo 'b_aaa_system_01_f') then {
				_rewardText = 'HEMTT (Praetorian 1C)';
			};
		};
		_rewardVeh = createVehicle [(['B_Truck_01_mover_F','B_T_Truck_01_mover_F'] select (worldName in ['Tanoa','Enoch'])),_rewardPosition,[],0,'NONE'];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh setVariable ['QS_RD_vehicleRespawnable',FALSE,TRUE];
		private _attachPoint = [0,0,0];
		if ((toLowerANSI _rewardType) isEqualTo 'b_sam_system_01_f') then {
			_attachPoint = [0,-3.2,1.4];
			_rewardVeh setVariable ['QS_ST_customDN','HEMTT (Spartan)',TRUE];
		};
		if ((toLowerANSI _rewardType) isEqualTo 'b_aaa_system_01_f') then {
			_attachPoint = [0,-2.9,2.15];
			_rewardVeh setVariable ['QS_ST_customDN','HEMTT (Praetorian)',TRUE];
		};
		_static = createVehicle [_rewardType,[(random -100),(random -100),(random 100)],[],0,'NONE'];
		_static setVariable ['QS_ST_customDN','',TRUE];
		_static setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_static setVariable ['QS_uav_protected',TRUE,FALSE];
		{ 
			_static setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray ((configOf _rewardVeh) >> 'TextureSources' >> (['Sand','Green'] select (worldName in ['Tanoa','Enoch'])) >> 'textures'));
		_rewardVeh enableRopeAttach FALSE;
		_rewardVeh enableVehicleCargo FALSE;
		[1,_static,[_rewardVeh,_attachPoint]] call QS_fnc_eventAttach;
		_static setVariable ['QS_attached',TRUE,TRUE];
		_rewardVeh addMPEventHandler [
			'MPKilled',
			{
				params ['_killed','','',''];
				if (local _killed) then {
					if ((attachedObjects _killed) isNotEqualTo []) then {
						{
							if (unitIsUav _x) then {
								_x setDamage [1,TRUE];
								[0,_x] call QS_fnc_eventAttach;
								deleteVehicle _x;
							};
						} forEach (attachedObjects _killed);
					};
				};
			}
		];
		_static addMPEventHandler [
			'MPKilled',
			{
				params ['_killed','','',''];
				if (local _killed) then {
					if (!isNull (attachedTo _killed)) then {
						(attachedTo _killed) setDamage [1,TRUE];
					};
				};
			}
		];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				if ((attachedObjects _vehicle) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						deleteVehicle _x;
					} forEach (attachedObjects _vehicle);
				};
				if (!isNull (attachedTo _vehicle)) then {
					(attachedTo _vehicle) setDamage [1,TRUE];
				};
			}
		];
		createVehicleCrew _static;
		_static setVariable ['QS_hidden',TRUE,TRUE];
		{
			_x setVariable ['QS_hidden',TRUE,TRUE];
		} forEach (crew _static);
		{
			_x setSkill 0.333;
		} forEach (crew _static);
	};
	if (_reward isEqualTo 24) then {
		//comment 'AH-9 Pawnee X';
		_rewardType = 'B_Heli_Light_01_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) AH-9 Pawnee X';
		[_rewardVeh,2,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_rewardVeh setVariable ['QS_ST_customDN','AH-9 Pawnee X',TRUE];
	};
	if (_reward isEqualTo 25) then {
		//comment 'WY-55 Hellcat X';
		_rewardType = 'I_Heli_light_03_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) WY-55 Hellcat X';
		[_rewardVeh,2,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_rewardVeh setVariable ['QS_ST_customDN','WY-55 Hellcat X',TRUE];
	};
	if (_reward isEqualTo 26) then {
		//comment 'PO-30 Orca X';
		_rewardType = 'O_Heli_Light_02_dynamicLoadout_F';
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = 'a(n) PO-30 Orca X';
		[_rewardVeh,2,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_rewardVeh setVariable ['QS_ST_customDN','PO-30 Orca X',TRUE];
	};
	if (_reward isEqualTo 27) then {
		//comment 'Attack Helis';
		_rewardData = selectRandom [
			['O_Heli_Attack_02_dynamicLoadout_black_F','a(n) Mi-48 Kajman X'],
			['B_Heli_Attack_01_dynamicLoadout_F','a(n) AH-99 Blackfoot X']
		];
		_rewardType = _rewardData # 0;
		_rewardPosition = selectRandom _landRewardLocations;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardText = _rewardData # 1;
		[_rewardVeh,2,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_rewardVeh setVariable ['QS_ST_customDN',(format ['%1 X',(getText ((configOf _rewardVeh) >> 'displayName'))]),TRUE];
	};
	
	if (_reward isEqualTo 28) then {
		//comment 'Shitty technical';
		_rewardType = 'B_G_Van_01_transport_F';
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardVeh setDir (random 360);
		_mortar = createVehicle ['B_GMG_01_high_F',[0,0,0],[],0,'NONE'];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_cleanup_protected',TRUE,TRUE];
		[1,_mortar,[_rewardVeh,[-0.15,-1.5,1]]] call QS_fnc_eventAttach;
		_mortar setVariable ['QS_attached',TRUE,TRUE];
		_mortar allowDamage FALSE;
		_mortar setDir 180;
		_rewardVeh setVariable ['QS_attachedObjects',[_mortar],FALSE];
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		_rewardVeh addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				{
					[0,_x] call QS_fnc_eventAttach;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			}
		];
		_rewardVeh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
			}
		];
		_rewardVeh setVariable ['QS_ST_customDN','Shitty Technical (GMG)',TRUE];
		_rewardText = 'a(n) Shitty Technical';
	};
	if (_reward isEqualTo 29) then {
		//comment 'Nyx';
		_rewardType = selectRandomWeighted [
			'I_LT_01_AT_F',1,
			'I_LT_01_scout_F',1,
			'I_LT_01_cannon_F',1,
			'I_LT_01_AA_F',1
		];
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardText = format ['a(n) %1',(getText ((configOf _rewardVeh) >> 'displayName'))];
	};
	if (_reward isEqualTo 30) then {
		//comment 'Angara';
		_rewardType = ['O_MBT_04_cannon_F','O_T_MBT_04_cannon_F'] select (worldName in ['Tanoa','Lingor3','Enoch']);
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardText = format ['a(n) %1',(getText ((configOf _rewardVeh) >> 'displayName'))];
	};
	if (_reward isEqualTo 31) then {
		//comment 'Rhino';
		_rewardTypes = [
			['B_AFV_Wheeled_01_up_cannon_F',0.333,'B_AFV_Wheeled_01_cannon_F',0.666],
			['B_T_AFV_Wheeled_01_up_cannon_F',0.333,'B_T_AFV_Wheeled_01_cannon_F',0.666]
		] select (worldName in ['Tanoa','Lingor3','Enoch']);
		_rewardType = selectRandomWeighted _rewardTypes;
		_rewardVeh = createVehicle [_rewardType,_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardText = format ['a(n) %1',(getText ((configOf _rewardVeh) >> 'displayName'))];
	};
	
	if (_reward isEqualTo 32) then {
		// Tractor
		_rewardVeh = createVehicle ['C_Tractor_01_F',_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);
		_rewardVeh setVariable ['QS_disableRespawnAction',TRUE,TRUE];
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		_rewardText = format ['a(n) %1',(getText ((configOf _rewardVeh) >> 'displayName'))];
	};
	
	if (_reward isEqualTo 33) then {
		// Bush Hog
		_rewardVeh = createVehicle ['B_APC_Wheeled_01_cannon_F',_rewardPosition,[],0,'NONE'];
		_rewardVeh setDir (random 360);	
		[_rewardVeh] call (missionNamespace getVariable 'QS_fnc_vSetup');
		[_rewardVeh] call QS_fnc_createBushHog;
	};	
	if (!isNull _rewardVeh) then {
		if ((attachedObjects _rewardVeh) isEqualTo []) then {
			(serverNamespace getVariable 'QS_v_Monitor') pushBack [
				_rewardVeh,
				30,
				FALSE,
				{},
				_rewardType,
				_rewardPosition,
				(getDir _rewardVeh),
				FALSE,
				0,
				-1,
				50,
				500,
				0,
				6,
				FALSE,
				0,
				{TRUE},
				FALSE,
				FALSE,
				[],
				[],
				0,
				{TRUE}
			];
		};
	};
	_newRewardArray deleteAt (_newRewardArray find _reward);
	missionNamespace setVariable ['QS_smReward_array',_newRewardArray,FALSE];
	_pic = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_editorpreview',toLowerANSI _rewardType],
		{getText ((configOf _rewardVeh) >> 'editorPreview')},
		TRUE
	];
	_completeText = parseText format ["<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight.<br/> <img size='5' image='%2'/> <br/><br/>You'll find it at base.</t>",_rewardText,_pic];
	//['hintSilent',_completeText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	['Reward',[format ['%2 %1!',_rewardText,localize 'STR_QS_Notif_077']]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};