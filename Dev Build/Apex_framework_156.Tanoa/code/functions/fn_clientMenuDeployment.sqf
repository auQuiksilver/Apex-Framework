
disableSerialization;
params ['_mode'];
if (_mode isEqualTo 'onLoad') exitWith {
	localNamespace setVariable ['QS_deploymentMenu_opened',TRUE];
	openMap [TRUE,TRUE];
	_display = findDisplay 23000;
	
	_lbIDC = 1804;
	
	_ctrlFrame = _display displayCtrl 1800;
	_ctrlTitle = _display displayCtrl 1802;
	_ctrlSelect = _display displayCtrl 1810;
	_ctrlExit = _display displayCtrl 1811;
	_ctrlListbox = _display displayCtrl _lbIDC;	
	_ctrlHome = _display displayCtrl 1805;
	
	_ctrlHome ctrlSetTooltip (localize 'STR_QS_Menu_201');
	_ctrlTitle ctrlSetText (localize 'STR_QS_Menu_198');
	_ctrlSelect ctrlSetText (localize 'STR_QS_Menu_199');
	_ctrlExit ctrlSetText (localize 'STR_QS_Dialogs_085');
	
	private _entryType = uiNamespace getVariable ['QS_deployment_entryType','INTERACT'];
		
	_origin = getPosASL QS_player;	
	localNamespace setVariable ['QS_deploymentMenu_origin',_origin];

	_homeEnabled = missionNamespace getVariable ['QS_missionConfig_deployMenuHome',TRUE];
	private _home = localNamespace getVariable ['QS_deployment_home',''];

	private _ticketsEnabled = FALSE;

	_side = QS_player getVariable ['QS_unit_side',WEST];
	comment 'ONLY FACTION DEPLOYMENTS';
	private _deploymentPositions = (missionNamespace getVariable ['QS_system_deployments',[]]) select {
		_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
		(
			(_side in _arrayfactions) &&
			(_x call _codeConditionAddToMenu)
		)
	};
	comment 'GET NEAREST';
	private _dist = 999999;
	private _nearest = [0,0,0];
	private _deploymentPos = [0,0,0];
	{
		_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
		_deploymentPos = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
		if ((_deploymentPos distance _origin) < _dist) then {
			_dist = _deploymentPos distance _origin;
			_nearest = _deploymentPos;
		};
	} forEach _deploymentPositions;
	
	_deploymentPositions sort FALSE;
	localNamespace setVariable ['QS_deploymentMenu_filtered',_deploymentPositions];
	missionNamespace setVariable ['QS_deploymentMenu_update',TRUE,FALSE];
	private _listcount = 0;
	
	private _lbText = '';
	{	
		_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
		_lbText = call _codeDisplayName;
		if ((call _deploymentTickets) isNotEqualTo -1) then {
			_lbText = _lbText + ' ' + (format [localize 'STR_QS_Menu_212',call _deploymentTickets]);
		};
		_ctrlListbox lbAdd _lbText;
		_listcount = _listcount + 1;
	} forEach _deploymentPositions;
	openMap [TRUE,TRUE];
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) isNotEqualTo []) then {
		{
			_display displayRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers',[]];
	};
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]) isNotEqualTo []) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers2',[]];
	};
	((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,[worldSize / 2,worldSize / 2,0]];
	ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
	0 spawn {uiSleep 1;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
	_deploymentKeyDown = _display displayAddEventHandler [
		'KeyDown',
		{
			params ['_d','_key','_shift','_ctrl','_alt'];
			if (!(localNamespace getVariable ['QS_deploymentMenu_opened',FALSE])) exitWith {
				openMap [FALSE,FALSE];
				_d displayRemoveEventHandler [_thisEvent,_thisEventHandler];
				_d closeDisplay 2;
			};
			if (
				(_key in (actionKeys 'ingamepause')) &&
				(!(localNamespace getVariable ['QS_deploymentMenu_forceDeploy',FALSE]))
			) exitWith {
				openMap [FALSE,FALSE];
				_d displayRemoveEventHandler [_thisEvent,_thisEventHandler];
				_d closeDisplay 2;
			};
		}
	];
	(uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) pushBack ['KeyDown',_deploymentKeyDown];
	uiNamespace setVariable [
		'QS_deploymentMenu_selectorIcons',
		[
			'selector_selectedMission' call BIS_fnc_textureMarker,
			'selector_selectable' call BIS_fnc_textureMarker,
			'selector_selectedEnemy' call BIS_fnc_textureMarker
		]
	];
	if (!(localNamespace getVariable ['QS_deployment_drawInit',FALSE])) then {
		// For some reason we cant just simply remove this event when map closes, so we add it once
		localNamespace setVariable ['QS_deployment_drawInit',TRUE];
		((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['Draw',{call QS_fnc_deploymentDraw}];
	};
	_cancel = {
		(
			!visibleMap ||
			(isNull (findDisplay 23000)) ||
			(!alive player)
		)
	};
	private _selectedData = [];
	private _forcedSelection = localNamespace getVariable ['QS_deploymentMenu_forceDeploy',FALSE];
	private _uiTime = diag_tickTime;
	localNamespace setVariable ['QS_deploymentMenu_deployed',FALSE];
	localNamespace setVariable ['QS_deploymentMenu_timeout',diag_tickTime + 120];
	if (_forcedSelection) then {
		_ctrlExit ctrlEnable FALSE;
	};
	private _selectCooldown = -1;
	private _menuDeploymentPosition = [0,0,0];
	private _menuDeploymentRadius = 300;
	private _selectedTickets = -1;
	private _canSetAsHome = {FALSE};
	private _deploymentEnabled = {FALSE};
	private _firstRun = TRUE;
	for '_z' from 0 to 1 step 0 do {
		_uiTime = diag_tickTime;
		_home = localNamespace getVariable ['QS_deployment_home',''];
		if (call _cancel) exitWith {};
		if (missionNamespace getVariable ['QS_deploymentMenu_update',FALSE]) then {
			missionNamespace setVariable ['QS_deploymentMenu_update',FALSE,FALSE];
			_selectCooldown = _uiTime + 3;
			_deploymentPositions = (missionNamespace getVariable ['QS_system_deployments',[]]) select {
				_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
				(
					(_side in _arrayfactions) &&
					(_x call _codeConditionAddToMenu)
				)
			};
			_deploymentPositions sort FALSE;
			localNamespace setVariable ['QS_deploymentMenu_filtered',_deploymentPositions];
			_selectedData = uiNamespace getVariable ['QS_client_menuDeployment_selectedData',[]];
			_selectedData params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
			_selectedTickets = _selectedData call _deploymentTickets;			
			lbClear _ctrlListbox;
			private _listcount = 0;
			_lbText = '';
			{	
				_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
				_lbText = call _codeDisplayName;
				if ((_x call _deploymentTickets) isNotEqualTo -1) then {
					_lbText = _lbText + ' ' + (format [localize 'STR_QS_Menu_212',_x call _deploymentTickets]);
				};
				_ctrlListbox lbAdd _lbText;
				_listcount = _listcount + 1;
			} forEach _deploymentPositions;
		};
		if (
			_firstRun ||
			(
				((lbCurSel _ctrlListbox) isNotEqualTo -1) &&
				((uiNamespace getVariable ['QS_client_menuDeployment_selectedIndex',-1]) isNotEqualTo (lbCurSel _ctrlListbox))
			)
		) then {
			{
				uiNamespace setVariable _x;
			} forEach [
				['QS_client_menuDeployment_selectedIndex',(lbCurSel _ctrlListbox)],
				['QS_client_menuDeployment_selectedData',_deploymentPositions # (lbCurSel _ctrlListbox)]
			];
			if (_firstRun) then {
				//_ctrlListbox lbSetCurSel 0;
			};
			_selectedData = uiNamespace getVariable ['QS_client_menuDeployment_selectedData',[]];
			_selectedData params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
			if (!_firstRun) then {
				_selectedData call _codeOnMenuSelect;
			};
			_selectedTickets = _selectedData call _deploymentTickets;
			_menuDeploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
			_menuDeploymentRadius = _deploymentMinRadius;
			_canSetAsHome = _codeCanSetAsHome;
			_deploymentEnabled = _codeEnabled;
			if (_home isEqualTo _deploymentId) then {
				if (!cbChecked _ctrlHome) then {
					_ctrlHome cbSetChecked TRUE;
				};
			} else {
				if (cbChecked _ctrlHome) then {
					_ctrlHome cbSetChecked FALSE;
				};
			};
			_selectCooldown = _uiTime + 1;
			_firstRun = FALSE;
		};
		if (_uiTime > (localNamespace getVariable ['QS_deploymentMenu_timeout',-1])) exitWith {
			(findDisplay 23000) closeDisplay 2;
		};
		_ctrlSelect ctrlEnable (
			!_firstRun &&
			{(_uiTime > _selectCooldown)} &&
			{(_deploymentPositions isNotEqualTo [])} &&
			{((_origin distance _menuDeploymentPosition) > _menuDeploymentRadius)} &&
			{(_selectedData call _deploymentEnabled)} &&
			{((_selectedTickets isEqualTo -1) || (_selectedTickets > 0))}
		);
		_ctrlHome ctrlEnable (
			_homeEnabled &&
			{(ctrlEnabled _ctrlSelect)} &&
			{(_selectedData call _canSetAsHome)} &&
			{(_selectedData call _deploymentEnabled)}
		);
		uiSleep (diag_deltaTime * 3);
	};
	player setVariable ['QS_client_downedPosition',[-5000,-5000,0],FALSE];
	localNamespace setVariable ['QS_deploymentMenu_opened',FALSE];
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) isNotEqualTo []) then {
		{
			_display displayRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers',[]];
	};
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]) isNotEqualTo []) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers2',[]];
	};
};
if (_mode isEqualTo 'onUnload') exitWith {
	player setVariable ['QS_client_downedPosition',[-5000,-5000,0],FALSE];
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) isNotEqualTo []) then {
		{
			(findDisplay 23000) displayRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers',[]];
	};
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]) isNotEqualTo []) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers2',[]];
	};
	openMap [FALSE,FALSE];
	if (
		(localNamespace getVariable ['QS_deploymentMenu_forceDeploy',FALSE]) &&
		(!(localNamespace getVariable ['QS_deploymentMenu_deployed',FALSE]))
	) then {
		comment 'FORCE A DEPLOYMENT';
		openMap [TRUE,TRUE];
		(findDisplay 12) createDisplay 'QS_RD_client_dialog_menu_deployment';
	};
};
if (_mode isEqualTo 'Button_1') exitWith {
	_selectedData = uiNamespace getVariable ['QS_client_menuDeployment_selectedData',[]];
	_selectedData params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
	if (!(_selectedData call _codeConditionDeploy)) exitWith {};
	localNamespace setVariable ['QS_deploymentMenu_deployed',TRUE];
	_selectedData call _codeOnDeploy;
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) isNotEqualTo []) then {
		{
			(findDisplay 23000) displayRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers',[]];
	};
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]) isNotEqualTo []) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers2',[]];
	};
	(findDisplay 23000) closeDisplay 2;
	if (visibleMap) then {
		openMap [FALSE,FALSE];
	};
};
if (_mode isEqualTo 'Button_2') exitWith {
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]) isNotEqualTo []) then {
		{
			(findDisplay 23000) displayRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers',[]];
	};
	if ((uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]) isNotEqualTo []) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler _x;
		} forEach (uiNamespace getVariable ['QS_deploymentMenu_eventHandlers2',[]]);
		uiNamespace setVariable ['QS_deploymentMenu_eventHandlers2',[]];
	};
	(findDisplay 23000) closeDisplay 2;
	openMap [TRUE,FALSE];
};
if (_mode isEqualTo 'HomeCheckbox') exitWith {
	params ['','','_state'];
	_selectedData = uiNamespace getVariable ['QS_client_menuDeployment_selectedData',[]];
	_selectedData params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
	if (_state isEqualTo 1) then {
		comment 'ON';
		if (_selectedData call _codeCanSetAsHome) then {
			localNamespace setVariable ['QS_deployment_home',_deploymentId];
			missionProfileNamespace setVariable ['QS_deployment_home',_deploymentId];
			50 cutText [localize 'STR_QS_Text_419','PLAIN DOWN',0.333];
		};
	} else {
		comment 'OFF';
		localNamespace setVariable ['QS_deployment_home',''];
		missionProfileNamespace setVariable ['QS_deployment_home',''];
		50 cutText [localize 'STR_QS_Text_420','PLAIN DOWN',0.333];
	};
	saveMissionProfileNamespace;
};