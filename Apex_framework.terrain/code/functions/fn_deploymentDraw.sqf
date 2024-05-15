/*/
File: fn_deploymentDraw.sqf
Author:
	
	Quiksilver
	
Last Modified:

	16/04/2023 A3 2.12 by Quiksilver
	
Description:

	Deployment Draw event
____________________________________________/*/

if (!isGameFocused || isGamePaused) exitWith {};
_m = _this # 0;
if (
	(isNull (findDisplay 23000)) ||
	(!(localNamespace getVariable ['QS_deploymentMenu_opened',FALSE]))
) exitWith {};
(uiNamespace getVariable ['QS_deploymentMenu_selectorIcons',[]]) params ['_iconSelected','_iconSelectable','_iconSelectedEnemy'];
_selectedIndex = uiNamespace getVariable ['QS_client_menuDeployment_selectedIndex',0];
private _pos = [0,0,0];
_enemysides = QS_player call QS_fnc_enemySides;
private _isNearbyEnemies = [];
private _usedMapIcon = '';
{
	_x params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
	_menuDeploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
	_usedMapIcon = _mapIcon;
	_isNearbyEnemies = ((flatten (_enemysides apply {units _x})) inAreaArray [_menuDeploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius]) isNotEqualTo [];
	if (_forEachIndex isEqualTo _selectedIndex) then {
		_m drawIcon [
			[_iconSelected,_mapIcon] select (_mapIcon isNotEqualTo ''),
			[[1,1,1,1],[1,0.5,0.5,1]] select _isNearbyEnemies,
			_menuDeploymentPosition,
			48,
			48,
			diag_tickTime * 60
		];
	} else {
		_m drawIcon [
			[_iconSelectable,_mapIcon] select (_mapIcon isNotEqualTo ''),
			[[0.75,0.75,0.75,1],[1,0.5,0.5,1]] select _isNearbyEnemies,
			_menuDeploymentPosition,
			36,
			36,
			diag_tickTime * 30
		];
	};
} forEach (localNamespace getVariable ['QS_deploymentMenu_filtered',[]]);