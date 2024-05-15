/*/
File: fn_clientInteractSpawnAsset.sqf
Author:

	Quiksilver

Last modified:

	25/11/2023 A3 2.14 by Quiksilver
	
Description:

	Spawn Asset
___________________________________________________/*/

QS_fnc_clientInteractSpawnAsset = {
	(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	_enemySides = QS_player call QS_fnc_enemySides;
	if (
		(
			(!(_inSafezone)) ||
			(_inSafezone && _safezoneActive && (_safezoneLevel < 2))
		) &&
		(((flatten (_enemySides apply {units _x})) inAreaArray [QS_player,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isNotEqualTo [])
	) exitWith {
		50 cutText [localize 'STR_QS_Text_489','PLAIN DOWN',0.5];
		FALSE;
	};
	QS_managed_spawnedVehicles_public = QS_managed_spawnedVehicles_public select {alive _x};
	if ((count QS_managed_spawnedVehicles_public) >= QS_managed_spawnedVehicles_maxCap) exitWith {
		comment 'Vehicle spawner global cap exceeded';
		closeDialog 2;
		50 cutText [
			(format [localize 'STR_QS_Text_488',QS_managed_spawnedVehicles_maxCap]),
			'PLAIN DOWN',
			1	
		];
	};
	_conditionCancel = {
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		(
			(!((lifeState QS_player) in ['HEALTHY','INJURED'])) ||
			{(!isNull (objectParent QS_player))} ||
			{(isNull _cursorObject)} ||
			{(isNull (_cursorObject getVariable ['QS_vehicleSpawnPad',objNull]))}
		)
	};
	_onCompleted = {
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
		_enemySides = QS_player call QS_fnc_enemySides;
		if (
			(
				(!(_inSafezone)) ||
				(_inSafezone && _safezoneActive && (_safezoneLevel < 2))
			) &&
			(((flatten (_enemySides apply {units _x})) inAreaArray [QS_player,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isNotEqualTo [])
		) exitWith {
			50 cutText [localize 'STR_QS_Text_454','PLAIN DOWN',0.5];
			FALSE;
		};
		createDialog 'QS_RD_client_dialog_menu_assetSpawner';
	};
	[
		localize 'STR_QS_Interact_149',
		5,
		0,
		[[],{FALSE}],
		[[],_conditionCancel],
		[[],_onCompleted],
		[[],{FALSE}],
		FALSE,
		1,
		['']
	] spawn QS_fnc_clientProgressVisualization;
};