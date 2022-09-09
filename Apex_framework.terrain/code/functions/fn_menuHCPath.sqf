/*/
File: fn_menuHCPath.sqf
Author:

	Quiksilver
	
Last modified:

	10/04/2018 A3 1.82 by Quiksilver
	
Description:

	Alias of BIS_HC_path_menu
______________________________________________/*/

params ['_type','_pos','_is3D','_arraySelected','_add'];
if (_this isEqualType '') then {
	private _QS_hcSelected = hcSelected player;
	if ( _QS_hcSelected isNotEqualTo [] ) then {
		private _undefined = FALSE;
		_text = localize 'STR_QS_Text_226';
		_text1 = localize 'STR_QS_Text_227';
		if (_this isEqualTo 'SITREP') then {50 cutText [localize 'STR_QS_Text_228','PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_MOVE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_CYCLE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_SAD') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_GUARD') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_UNLOAD') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_LOAD') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_GETOUT') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_TYPE_GETIN') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'WP_COMBAT_STEALTH') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_COMBAT_DANGER') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_COMBAT_AWARE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_COMBAT_SAFE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_COMBAT_UNCHANGED') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'WP_COLUMN') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_STAG COLUMN') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_WEDGE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_ECH LEFT') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_ECH RIGHT') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_VEE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_LINE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_FILE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_DIAMOND') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_UNCHANGED') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'WP_SPEED_LIMITED') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_SPEED_NORMAL') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_SPEED_FULL') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WP_SPEED_UNCHANGED') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'WP_WAIT_NO') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_1MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_5MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_10MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_15MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_20MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_25MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_30MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_45MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_WAIT_60MIN') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		
		if (_this isEqualTo 'WP_CREATETASK') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (_this isEqualTo 'WP_CANCELWP') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'NEXTWP') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'CANCELWP') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'CANCELALLWP') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'OPENFIRE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'HOLDFIRE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'SPEED_LIMITED') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'SPEED_NORMAL') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'SPEED_FULL') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'COMBAT_STEALTH') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'COMBAT_DANGER') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'COMBAT_AWARE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'COMBAT_SAFE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		
		if (_this isEqualTo 'COLUMN') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'STAG COLUMN') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'WEDGE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'ECH LEFT') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'ECH RIGHT') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'VEE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'LINE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'FILE') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'DIAMOND') then {50 cutText [_text,'PLAIN DOWN',0.5,TRUE,FALSE];};
		if (_this isEqualTo 'UNCHANGED') then {50 cutText [_text1,'PLAIN DOWN',0.5,TRUE,FALSE];_undefined = TRUE;};
		if (!(_undefined)) then {
			playSound 'Click';
			_QS_hcSelectedOwners = _QS_hcSelected apply {(groupOwner _x)};
			[89,_this,profileName,_QS_hcSelected] remoteExec ['QS_fnc_remoteExec',_QS_hcSelectedOwners,FALSE];
		};
	};
} else {
	private _grp = grpNull;
	{
		_grp = _x;
		if (!(_add)) then {
			if ((waypoints _grp) isNotEqualTo []) then {
				for '_x' from 0 to ((count (waypoints _grp)) - 1) step 1 do {
					if ((waypoints _grp) isEqualTo []) exitWith {};
					deleteWaypoint ((waypoints _grp) # 0);
				};
			};
		};
		if ((count (waypoints _grp)) < 3) then {
			if ((_pos distance2D (leader _grp)) > 30) then {
				_increment = 5;
				_arrayElement = _arraySelected find _grp;
				_incrementX = _arrayElement % _increment;
				_incrementY = floor (_arrayElement / _increment);
				_waypointPosition = [
					((_pos # 0) + (_incrementX * _increment)),
					((_pos # 1) - (_incrementY * _increment)),
					(_pos # 2)
				];
				_wp = _grp addWaypoint [_waypointPosition,0];
				_wp setWaypointCompletionRadius 30;
				if (isPlayer (leader _grp)) then {
					_wp setWaypointStatements [
						'TRUE',
						'
							if (isDedicated) exitWith {};
							if (local this) then {
								_leader = leader (group this);
								if (player isEqualTo _leader) then {
									50 cutText [localize "STR_QS_Text_229","PLAIN DOWN",0.5,TRUE,FALSE];
								};
								deleteWaypoint [group this,currentWaypoint (group this)];
							} else {
								if (player isEqualTo (missionNamespace getVariable "QS_hc_Commander")) then {
									_text = format ["%1 ( %2 ) %4 %3",(groupID (group this)),profileName,(mapGridPosition this),localize "STR_QS_Chat_140"];
									systemChat _text;
								};
							};
						'
					];
					_leader = leader _grp;
					if (!(_add)) then {
						if (diag_tickTime > (_leader getVariable ['QS_HComm_ordersNotifInterval',-1])) then {
							[34,['hcTaskCreated',['','New orders']]] remoteExec ['QS_fnc_remoteExec',_leader,FALSE];
						};
						_leader setVariable ['QS_HComm_ordersNotifInterval',(diag_tickTime + 15),FALSE];
						[63,[5,[(format['%2 %1',profileName,localize 'STR_QS_Text_264']),'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_leader,FALSE];
					} else {
						[63,[5,[(format['%2 %1',profileName,localize 'STR_QS_Text_265']),'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_leader,FALSE];
					};
				};
			} else {
				50 cutText [localize 'STR_QS_Text_230','PLAIN DOWN',0.25,TRUE,FALSE];
			};
		} else {
			50 cutText [localize 'STR_QS_Text_231','PLAIN DOWN',0.25,TRUE,FALSE];
		};
	} forEach _arraySelected;
};