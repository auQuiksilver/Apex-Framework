/*
File: fn_clientMenuFireSupport.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/12/2022 A3 2.10 by Quiksilver

Description:

	System for players to call in support from:
		
		- Other players
		- AI
		
Notes:

	Beta
	Currently only supports Fire Support
______________________________________*/

disableSerialization;
params ['_type1'];
if (_type1 isEqualTo 'onLoad') exitWith {
	params ['','_display1'];
	_targetPos = missionNamespace getVariable ['QS_client_fireSupport_target',[-10,-10,0]];
	private _textSupportTypes = localize 'STR_QS_Menu_214';
	private _textDataLink = localize 'STR_QS_Menu_215';
	private _textSelect = localize 'STR_QS_Menu_032';
	_idc_text1 = 1802;
	_idc_lb_asset = 1804;
	_idc_lb_loadout = 1812;
	(_display1 displayCtrl 1813) ctrlSetText _textSupportTypes;
	_buttonSelect = _display1 displayCtrl 1815;
	_buttonSelect ctrlSetText _textSelect;
	private _naval = [];
	private _airSupport = [];
	private _indirectFire = [];
	private _indirectFireMortar = [];
	private _directFire = [];
	
	// We should do this instead
	_listSupports = [
		['CAS',[]],
		['Artillery',[]],
		['Naval Artillery',[]],
		['Armor',[]],
		['Air Recon',[]],
		['Resupply',[]]
	];
	
	private _side = player getVariable ['QS_unit_side',WEST];
	private _vehicle = objNull;
	private _unit = objNull;
	private _isArtillery = FALSE;
	private _assetList = [];
	private _assetList2 = [objNull];
	private _data = [];
	private _text = '';
	private _name = '';
	private _supportType = '';
	{
		lbAdd [_idc_lb_asset,_x # 1];
	} forEach _data;
	{
		uiNamespace setVariable _x;
	} forEach [
		['QS_client_fireSupport_selectedIndex',-1],
		['QS_client_fireSupport_selectedIndex2',-1],
		['QS_client_fireSupport_selectedType',''],
		['QS_client_fireSupport_selectedLoadoutData',''],
		['QS_client_fireSupport_selectedData',''],
		['QS_client_fireSupport_selectedAsset',objNull],
		['QS_client_fireSupport_selectedWeapon',''],
		['QS_client_fireSupport_updateAssets',TRUE],
		['QS_client_fireSupport_buttonCooldown',-1],
		['QS_client_fireSupport_type','']
	];
	private _selectedIndex = -1;
	private _selectedIndex2 = -1;
	private _dataIndex = -1;
	private _loadoutData = [];
	private _asset = objNull;
	private _weapon = '';
	private _data_loadout = [];
	private _serverTime = serverTime;
	private _uiTime = diag_tickTime;
	private _fireSupportType = '';
	private _aiSupportEnabled = (missionNamespace getVariable ['QS_missionConfig_fireSupport',1]) > 1;
	private _dn = '';
	private _outOfRange = FALSE;
	private _outOfRangeText = '';
	for '_z' from 0 to 1 step 0 do {
		uiSleep diag_deltaTime;
		_uiTime = diag_tickTime;
		_serverTime = serverTime;
		_assetList = _assetList select {((alive _x) && (alive (effectiveCommander _x)))};
		if (
			(_assetList isNotEqualTo _assetList2) ||
			(uiNamespace getVariable ['QS_client_fireSupport_updateAssets',FALSE])
		) then {
			uiNamespace setVariable ['QS_client_fireSupport_updateAssets',FALSE];
			_assetList = [];
			_naval = [];
			_airSupport = [];
			_indirectFire = [];
			_indirectFireMortar = [];
			_directFire = [];
			{
				_unit = _x;
				_vehicle = objectParent _x;
				if (
					(alive _vehicle) &&
					(_unit isEqualTo (effectiveCommander _vehicle)) &&
					((lifeState (effectiveCommander _vehicle)) in ['HEALTHY','INJURED']) &&
					((isPlayer _unit) || _aiSupportEnabled)
				) then {
					if (
						(_vehicle isKindOf 'Air') &&
						((getAllPylonsInfo _vehicle) isNotEqualTo [])
					) then {
						_assetList pushBackUnique _vehicle;
						_airSupport pushBackUnique [_vehicle,0];
					};
					if (_vehicle isKindOf 'LandVehicle') then {
						_isArtillery = (getNumber ((configOf _vehicle) >> 'artilleryScanner')) > 0;
						if (
							_isArtillery &&
							{(!(_vehicle isKindOf 'b_ship_gun_01_f'))}
						) then {
							_assetList pushBackUnique _vehicle;
							if (_vehicle isKindOf 'StaticMortar') then {
								_indirectFire pushBackUnique [_vehicle,4];
							} else {
								_indirectFire pushBackUnique [_vehicle,1];
							};
						} else {
							if (
								(_vehicle isKindOf 'Tank') ||
								{(_vehicle isKindOf 'Wheeled_APC_F')}
							) then {
								_assetList pushBackUnique _vehicle;
								_directFire pushBackUnique [_vehicle,2];
							};
						};
					};
					if ((['b_ship_mrls_01_f','b_ship_gun_01_f'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1) then {
						if (
							(_vehicle isKindOf 'b_ship_mrls_01_f') &&
							(QS_player getUnitTrait 'QS_trait_jtac')
						) then {
							_assetList pushBackUnique _vehicle;
							_naval pushBackUnique [_vehicle,3];
						};
						if (_vehicle isKindOf 'b_ship_gun_01_f') then {
							// Disabled for 1.5.5 due to instability
							//_assetList pushBackUnique _vehicle;
							//_naval pushBackUnique [_vehicle,3];
						};
					};
				};
			} forEach (units _side);
			_assetList2 = _assetList;
			_data = [];
			{
				_supportType = localize 'STR_QS_Menu_216';
				if ((_x # 1) isEqualTo 0) then {
					_supportType = localize 'STR_QS_Menu_217';
				};
				if ((_x # 1) isEqualTo 1) then {
					_supportType = localize 'STR_QS_Menu_218';
				};
				if ((_x # 1) isEqualTo 2) then {
					_supportType = localize 'STR_QS_Menu_219';
				};
				if ((_x # 1) isEqualTo 3) then {
					_supportType = localize 'STR_QS_Menu_220';
				};
				if ((_x # 1) isEqualTo 4) then {
					_supportType = localize 'STR_QS_Menu_224';
				};
				_name = [localize 'STR_QS_Utility_030',name (effectiveCommander (_x # 0))] select (isPlayer (effectiveCommander (_x # 0)));
				_outOfRange = FALSE;
				_outOfRangeText = '';
				if (
					((_x # 1) in [1,4]) &&
					{(!(_targetPos inRangeOfArtillery [[gunner (_x # 0)],((magazines (_x # 0)) # 0)]))}
				) then {
					_outOfRange = TRUE;
					_outOfRangeText = localize 'STR_QS_Menu_227';
				};
				_text = format ['%3%4 %1 ( %2 )',getText ((configOf (_x # 0)) >> 'displayName'),_name,_supportType,(['',_outOfRangeText] select _outOfRange)];
				_data pushBack [(_x # 0),_text,_supportType];
			} forEach (_airSupport + _indirectFire + _directFire + _naval);
			lbClear _idc_lb_asset;
			{
				lbAdd [_idc_lb_asset,_x # 1];
			} forEach _data;
			if (_data isNotEqualTo []) then {
				lbSetCurSel [_idc_lb_asset,0];
			};
		};
		_selectedIndex = lbCurSel (_display1 displayCtrl _idc_lb_asset);
		if (
			(_selectedIndex isNotEqualTo -1) &&
			{(_selectedIndex isNotEqualTo (uiNamespace getVariable ['QS_client_fireSupport_selectedIndex',-1]))} &&
			{_data isNotEqualTo []}
		) then {
			_asset = (_data # _selectedIndex) # 0;
			_fireSupportType = (_data # _selectedIndex) # 2;
			{
				uiNamespace setVariable _x;
			} forEach [
				['QS_client_fireSupport_selectedIndex',_selectedIndex],
				['QS_client_fireSupport_selectedAsset',_asset],
				['QS_client_fireSupport_selectedIndex2',-1],
				['QS_client_fireSupport_selectedWeapon',''],
				['QS_client_fireSupport_type',_fireSupportType]
			];
			lbClear _idc_lb_loadout;
			if (_asset isKindOf 'B_Ship_MRLS_01_F') then {
				(_display1 displayCtrl 1813) ctrlSetText _textDataLink;
				_data_loadout = (getSensorTargets _asset) apply {_x # 0};
				_data_loadout = _data_loadout select {(_x isEqualTo (laserTarget player))};
				{
					lbAdd [_idc_lb_loadout,format ['%1 - %2',getText ((configOf _x) >> 'displayName'),mapGridPosition _x]];
				} forEach _data_loadout;
			} else {
				(_display1 displayCtrl 1813) ctrlSetText _textSupportTypes;
				_data_loadout = weapons _asset;
				{
					lbAdd [_idc_lb_loadout,format ['%1',getText (configFile >> 'CfgWeapons' >> _x >> 'displayName')]];
				} forEach _data_loadout;
			};
			if (_idc_lb_loadout isNotEqualTo []) then {
				lbSetCurSel [_idc_lb_loadout,0];
			};
		};
		_selectedIndex2 = lbCurSel (_display1 displayCtrl _idc_lb_loadout);
		if (
			(_selectedIndex2 isNotEqualTo -1) &&
			{(_selectedIndex2 isNotEqualTo (uiNamespace getVariable ['QS_client_fireSupport_selectedIndex2',-1]))} &&
			{_data_loadout isNotEqualTo []}
		) then {
			_weapon = _data_loadout # _selectedIndex2;
			if (!isNil '_weapon') then {
				uiNamespace setVariable ['QS_client_fireSupport_selectedIndex2',_selectedIndex2];
				uiNamespace setVariable ['QS_client_fireSupport_selectedWeapon',_weapon];
			};
		};
		if (_uiTime < (uiNamespace getVariable ['QS_fireSupport_cooldown',-1])) then {
			_buttonSelect ctrlSetText (format [localize 'STR_QS_Menu_225',([ceil (((uiNamespace getVariable ['QS_fireSupport_cooldown',-1]) - _uiTime) max 0),"MM:SS"] call BIS_fnc_secondsToString)]);
		} else {
			if (
				(_asset isEqualType objNull) && 
				(alive _asset) && 
				(_serverTime < (_asset getVariable ['QS_fireSupport_cooldown',-1]))
			) then {
				_buttonSelect ctrlSetText (format [localize 'STR_QS_Menu_226',([ceil (((_asset getVariable ['QS_fireSupport_cooldown',-1]) - _serverTime) max 0),"MM:SS"] call BIS_fnc_secondsToString)]);
			} else {
				_buttonSelect ctrlSetText _textSelect;
			};
		};
		_buttonSelect ctrlEnable (
			(_asset isEqualType objNull) &&
			{(_serverTime > (_asset getVariable ['QS_fireSupport_cooldown',-1]))} &&
			{(_uiTime > (uiNamespace getVariable ['QS_fireSupport_cooldown',-1]))} &&
			{(_uiTime > (uiNamespace getVariable ['QS_client_fireSupport_buttonCooldown',-1]))}
		);
		if (isNull _display1) exitWith {};
	};
	uiNamespace setVariable ['QS_client_fireSupport_target',objNull];
};
if (_type1 isEqualTo 'onUnload') exitWith {
	
};
if (_type1 isEqualTo 'Select') exitWith {
	closeDialog 2;
	uiNamespace setVariable ['QS_client_fireSupport_buttonCooldown',diag_tickTime + 0.5];
	_asset = uiNamespace getVariable ['QS_client_fireSupport_selectedAsset',objNull];
	_weapon = uiNamespace getVariable ['QS_client_fireSupport_selectedWeapon',''];
	_targetPos = missionNamespace getVariable ['QS_client_fireSupport_target',[-10,-10,0]];
	_supportType = uiNamespace getVariable ['QS_client_fireSupport_type',localize 'STR_QS_Menu_216'];
	if (
		(!alive _asset) ||
		{((crew _asset) isEqualTo [])} ||
		{((_weapon isEqualType objNull) && {(isNull _weapon)})}
	) exitWith {systemchat (localize 'STR_QS_Menu_229');};
	_isArtillery = (getNumber ((configOf _asset) >> 'artilleryScanner')) > 0;
	if (
		_isArtillery &&
		{(!(_targetPos inRangeOfArtillery [[gunner _asset],((magazines _asset) # 0)]))}
	) exitWith {
		50 cutText [localize 'STR_QS_Menu_228','PLAIN DOWN',0.333];
	};	
	if (diag_tickTime < (uiNamespace getVariable ['QS_fireSupport_cooldown',-1])) exitWith {
		50 cutText [format [localize 'STR_QS_Menu_225',([ceil (((uiNamespace getVariable ['QS_fireSupport_cooldown',-1]) - (round diag_tickTime)) max 0),"MM:SS"] call BIS_fnc_secondsToString)],'PLAIN DOWN',0.333];
	};
	_cooldown = [60,15] select (player getUnitTrait 'QS_trait_jtac');
	uiNamespace setVariable ['QS_fireSupport_cooldown',round (diag_tickTime + _cooldown)];
	if (serverTime < (_asset getVariable ['QS_fireSupport_cooldown',-1])) exitWith {
		_text = format [localize 'STR_QS_Menu_226',(((_asset getVariable ['QS_fireSupport_cooldown',-1]) - (round serverTime)) max 0)];
		50 cutText [_text,'PLAIN DOWN',0.333];
	};
	([_targetPos,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (_inSafezone && _safezoneActive) then {
		_text = format [localize 'STR_QS_Menu_221',profileName,mapGridPosition _targetPos];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2];
	};
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
		systemChat (localize 'STR_QS_Menu_222');
		uiNamespace setVariable ['QS_fireSupport_cooldown',round (diag_tickTime + 900)];
	};
	_isArtillery = (getNumber ((configOf _asset) >> 'artilleryScanner')) > 0;
	_isAI = !isPlayer (effectiveCommander _asset);
	[119,[_targetPos,player,profileName,_supportType,_isAI,_asset]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	_aiSupportEnabled = (missionNamespace getVariable ['QS_missionConfig_fireSupport',1]) > 1;
	private _called = FALSE;
	private _failed = FALSE;
	if (_isAI && _aiSupportEnabled) then {
		if (_isArtillery) then {
			_called = TRUE;
			[119,[_asset,_weapon,_targetPos,clientOwner]] remoteExec ['QS_fnc_remoteExec',_asset,FALSE];
		};
		if (_asset isKindOf 'B_Ship_MRLS_01_F') then {
			if (
				(_weapon isEqualType objNull) &&
				{(_weapon isKindOf 'LaserTarget')}
			) then {
				_called = TRUE;
				_asset setVariable ['QS_fireSupport_cooldown',serverTime + 1800,TRUE];
				_asset setVariable ['QS_fireSupport_requester',profileName,TRUE];
				_asset setVariable ['QS_fireSupport_type',_supportType,TRUE];
				[119,[_asset,_weapon,QS_player,clientOwner]] remoteExec ['QS_fnc_remoteExec',_asset,FALSE];
			} else {
				_failed = TRUE;
				50 cutText ['VLS can only lock on laser targets','PLAIN DOWN',0.5];
			};
		};
	};
	if (
		!_called &&
		!_failed
	) then {
		[119,[_targetPos,player,profileName,_supportType,_isAI,_asset]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};