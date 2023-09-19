/*
File: fn_clientEventKeyDown3.sqf
Author:
	
	Quiksilver
	
Last Modified:

	23/04/2023 A3 2.12 by Quiksilver

Description:

	Placement Key Down
______________________________________________*/

private _return = FALSE;
params ['','_key','_shift','_ctrl','_alt'];
if (missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]) then {
	if (_key in (actionKeys 'turretElevationUp')) then {
		if (
			_ctrl &&
			(uiNamespace getVariable ['QS_uiaction_sideShiftEnabled',FALSE])
		) then {
			_sideShift = uiNamespace getVariable ['QS_targetBoundingBox_xOffset',0];
			_sideShift = (_sideShift + ([0.1,0.3] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]))) min 1;
			uiNamespace setVariable ['QS_targetBoundingBox_xOffset',_sideShift];
		} else {
			if (uiNamespace getVariable ['QS_uiaction_rotationEnabled',TRUE]) then {
				_azimuth = uiNamespace getVariable ['QS_targetBoundingBox_azi',0];
				_azimuth = _azimuth + ([1,5] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
				uiNamespace setVariable ['QS_targetBoundingBox_azi',(_azimuth mod 360)];
			};
		};
	} else {
		if (_key in (actionKeys 'turretElevationDown')) then {
			if (
				_ctrl &&
				(uiNamespace getVariable ['QS_uiaction_sideShiftEnabled',FALSE])
			) then {
				_sideShift = uiNamespace getVariable ['QS_targetBoundingBox_xOffset',0];
				_sideShift = (_sideShift - ([0.1,0.3] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]))) max -1;
				uiNamespace setVariable ['QS_targetBoundingBox_xOffset',_sideShift];
			} else {
				if (uiNamespace getVariable ['QS_uiaction_rotationEnabled',TRUE]) then {
					_azimuth = uiNamespace getVariable ['QS_targetBoundingBox_azi',0];
					_azimuth = _azimuth - ([1,5] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
					uiNamespace setVariable ['QS_targetBoundingBox_azi',(_azimuth mod 360)];
				};
			};
		} else {
			if (_key in (actionKeys 'gunElevUp')) then {
				(uiNamespace getVariable ['QS_targetBoundingBox_bbox',[]]) params ['_p1','_p2','_radius'];
				(0 boundingBoxReal cameraOn) params ['','_q2',''];
				_maxZ = (cameraOn modelToWorld _q2) # 2;
				_upperBoundZ = (QS_targetBoundingBox_helper modelToWorld _p2) # 2;
				_lowerBoundZ = (QS_targetBoundingBox_helper modelToWorld _p1) # 2;
				_delta = [0.025,0.25] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
				_newElev = (uiNamespace getVariable ['QS_targetBoundingBox_zOffset',0]) + _delta;	
				if ((_lowerBoundZ + _delta) < _maxZ) then {
					uiNamespace setVariable ['QS_targetBoundingBox_zOffset',_newElev];
				};
			} else {
				if (_key in (actionKeys 'gunElevDown')) then {
					(0 boundingBoxReal QS_targetBoundingBox_helper) params ['_p1','_p2','_radius'];
					(0 boundingBoxReal cameraOn) params ['_q1','',''];
					_minZ = (cameraOn modelToWorld _q1) # 2;
					_upperBoundZ = (QS_targetBoundingBox_helper modelToWorld _p2) # 2;
					_lowerBoundZ = (QS_targetBoundingBox_helper modelToWorld _p1) # 2;
					_sim = QS_hashmap_configfile get (format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf QS_targetBoundingBox_helper)]);
					_isThing = (_sim in ['thingx','tankx','helicopterrtd']) || ((['LandVehicle','Air','Ship'] findIf { QS_targetBoundingBox_helper isKindOf _x }) isNotEqualTo -1);
					_delta = [0.025,0.25] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
					_newElev = (uiNamespace getVariable ['QS_targetBoundingBox_zOffset',0]) - _delta;
					if (
						((_isThing) && (_minZ < (_lowerBoundZ - _delta))) ||
						{((!(_isThing)) && (_minZ < (_upperBoundZ - _delta)))}
					) then {
						uiNamespace setVariable ['QS_targetBoundingBox_zOffset',_newElev];
					};
				};
			};
		};
	};
	if (_ctrl) then {
		uiNamespace setVariable ['QS_uiaction_ctrl',_ctrl];
	};
	if (_key in (actionKeys 'ingamepause')) then {
		if (uiNamespace getVariable ['QS_localHelper',FALSE]) then {
			_return = TRUE;
			missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
		};
	};
	if (_key in 
		(
			(actionKeys 'SwitchPrimary') +
			(actionKeys 'SwitchHandgun') +
			(actionKeys 'SwitchSecondary') +
			(actionKeys 'SwitchWeaponGrp1') +
			(actionKeys 'SwitchWeaponGrp2') +
			(actionKeys 'SwitchWeaponGrp3') +
			(actionKeys 'SwitchWeaponGrp4') +
			(actionKeys 'nextWeapon') + 
			(actionKeys 'prevWeapon') + 
			(actionKeys 'switchWeapon') + 
			(actionKeys 'handgun') + 
			(actionKeys 'switchGunnerWeapon') +
			(actionKeys 'throw')
		)
	) then {
		_return = TRUE;
	};
};
_return;