/*
File: fn_clientInteractOpenParachute.sqf
Author:

	Quiksilver
	
Last Modified:

	24/12/2022 A3 2.10 by Quiksilver
	
Description:

	Open Parachute Interaction
________________________________________________*/

if (diag_tickTime < (uiNamespace getVariable ['QS_client_openParachuteCooldown',-1])) exitWith {};
uiNamespace setVariable ['QS_client_openParachuteCooldown',diag_tickTime + 5];
_objectParent = objectParent player;
if (isNull _objectParent) then {
	_velocity = velocity player;
	_para = createVehicle [QS_core_classNames_steerableP,[-500 + (random 100),-500 + (random 100),500 + (random 100)]];
	_para setDir (getDir player);
	_para setPos (player modelToWorld [0,5,0]);
	player assignAsDriver _para;
	player moveInDriver _para;
	[_para,_velocity] spawn {
		params ['_para','_velocity'];
		for '_i' from 0 to 2 step 1 do {
			sleep 1;
			if (isTouchingGround _para) exitWith {};
			_para setVelocity _velocity;
		};
	};
} else {
	_position = getPosWorld _objectParent;
	_velocity = velocity _objectParent;
	_para = createVehicle [qs_core_classnames_vehicleparachute,_position];
	_para setPosWorld (_position vectorAdd [0,0,5]);
	_para allowDamage FALSE;
	_para setDir (getDir _objectParent);
	_objectParent attachTo [_para,[0,0,1]];
	_para setVelocity _velocity;
	[_para,_velocity] spawn {
		params ['_para','_velocity'];
		for '_i' from 0 to 2 step 1 do {
			sleep 1;
			if (isTouchingGround _para) exitWith {};
			_para setVelocity _velocity;
		};
	};
	[_objectParent,_para] spawn {
		params ['_objectparent','_para'];
		waitUntil {
			(
				(((getPos _objectparent) # 2) < 10) ||
				{(!alive _objectparent)} ||
				{(isNull (attachedTo _objectParent))}
			)
		};
		if (!isNull (attachedTo _objectParent)) then {
			detach _objectParent;
			sleep 1;
			deleteVehicle _para;
		};
	};
};