[
	["Land_TTowerBig_2_F",[0,0,0],0,[],TRUE,TRUE,FALSE,{
		_tower = _this # 0;
		missionNamespace setVariable ['QS_virtualSectors_sub_2_obj',_tower,TRUE];
		missionNamespace setVariable ['QS_radioTower',_tower,FALSE];
		missionNamespace setVariable ['QS_radioTower_pos',(getPos _tower),FALSE];
		_tower setVariable ['QS_client_canAttachExp',TRUE,TRUE];
		_tower setVectorUp [0,0,1];
		_tower addEventHandler [
			'Killed',
			{
				params ['_entity','_killer','_instigator','_useEffects'];
				missionNamespace setVariable ['QS_virtualSectors_sub_2_active',FALSE,FALSE];
				if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
					{
						_x setMarkerAlpha 0;
					} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
				};
				['SC_SUB_COMPLETED',['',localize 'STR_QS_Notif_001']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				['QS_virtualSectors_sub_2_task'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
				if (!isNull _instigator) then {
					if (isPlayer _instigator) then {
						_name = name _instigator;
						if ((random 1) > 0.5) then {
							['sideChat',[WEST,'HQ'],(format ['%1 (%2) %3',_name,(groupID (group _instigator)),localize 'STR_QS_Chat_008'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						} else {
							['sideChat',[WEST,'HQ'],(format ['%1 (%2) %3',_name,(groupID (group _instigator)),localize 'STR_QS_Chat_009'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
						if ((!(_instigator getUnitTrait 'uavhacker')) && (!(_instigator getUnitTrait 'QS_trait_pilot')) && (!(_instigator getUnitTrait 'QS_trait_fighterPilot'))) then {
							(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TOWER',(getPlayerUID _instigator),(name _instigator),1];
						};
					};
				};
			}
		];
		_tower addEventHandler [
			'Deleted',
			{
				if (!(missionNamespace getVariable 'QS_virtualSectors_sub_2_active')) exitWith {};
				missionNamespace setVariable ['QS_virtualSectors_sub_2_active',FALSE,FALSE];
				if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
					{
						_x setMarkerAlpha 0;
					} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
				};
				['SC_SUB_COMPLETED',['',localize 'STR_QS_Notif_001']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				['QS_virtualSectors_sub_2_task'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
				if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
					private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
					_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
					_scoreEast = _QS_virtualSectors_scoreSides # 0;
					if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
						_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_subTask',0.05]);
						_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
						missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
					};
				};
			}
		];
		_tower;
	}],
	/*/["Land_Mil_WiredFenceD_F",[2.54395,0.0665283,-9.53674e-006],270.812,[],FALSE,FALSE,TRUE,{}], /*/
	/*/["Land_Mil_WiredFence_F",[-0.817139,-3.45349,-9.53674e-006],0.26024,[],FALSE,FALSE,TRUE,{}], /*/
	/*/["Land_Mil_WiredFence_F",[-1.02881,3.72083,-9.53674e-006],181.248,[],FALSE,FALSE,TRUE,{}], /*/
	/*/["Land_Mil_WiredFenceD_F",[-4.40942,0.292358,-9.53674e-006],90.1091,[],FALSE,FALSE,TRUE,{}], /*/
	["Land_Mil_WiredFence_F",[10.4266,-0.498657,-9.53674e-006],277.385,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_Gate_F",[-1.11218,10.856,0],181.208,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[-1.00781,-11.6039,-9.53674e-006],1.34126,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[-12.6104,-0.763794,-9.53674e-006],89.3085,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[10.114,-8.01233,-9.53674e-006],269.575,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[7.60046,10.6005,-9.53674e-006],181.202,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[11.0757,7.04248,-9.53674e-006],270.938,[],FALSE,FALSE,TRUE,{}],
	["Land_Mil_WiredFence_F",[6.70972,-11.6368,-9.53674e-006],359.781,[],FALSE,FALSE,TRUE,{}],
	["Land_Mil_WiredFence_F",[-9.68188,10.2443,-9.53674e-006],174.402,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFence_F",[-12.6646,6.61487,-9.53674e-006],91.1413,[],FALSE,FALSE,TRUE,{}], 
	["Land_Mil_WiredFenceD_F",[-9.1438,-11.6671,-9.53674e-006],1.43804,[],FALSE,FALSE,TRUE,{}],
	["Land_Mil_WiredFence_F",[-12.6783,-8.48669,-9.53674e-006],90.5004,[],FALSE,FALSE,TRUE,{}]
]