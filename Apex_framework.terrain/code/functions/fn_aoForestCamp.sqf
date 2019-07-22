/*
File: fn_aoForestCamp.sqf
Author: 

	Quiksilver

Last Modified:

	22/07/2019 A3 1.94 by Quiksilver

Description:

	AO Jungle Camp
_________________________________________________*/

params ['_centerpos'];
private ['_position','_return','_sentryType','_patrolGroup'];
diag_log '****************************************************';
diag_log '***** AO COMPOSITION ***** Spawning jungle camp ****';
diag_log '****************************************************';
_hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
_baseMarker = markerPos 'QS_marker_base_marker';
private _isFound = FALSE;
for '_x' from 0 to 99 step 1 do {
	_position = ['RADIUS',_centerpos,((missionNamespace getVariable 'QS_aoSize') * 1),'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[_centerpos,300,'(1 + forest) * (1 - houses)',15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_position distance2D _baseMarker) > 500) then {
		if ((_position distance2D _hqPos) > 150) then {
			if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 10) then {
				if ((((_position select [0,2]) nearRoads 50) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
					if (((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 50)}) isEqualTo -1) then {
						_isFound = TRUE;
					};
				};
			};
		};
	};
	if (_isFound) exitWith {};
};
_return = [_position,(random 360),([] call (missionNamespace getVariable 'QS_data_forestCamp'))] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
{
	if (((getPosATL _x) select 2) > 0.05) then {
		_x setPosATL [((getPosATL _x) select 0),((getPosATL _x) select 1),0];
	};
} count _return;
_sentryType = selectRandomWeighted ['HAF_InfSentry',1,'IG_SniperTeam_M',1];
if (worldName isEqualTo 'Tanoa') then {
	_sentryType = selectRandomWeighted ['IG_InfSentry',1,'IG_ReconSentry',1];
};
if (worldName isEqualTo 'Enoch') then {
	_sentryType = selectRandomWeighted ['I_E_InfSentry',1,'I_L_CriminalSentry',1];
};
_patrolGroup = [_position,(random 360),RESISTANCE,_sentryType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[(units _patrolGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _return pushBack _x;
	if ((random 1) > 0.5) then {
		_x setUnitPos 'Middle';
		_x disableAI 'PATH';
	};
} count (units _patrolGroup);
_patrolGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
for '_x' from 0 to 1 step 1 do {
	_patrolGroup = [_position,(random 360),RESISTANCE,_sentryType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_patrolGroup enableAttack TRUE;
	_patrolGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _return pushBack _x;
	} count (units _patrolGroup);
};
missionNamespace setVariable ['QS_enemyJungleCamp_array',_return,FALSE];
_return;