/*
File: fn_clientJump.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/05/2019 A3 1.92 by Quiksilver

Description:

	-
_____________________________________*/

private _r = FALSE;
if (((vectorMagnitude (velocity player)) * 3.6) > 4) then {
	if (isNull (objectParent player)) then {
		if (diag_tickTime > (player getVariable ['QS_jumpCooldown',0])) then {
			if (isTouchingGround player) then {
				if ((stance player) isEqualTo 'STAND') then {
					if (!((animationState player) in ['aovrpercmrunsraswrfldf'])) then {
						if (!((currentWeapon player) isEqualTo '')) then {
							player setVariable ['QS_jumpCooldown',(diag_tickTime + 0.5),FALSE];
							_height = (6 - ((load player) * 10)) min 4.5;
							_vel = velocity player;
							_dir = getDir player;
							_speed = 0.4;
							player setVelocity [(_vel # 0)+(sin _dir*_speed),(_vel # 1)+(cos _dir*_speed),((_vel # 2)+_height)];
							private _allPlayers = allPlayers inAreaArray [(getPosATL player),100,100,0,FALSE];
							_allPlayers = _allPlayers - [player];
							player switchMove 'AovrPercMrunSrasWrflDf';
							if (!(_allPlayers isEqualTo [])) then {
								if (isNil {uiNamespace getVariable 'QS_client_jumpAnimPropagation'}) then {
									uiNamespace setVariable ['QS_client_jumpAnimPropagation',[]];
								};
								uiNamespace setVariable ['QS_client_jumpAnimPropagation',((uiNamespace getVariable 'QS_client_jumpAnimPropagation') select {(_x > (diag_tickTime - 30))})];
								if ((count (uiNamespace getVariable 'QS_client_jumpAnimPropagation')) < 3) then {
									(uiNamespace getVariable 'QS_client_jumpAnimPropagation') pushBack diag_tickTime;
									['switchMove',player,'AovrPercMrunSrasWrflDf'] remoteExec ['QS_fnc_remoteExecCmd',_allPlayers,FALSE];
								};
							};
							_r = TRUE;
						};
					};
				};
			};
		};
	};
};
_r;