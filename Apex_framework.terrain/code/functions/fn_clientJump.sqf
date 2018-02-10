/*
File: fn_clientJump.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/08/2016 A3 1.62 by Quiksilver

Description:

	-
__________________________________________________________*/

private _r = FALSE;
if ((speed player) > 4) then {
	if (isNull (objectParent player)) then {
		if (player getVariable ['jump',TRUE]) then {
			if (isTouchingGround player) then {
				if ((stance player) isEqualTo 'STAND') then {
					if (!((animationState player) in ['aovrpercmrunsraswrfldf'])) then {
						if (!((currentWeapon player) isEqualTo '')) then {
							player setvariable['QS_jumpKey',TRUE,FALSE];
							player setvariable ['jump',FALSE];
							_height = 6 - ((load player) * 10);
							_vel = velocity player;
							_dir = getDir player;
							_speed = 0.4;
							_max_height = 4.5;
							if (_height > _max_height) then {_height = _max_height};
							private _allPlayers = allPlayers select {((_x distance2D player) < 100)};
							_allPlayers = _allPlayers - [player];
							player setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+(cos _dir*_speed),((_vel select 2)+_height)];
							player switchMove 'AovrPercMrunSrasWrflDf';
							['switchMove',player,'AovrPercMrunSrasWrflDf'] remoteExec ['QS_fnc_remoteExecCmd',_allPlayers,FALSE];
							player spawn {
								uiSleep 0.5;
								_this setvariable ['jump',TRUE,FALSE];
							};
							_r = TRUE;
						};
					};
				};
			};
		};
	};
};
if (player getVariable ['QS_jumpKey',TRUE]) exitWith {
	player setVariable['QS_jumpKey',FALSE,FALSE]; 
	_key_delay  = 0.05;
	[_key_delay] spawn {
		uiSleep (_this select 0);
		player setvariable['QS_jumpKey',TRUE,FALSE]; 
	};
	_r;
};
_r;