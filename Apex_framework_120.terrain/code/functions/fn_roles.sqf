/*/
File: fn_roles.sqf
Author:

	Quiksilver
	
Last Modified:

	5/05/2019 A3 1.92 by Quiksilver
	
Description:

	Roles System
________________________________________/*/

params ['_type'];
if (_type isEqualTo 'HANDLE') exitWith {
	(uiNamespace getVariable ['QS_roles_handler',[]]) pushBack (_this # 1);
	if ((uiNamespace getVariable ['QS_roles_PFH',0]) isEqualTo 0) then {
		uiNamespace setVariable ['QS_roles_PFH',(addMissionEventHandler ['EachFrame',(missionNamespace getVariable 'QS_fnc_eventEachFrame')])];
	};
};
if (_type isEqualTo 'PROPAGATE') exitWith {
	params [
		'',
		['_force',FALSE]
	];
	private _role = 'rifleman';
	private _role_data = [];
	private _role_manifest = [];
	private _role_queue = [];
	private _role_capacity = 0;
	private _role_count = 0;
	private _role_queue_capacity = 0;
	private _role_queue_count = 0;
	private _role_index = -1;
	private _whitelist_capacity = 0;
	private _propagate = _force;
	{
		_side_roles_data = _x;
		{
			_role_data = _x # 0;
			_role_manifest = _x # 1;
			_role_queue = _x # 2;
			_role = _role_data # 0;
			_role_capacity = count _role_manifest;
			_role_count = count (_role_manifest select {((_x # 0) isNotEqualTo '')});
			_role_queue_capacity = count _role_queue;
			_role_queue_count = count (_role_queue select {((_x # 0) isNotEqualTo '')});
			_role_index = (missionNamespace getVariable 'QS_RSS_public') findIf {(_x # 0) isEqualTo _role};
			if (_role_index isNotEqualTo -1) then {
				if ( ((missionNamespace getVariable 'QS_RSS_public') # _role_index) isNotEqualTo [_role,_role_count,_role_capacity,_role_queue_count,_role_queue_capacity]) then {
					(missionNamespace getVariable 'QS_RSS_public') set [_role_index,[_role,_role_count,_role_capacity,_role_queue_count,_role_queue_capacity]];
					if (!(_propagate)) then {
						_propagate = TRUE;
					};
				};
			} else {
				(missionNamespace getVariable 'QS_RSS_public') pushBack [_role,_role_count,_role_capacity,_role_queue_count,_role_queue_capacity];
				if (!(_propagate)) then {
					_propagate = TRUE;
				};
			};
		} forEach _side_roles_data;
	} forEach (missionNamespace getVariable 'QS_unit_roles');
	if (_propagate) then {
		missionNamespace setVariable ['QS_RSS_public',(missionNamespace getVariable 'QS_RSS_public'),TRUE];
		missionNamespace setVariable ['QS_RSS_refreshUI',TRUE,TRUE];
	};
};
if (_type isEqualTo 'GET_ROLE_COUNT') exitWith {
	params [
		'',
		['_role',''],
		['_side',sideEmpty],
		['_returnText',FALSE]
	];
	private _data = [];
	_table_index = (missionNamespace getVariable 'QS_RSS_public') findIf {((_x # 0) isEqualTo _role)};
	_data = ((missionNamespace getVariable 'QS_RSS_public') # _table_index) select [1,4];
	_data params ['_role_count','_role_capacity','_role_queue_count','_role_queue_capacity'];
	private _return = [[_role_count,_role_capacity,_role_queue_count,_role_queue_capacity],'( 0 / 0 )'] select _returnText;
	_playerCount = count allPlayers;
	private _exit = FALSE;
	private _role2 = 'rifleman';
	private _roles_side = [];
	private _min = 0;
	private _max = 0;
	private _coef = 0;
	private _whitelist_value = 0;
	private _role_data = [];
	{
		_roles_side = _x;
		if (_roles_side isNotEqualTo []) then {
			{
				_role2 = _x # 0;
				if (_role isEqualTo _role2) then {
					_min = _x # 2;
					_max = _x # 3;
					_coef = _x # 4;
					_whitelist_value = _x # 5;
					if (_whitelist_value > 0) then {
						_min = _min + _whitelist_value;
						_max = _max + _whitelist_value;
					};
					_exit = TRUE;
				};
				if (_exit) exitWith {};
			} forEach _roles_side;
		};
		if (_exit) exitWith {};
	} forEach (missionNamespace getVariable 'QS_roles_data');
	if (_coef isEqualTo -1) then {
		_role_capacity = _min max _max;
	} else {
		_role_capacity = _min max (_min + (floor (_playerCount / _coef))) min _max;
	};
	if (_returnText) then {
		if ([_role_count,_role_capacity] isNotEqualTo [0,0]) then {
			_return = format ['( %1 / %2 )',_role_count,_role_capacity];
		};
	} else {
		_return = [_role_count,_role_capacity,_role_queue_count,_role_queue_capacity];
	};
	_return;
};
if (_type isEqualTo 'UPDATE_UI') exitWith {
	params [
		'',
		['_unit',objNull]
	];
	if (!isNull _unit) then {
		{
			_unit setVariable _x;
		} forEach [
			['QS_unit_role_icon',(['GET_ROLE_ICONMAP',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles')),FALSE],
			['QS_unit_role_displayName',(['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles')),FALSE],
			['QS_unit_role_netUpdate',FALSE,FALSE]
		];
	};
};
if (_type isEqualTo 'GET_ROLE_DISPLAYNAME') exitWith {
	params [
		'',
		['_role',''],
		['_unit',objNull]
	];
	private _return = 'Rifleman';
	if (_role isEqualTo '') then {
		if (!isNull _unit) then {
			_role = _unit getVariable ['QS_unit_role','rifleman'];
		};
	};
	_table_index = (missionNamespace getVariable 'QS_roles_UI_info') findIf {((_x # 0) isEqualTo _role)};
	if (_table_index isNotEqualTo -1) then {
		_return = ((missionNamespace getVariable 'QS_roles_UI_info') # _table_index) # 1;
	};
	_return;
};
if (_type isEqualTo 'GET_ROLE_DISPLAYNAME2') exitWith {
	params [
		'',
		['_role',''],
		['_unit',objNull]
	];
	private _return = 'Rifleman';
	if (_role isEqualTo '') then {
		if (!isNull _unit) then {
			_role = _unit getVariable ['QS_unit_role','rifleman'];
		};
	};
	_table_index = (missionNamespace getVariable 'QS_roles_UI_info') findIf {((_x # 0) isEqualTo _role)};
	if (_table_index isNotEqualTo -1) then {
		_return = ((missionNamespace getVariable 'QS_roles_UI_info') # _table_index) # 1;
	};
	private _exit = FALSE;
	private _roles_side = [];
	/*/
	{
		_roles_side = _x;
		if (_roles_side isNotEqualTo []) then {
			{
				_role2 = _x # 0;
				if (_role isEqualTo _role2) then {
					_exit = TRUE;
					_role_whitelisted = (_x # 5) > 0;
				};
				if (_exit) exitWith {};
			} forEach _roles_side;
		};
		if (_exit) exitWith {};
	} forEach (missionNamespace getVariable 'QS_roles_data');
	/*/
	if (['_WL',_role,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
		_return = '[Whitelisted] ' + _return;
	};
	_return;
};
if (_type isEqualTo 'GET_ROLE_ICON') exitWith {
	params [
		'',
		['_role',''],
		['_unit',objNull]
	];
	private _return = 'a3\ui_f\data\map\vehicleicons\iconMan_ca.paa';
	if (_role isEqualTo '') then {
		if (!isNull _unit) then {
			_role = _unit getVariable ['QS_unit_role','rifleman'];
		};
	};
	_table_index = (missionNamespace getVariable 'QS_roles_UI_info') findIf {((_x # 0) isEqualTo _role)};
	if (_table_index isNotEqualTo -1) then {
		_return = ((missionNamespace getVariable 'QS_roles_UI_info') # _table_index) # 2;
	};
	_return;
};
if (_type isEqualTo 'GET_ROLE_ICONMAP') exitWith {
	params [
		'',
		['_role',''],
		['_unit',objNull]
	];
	private _return = 'a3\ui_f\data\map\vehicleicons\iconMan_ca.paa';
	if (_role isEqualTo '') then {
		if (!isNull _unit) then {
			_role = _unit getVariable ['QS_unit_role','rifleman'];
		};
	};
	_table_index = (missionNamespace getVariable 'QS_roles_UI_info') findIf {((_x # 0) isEqualTo _role)};
	if (_table_index isNotEqualTo -1) then {
		_return = ((missionNamespace getVariable 'QS_roles_UI_info') # _table_index) # 3;
	};
	_return;
};
if (_type isEqualTo 'GET_ROLE_DESCRIPTION') exitWith {
	params [
		'',
		['_role','rifleman']
	];
	([_role] call (missionNamespace getVariable 'QS_fnc_roleDescription'));	
};
if (_type isEqualTo 'HANDLE_CONNECT') exitWith {
	params ['','_data'];
	_data params ['_unit','_jip','_cid','_uid','_profileName'];
	(uiNamespace getVariable ['QS_roles_handler',[]]) pushBack ['HANDLE_REQUEST_ROLE',_uid,(missionNamespace getVariable ['QS_roles_defaultSide',WEST]),(missionNamespace getVariable ['QS_roles_defaultRole','rifleman']),_unit];
};
if (_type isEqualTo 'HANDLE_DISCONNECT') exitWith {
	params ['','_data'];
	_data params ['','','_uid',''];
	_roles = missionNamespace getVariable 'QS_unit_roles';
	_side_ID = _side call (missionNamespace getVariable 'QS_fnc_sideID');
	private _roles_side = [];
	private _prior_role_index = -1;
	private _prior_queue_index = -1;
	private _roles_side_ID = 0;
	private _roles_role = [];
	{
		_roles_side = _x;
		_roles_side_ID = _forEachIndex;
		if (_roles_side isNotEqualTo []) then {
			{
				_roles_role = _x;
				_roles_role params [
					'_role_data',
					'_role_manifest',
					'_role_queue'
				];
				_prior_role_index = _role_manifest findIf {((_x # 0) isEqualTo _uid)};
				if (_prior_role_index isNotEqualTo -1) then {
					_role_manifest set [_prior_role_index,['',((_role_manifest # _prior_role_index) # 1)]];
					_roles_role set [1,_role_manifest];
					_roles_side set [_forEachIndex,_roles_role];
					(missionNamespace getVariable 'QS_unit_roles') set [_roles_side_ID,_roles_side];
					['PROPAGATE'] call (missionNamespace getVariable 'QS_fnc_roles');
				};
				_prior_queue_index = _role_queue findIf {((_x # 0) isEqualTo _uid)};
				if (_prior_queue_index isNotEqualTo -1) then {
					_role_queue set [_prior_role_index,['',-1]];
					_roles_role set [2,_role_queue];
					_roles_side set [_forEachIndex,_roles_role];
					(missionNamespace getVariable 'QS_unit_roles') set [_roles_side_ID,_roles_side];
					['PROPAGATE'] call (missionNamespace getVariable 'QS_fnc_roles');
				};
			} forEach _roles_side;
		};
	} forEach _roles;
};
if (_type isEqualTo 'REQUEST_ROLE') exitWith {
	params [
		'',
		'_uid',
		'_side',
		'_role',
		'_unit',
		'_clientOwner'
	];
	private _isCAS = FALSE;
	private _exit = FALSE;
	private _roles_side = [];
	private _role_data = [];
	private _whitelisted = _uid in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'));
	private _roleCount = [0,0];
	private _whitelist_value = 0;
	/*/
	{
		_roles_side = _x;
		if (_roles_side isNotEqualTo []) then {
			{
				_role2 = _x # 0;
				if ((_x # 1) isEqualTo _side) then {
					if (_role isEqualTo _role2) then {
						_exit = TRUE;
						_whitelist_value = _x # 5;
						_role_whitelisted = _whitelist_value > 0;
					};
				};
				if (_exit) exitWith {};
			} forEach _roles_side;
		};
		if (_exit) exitWith {};
	} forEach (missionNamespace getVariable 'QS_roles_data');
	/*/
	
	if (diag_tickTime >= (uiNamespace getVariable ['QS_RSS_requestCooldown',-1])) then {
		uiNamespace setVariable ['QS_RSS_requestCooldown',(diag_tickTime + 3)];
		private _allowRequest = TRUE;
		
		if (uiNamespace getVariable ['QS_client_roles_menu_canSelectRole',FALSE]) then {
			_roleCount = ['GET_ROLE_COUNT',_role,_side,FALSE] call (missionNamespace getVariable 'QS_fnc_roles');
			if ((_roleCount # 0) < (_roleCount # 1)) then {
				if (!( ((player getVariable ['QS_unit_role','rifleman']) isEqualTo _role) && ((player getVariable ['QS_unit_side',WEST]) isEqualTo _side) )) then {
					
				} else {
					_allowRequest = FALSE;
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Already in selected role',[],-1,TRUE,'Role Selection',FALSE];
				};
			} else {
				_allowRequest = FALSE;
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Maximum number of players in selected role',[],-1,TRUE,'Role Selection',FALSE];
			};
		} else {
			if ((_side isNotEqualTo (player getVariable ['QS_unit_side',WEST])) && (!(missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))) then {
				_allowRequest = FALSE;
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Cannot switch faction',[],-1,TRUE,'Role Selection',FALSE];
			} else {
				_allowRequest = FALSE;
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Cannot select role',[],-1,TRUE,'Role Selection',FALSE];
			};
		};
		if (_role in ['pilot_plane','pilot_cas']) then {
			_isCAS = TRUE;
			if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 0) then {
				_allowRequest = FALSE;
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Close Air Support roles disabled in mission parameters.',[],-1,TRUE,'Role Selection',FALSE];
			};
			if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [1,3]) then {
				if (!(_uid in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist')))) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Not in CAS role whitelist (talk to admins to get whitelisted!)',[],-1,TRUE,'Role Selection',FALSE];
					_allowRequest = FALSE;
				};
			};
			if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 3) then {
				if ((player getVariable ['QS_client_casAllowance',0]) >= (missionNamespace getVariable ['QS_CAS_jetAllowance_value',3])) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,(format ['CAS jet limit exceeded ( %1 )',(missionNamespace getVariable ['QS_CAS_jetAllowance_value',3])]),[],-1,TRUE,'Role Selection',FALSE];
					_allowRequest = FALSE;
				};
			};
		};
		if (!(_isCAS)) then {
		
			// Whitelisting
			if ((['_WL',_role,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) && (!(_whitelisted))) then {
				//_roleCount = ['GET_ROLE_COUNT',_role,_side,FALSE] call (missionNamespace getVariable 'QS_fnc_roles');
				//_roleCount set [1,((_roleCount # 1) - _whitelist_value)];
				//if ((_roleCount # 0) >= (_roleCount # 1)) then {
					_allowRequest = FALSE;
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,10,-1,'Whitelisted slot<br/><br/>(talk to admins to get whitelisted!)',[],-1,TRUE,'Role Selection',FALSE];
				//};
			};
		};
		if (_allowRequest) then {
			[15,_uid,_side,_role,_unit,_clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
};
if (_type isEqualTo 'HANDLE_REQUEST_ROLE') exitWith {
	params [
		'',
		['_uid',''],
		['_side',WEST],
		['_role','rifleman'],
		['_unit',objNull]
	];
	//diag_log (format ['Role requested: %1',_this]);
	if (_uid isEqualTo '') then {
		_uid = getPlayerUID _unit;
	};
	_pCnt = count allPlayers;
	_roles = missionNamespace getVariable 'QS_unit_roles';
	_side_ID = _side call (missionNamespace getVariable 'QS_fnc_sideID');
	private _roles_side = [];
	private _prior_role_index = -1;
	private _prior_queue_index = -1;
	private _roles_side_ID = 0;
	private _roles_role = [];
	{
		_roles_side = _x;
		_roles_side_ID = _forEachIndex;
		if (_roles_side isNotEqualTo []) then {
			{
				_roles_role = _x;
				_roles_role params [
					'_role_data',
					'_role_manifest',
					'_role_queue'
				];
				_prior_role_index = _role_manifest findIf {((_x # 0) isEqualTo _uid)};
				if (_prior_role_index isNotEqualTo -1) then {
					_role_manifest set [_prior_role_index,['',((_role_manifest # _prior_role_index) # 1)]];
					_roles_role set [1,_role_manifest];
					_roles_side set [_forEachIndex,_roles_role];
					(missionNamespace getVariable 'QS_unit_roles') set [_roles_side_ID,_roles_side];
				};
				_prior_queue_index = _role_queue findIf {((_x # 0) isEqualTo _uid)};
				if (_prior_queue_index isNotEqualTo -1) then {
					_role_queue set [_prior_role_index,['',-1]];
					_roles_role set [2,_role_queue];
					_roles_side set [_forEachIndex,_roles_role];
					(missionNamespace getVariable 'QS_unit_roles') set [_roles_side_ID,_roles_side];
				};
			} forEach _roles_side;
		};
	} forEach _roles;
	_roles = missionNamespace getVariable 'QS_unit_roles';
	private _roles_side = _roles # _side_ID;	
	_role_data_index = _roles_side findIf {(((_x # 0) # 0) isEqualTo _role)};
	(_roles_side # _role_data_index) params [
		'_role_data',
		'_role_units',
		'_role_queue'
	];
	_available_role_index = _role_units findIf {(((_x # 0) isEqualTo '') && (((_x # 1) isEqualTo -1) || (_pCnt > (_x # 1))))};
	if (_available_role_index isEqualTo -1) exitWith {};
	_available_role = _role_units # _available_role_index;
	_role_data params [
		'',	//'_role_data_role',
		'_role_data_side',
		'',	//'_role_data_min',
		'',	//'_role_data_max',
		'',	//'_role_data_availabilityCoef',
		'',	//'_whitelist_value',
		''	//'_queue_capacity'
	];
	if (_role_data_side isNotEqualTo _side) exitWith {};
	_available_role set [0,_uid];
	_role_units set [_available_role_index,_available_role];
	_roles_side set [_role_data_index,[_role_data,_role_units,_role_queue]];
	(missionNamespace getVariable 'QS_unit_roles') set [_side_ID,_roles_side];
	['PROPAGATE'] call (missionNamespace getVariable 'QS_fnc_roles');
	missionNamespace setVariable ['QS_RSS_refreshUI',TRUE,TRUE];
	if ((side (group _unit)) isNotEqualTo _side) then {
		if ((count (allGroups select {((side _x) isEqualTo _side)})) >= 100) then {
			{
				if (local _x) then {
					if ((side _x) isEqualTo _side) then {
						if (((units _x) findIf {(alive _x)}) isEqualTo -1) then {
							deleteGroup _x;
						};
					};
				};
			} forEach allGroups;
		};
		[_unit] joinSilent (createGroup [_side,TRUE]);
		if (_side isNotEqualTo (_unit getVariable ['QS_unit_side',WEST])) then {
			_txt = format ['%1 switched from %2 to %3',(name _unit),(_unit getVariable ['QS_unit_side',WEST]),_side];
			_txt remoteExec ['systemChat',-2,FALSE];
			remoteExec ['QS_fnc_clientEventRespawn',_unit,FALSE];
		};
		_unit setVariable ['QS_unit_side',_side,TRUE];
	};
	_unit setVariable ['QS_unit_role',_role,TRUE];
	_unit setVariable ['QS_unit_role_netUpdate',TRUE,TRUE];
	[16,_role] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
	if (_role isEqualTo 'pilot_plane') then {
		if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isNotEqualTo 0) then {
			missionNamespace setVariable ['QS_fighterPilot',_unit,TRUE];
		};
	};
};
if (_type isEqualTo 'INIT_ROLE') exitWith {
	params ['','_role'];
	playSound 'orange_choice_select';
	player setVariable ['QS_unit_role',_role,FALSE];
	private _traitsData = [
		[['medic',FALSE,FALSE]],
		[['uavhacker',FALSE,FALSE]],
		[['engineer',FALSE,FALSE]],
		[['explosiveSpecialist',FALSE,FALSE]],
		[['audibleCoef',1,FALSE]],
		[['camouflageCoef',1,FALSE]],
		[['loadCoef',1,FALSE]],
		[['QS_trait_leader',FALSE,TRUE]],
		[['QS_trait_pilot',FALSE,TRUE]],
		[['QS_trait_AT',FALSE,TRUE]],
		[['QS_trait_gunner',FALSE,TRUE]],
		[['QS_trait_HQ',FALSE,TRUE]],
		[['QS_trait_fighterPilot',FALSE,TRUE]],
		[['QS_trait_cas',FALSE,TRUE]],
		[['QS_trait_JTAC',FALSE,TRUE]],
		[['QS_trait_LMG',FALSE,TRUE]],
		[['QS_trait_MMG',FALSE,TRUE]],
		[['QS_trait_Sniper',FALSE,TRUE]]
	];
	if (_role in ['autorifleman','o_autorifleman','autorifleman_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1.5,FALSE]],
			[['camouflageCoef',1.5,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',TRUE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role in ['machine_gunner','machine_gunner_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',2,FALSE]],
			[['camouflageCoef',2,FALSE]],
			[['loadCoef',1.25,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',TRUE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role in ['rifleman_lat','rifleman_hat','rifleman_aa','rifleman_missile','rifleman_hat_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',TRUE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role in ['medic','medic_WL']) then {
		_traitsData = [
			[['medic',TRUE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role isEqualTo 'engineer') then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',TRUE,FALSE]],
			[['explosiveSpecialist',TRUE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role in ['sniper','sniper_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',0.5,FALSE]],
			[['camouflageCoef',0.5,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',TRUE,TRUE]]
		];
	};
	if (_role in ['jtac','jtac_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',0.75,FALSE]],
			[['camouflageCoef',0.75,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',TRUE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role isEqualTo 'mortar_gunner') then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',TRUE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',TRUE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role isEqualTo 'uav') then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',TRUE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',FALSE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role in ['pilot_heli','pilot_heli_WL']) then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',TRUE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',TRUE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role isEqualTo 'pilot_plane') then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',FALSE,TRUE]],
			[['QS_trait_fighterPilot',TRUE,TRUE]],
			[['QS_trait_cas',TRUE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	if (_role isEqualTo 'commander') then {
		_traitsData = [
			[['medic',FALSE,FALSE]],
			[['uavhacker',FALSE,FALSE]],
			[['engineer',FALSE,FALSE]],
			[['explosiveSpecialist',FALSE,FALSE]],
			[['audibleCoef',1,FALSE]],
			[['camouflageCoef',1,FALSE]],
			[['loadCoef',1,FALSE]],
			[['QS_trait_leader',FALSE,TRUE]],
			[['QS_trait_pilot',FALSE,TRUE]],
			[['QS_trait_AT',FALSE,TRUE]],
			[['QS_trait_gunner',FALSE,TRUE]],
			[['QS_trait_HQ',TRUE,TRUE]],
			[['QS_trait_fighterPilot',FALSE,TRUE]],
			[['QS_trait_cas',TRUE,TRUE]],
			[['QS_trait_JTAC',FALSE,TRUE]],
			[['QS_trait_LMG',FALSE,TRUE]],
			[['QS_trait_MMG',FALSE,TRUE]],
			[['QS_trait_Sniper',FALSE,TRUE]]
		];
	};
	private _trait = '';
	private _traitValue = nil;
	private _isCustom = FALSE;
	private _traitData = [];
	_fn_initTrait = missionNamespace getVariable 'QS_fnc_initTrait';
	{
		_traitData = _x;
		_traitData params ['_traitParams'];
		_traitParams params ['_trait','_traitValue','_isCustom'];
		if (_traitValue isEqualType 0) then {
			if ((player getUnitTrait _trait) isNotEqualTo _traitValue) then {
				player setUnitTrait _traitParams;
				[_role,_traitParams] call _fn_initTrait;
			};
		} else {
			if (_traitValue isEqualType TRUE) then {
				if (_traitValue) then {
					if (!(player getUnitTrait _trait)) then {
						player setUnitTrait _traitParams;
						[_role,_traitParams] call _fn_initTrait;
					};
				} else {
					if (player getUnitTrait _trait) then {
						player setUnitTrait _traitParams;
						[_role,_traitParams] call _fn_initTrait;
					};
				};
			};
		};
	} forEach _traitsData;
	_role spawn {
		uiSleep 0.1;
		call (missionNamespace getVariable 'QS_fnc_clientArsenal');
		uiSleep 0.1;
		missionNamespace setVariable ['QS_client_arsenalData',([(player getVariable ['QS_unit_side',WEST]),_this] call (missionNamespace getVariable 'QS_data_arsenal')),FALSE];
	};
	['SET_SAVED_LOADOUT',_role] call (missionNamespace getVariable 'QS_fnc_roles');
	call (missionNamespace getVariable 'QS_fnc_respawnPilot');
	uiNamespace setVariable ['QS_client_respawnCooldown',diag_tickTime + 30];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,(format ['Role changed to %1',(['GET_ROLE_DISPLAYNAME',_role] call (missionNamespace getVariable 'QS_fnc_roles'))]),[],-1,TRUE,'Role Selection',FALSE];
};
if (_type isEqualTo 'SET_DEFAULT_LOADOUT') exitWith {
	params ['','_role',['_save',FALSE]];
	uiNamespace setVariable ['QS_RSS_requestCooldown',(diag_tickTime + 3)];
	_loadout_index = (missionNamespace getVariable 'QS_roles_defaultLoadouts') findIf {(_role isEqualTo (_x # 0))};
	if (_loadout_index isEqualTo -1) then {
		if ((getUnitLoadout player) isNotEqualTo (((missionNamespace getVariable 'QS_roles_defaultLoadouts') # 0) # 1)) then {
			player setUnitLoadout [(((missionNamespace getVariable 'QS_roles_defaultLoadouts') # 0) # 1),TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Loadout already applied',[],-1,TRUE,'Role Selection',FALSE];
		};
	} else {
		if ((getUnitLoadout player) isNotEqualTo (((missionNamespace getVariable 'QS_roles_defaultLoadouts') # _loadout_index) # 1)) then {
			player setUnitLoadout [(((missionNamespace getVariable 'QS_roles_defaultLoadouts') # _loadout_index) # 1),TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Loadout already applied',[],-1,TRUE,'Role Selection',FALSE];
		};
	};
	if (_save) then {
		_QS_playerRole = player getVariable ['QS_unit_role','rifleman'];
		missionNamespace setVariable ['QS_revive_arsenalInventory',(getUnitLoadout player),FALSE];
		private _QS_savedLoadouts = profileNamespace getVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))]),[]];
		_QS_loadoutIndex = (_QS_savedLoadouts findIf {((_x # 0) isEqualTo _QS_playerRole)});
		_a = [_QS_playerRole,(getUnitLoadout player)];
		if (_QS_loadoutIndex isEqualTo -1) then {
			_QS_savedLoadouts pushBack _a;
		} else {
			_QS_savedLoadouts set [_QS_loadoutIndex,_a];
		};
		profileNamespace setVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))]),_QS_savedLoadouts];
		saveProfileNamespace;
	};
};
if (_type isEqualTo 'SET_SAVED_LOADOUT') exitWith {
	params ['',['_role','rifleman']];
	private _customLoadout = FALSE;
	if ((((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) && ((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST)) || {(!((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']))}) then {
		if (!isNil {profileNamespace getVariable (format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))])}) then {
			if ((profileNamespace getVariable (format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))])) isEqualType []) then {
				if ((profileNamespace getVariable (format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))])) isNotEqualTo []) then {
					_QS_loadoutIndex = (profileNamespace getVariable (format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))])) findIf {((_x # 0) isEqualTo _role)};
					if (_QS_loadoutIndex isNotEqualTo -1) then {
						player setUnitLoadout [(((profileNamespace getVariable (format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))])) # _QS_loadoutIndex) # 1),TRUE];
						_customLoadout = TRUE;
					};
				};
			} else {
				profileNamespace setVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))]),[]];
				saveProfileNamespace;
			};
		} else {
			profileNamespace setVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa','Enoch']))]),[]];
			saveProfileNamespace;
		};
	};
	if (!(_customLoadout)) then {
		['SET_DEFAULT_LOADOUT',_role] call (missionNamespace getVariable 'QS_fnc_roles');
	};
};
if (_type isEqualTo 'INIT_SYSTEM') exitWith {

	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_roles_data',(missionNamespace getVariable 'QS_roles_data'),TRUE],
		['QS_roles_UI_info',(missionNamespace getVariable 'QS_roles_UI_info'),TRUE],
		['QS_roles_defaultLoadouts',(missionNamespace getVariable 'QS_roles_defaultLoadouts'),TRUE],
		['QS_fnc_roleDescription',(missionNamespace getVariable 'QS_fnc_roleDescription'),TRUE],
		['QS_unit_roles',[[],[],[],[]],FALSE],
		['QS_RSS_public',[]]
	];
	private _data_roles = missionNamespace getVariable ['QS_roles_data',[]];
	private _data_roles_side = [];
	private _role_to_add = [];
	private _sideID = 0;
	private _data_role = [];
	private _role = '';
	private _min_slots = 0;
	private _max_slots = 0;
	private _slots = [];
	private _slot_unlocked = 0;
	private _side_roles = [];
	private _role_side = sideEmpty;
	private _slot_availability_coef = 0;
	private _slot_availability_at = 0;
	private _i = 0;
	private _queue = [];
	{
		_sideID = _forEachIndex;
		_data_roles_side = _data_roles # _forEachIndex;
		if (_data_roles_side isNotEqualTo []) then {
			{
				_data_role = _x;
				_data_role params [
					'_role',
					'_role_side',
					'_min_slots',
					'_max_slots',
					'_slot_availability_coef',
					'_whitelist_value',
					'_queue_capacity'
				];
				_slots = [];
				_i = 0;
				_slot_availability_at = -1;
				for '_i' from 0 to (_max_slots - 1) step 1 do {
					if (_slot_availability_coef isNotEqualTo -1) then {
						if (_i >= _min_slots) then {
							_slot_availability_at = _slot_availability_at + _slot_availability_coef;
						};
					};
					_slots pushBack ['',([_slot_availability_at,-1] select (_i < _min_slots))];
				};
				if (_whitelist_value > 0) then {
					_i = 0;
					for '_i' from 0 to (_whitelist_value - 1) step 1 do {
						_slots pushBack ['',-1];
					};
				};
				_queue = [];
				_i = 0;
				for '_i' from 0 to (_queue_capacity - 1) step 1 do {
					_queue pushBack ['',-1];
				};
				_role_to_add = [];
				_role_to_add pushBack (_data_role select [0,8]);
				_role_to_add pushBack _slots;
				_role_to_add pushBack _queue;
				_side_roles = (missionNamespace getVariable 'QS_unit_roles') # _sideID;
				_side_roles pushBack _role_to_add;
				(missionNamespace getVariable 'QS_unit_roles') set [_sideID,_side_roles];
				if (((missionNamespace getVariable 'QS_RSS_public') findIf {((_x # 0) isEqualTo _role)}) isEqualTo -1) then {
					(missionNamespace getVariable 'QS_RSS_public') pushBack [_role,0,(count _slots),0,(count _queue)];
				};
			} forEach _data_roles_side;
		};
	} forEach _data_roles;
};