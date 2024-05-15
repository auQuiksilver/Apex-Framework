/*/
File: fn_utilityOffroad.sqf
Author:

	Quiksilver - Credit: mindstorm, modified by Adanteh as original authors. This is a derivative function.
	http://forums.bistudio.com/showthread.php?157474-Offroad-Police-sirens-lights-and-underglow
	
Last modified:
	
	30/10/2023 A3 2.14 by Quiksilver
	
Description:

	Beacons
	
Notes:

	Some UAV drones also have beacons now (laws of war dlc)
_______________________________________________________/*/

if (isDedicated) exitWith {};
params ['_vehicle'];
_vehicleType = toLowerANSI (typeOf _vehicle);
private _isOffroad = ((_vehicle isKindOf 'offroad_01_repair_base_f') || ((_vehicle isKindOf 'offroad_01_base_f') && (((_vehicle animationPhase 'HideServices') isEqualTo 0) || ((_vehicle animationPhase 'HidePolice') isEqualTo 0))));
private _isPoliceBoat = _vehicleType in ['c_boat_civil_01_police_f'];
private _isAmbulance = ((_vehicle isKindOf 'van_02_medevac_base_f') || (_vehicleType in ['c_van_02_medevac_f','c_idap_van_02_medevac_f','b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f']));
private _isServicesVan = ((_vehicle isKindOf 'van_02_service_base_f') || (_vehicleType in ['c_van_02_service_f']));
if ((!(_isOffroad)) && (!(_isPoliceBoat)) && (!(_isAmbulance)) && (!(_isServicesVan))) exitWith {};
private _lightRed = [0,0,0];
private _lightBlue = [0,0,0];
private _attachPointL = [0,0,0];
private _attachPointR = [0,0,0];
private _deAnim = FALSE;
if (_isOffroad) then {
	_attachPointL = [-0.37,0,0.56];
	_attachPointR = [0.37,0,0.56];
	if ((_vehicle animationPhase 'hidePolice') isEqualTo 0) then {
		//comment 'Must be police';
		_lightRed = [1,0,0];
		_lightBlue = [0,0,1];
	} else {
		//comment 'Must be services';
		_lightRed = [1,0.41,0];
		_lightBlue = [1,0.41,0];
		_deAnim = TRUE;
		if (local _vehicle) then {
			_vehicle animate ['BeaconsServicesStart',1,1];
		};
	};
};
if (_isPoliceBoat) then {
	_attachPointL = [-0.3,-1,0.56];
	_attachPointR = [0.3,-1,0.56];
	_lightRed = [1,0,0];
	_lightBlue = [0,0,1];
};
if (_isAmbulance) then {
	_lightRed = [1,0,0];
	_lightBlue = [0,0,1];
	_attachPointL = [-0.5,1.5,1.1];
	_attachPointR = [0.5,1.5,1.1];
};
if (_isServicesVan) then {
	_lightRed = [1,0.41,0];
	_lightBlue = [1,0.41,0];
	_attachPointL = [-0.5,1.5,1.1];
	_attachPointR = [0.5,1.5,1.1];
};
_vehicle setVariable ['Utility_Offroad_Beacons',TRUE,TRUE];
private _lightleft = createVehicleLocal ['#lightpoint',getPosWorld _vehicle];
_lightleft hideObject TRUE;
uiSleep 0.2;
_lightleft setLightColor _lightRed; 
_lightleft setLightBrightness 0.2;  
_lightleft setLightAmbient _lightRed;
[1,_lightleft,[_vehicle,_attachPointL]] call QS_fnc_eventAttach;
_lightleft setLightAttenuation [0.181,0,1000,130]; 
_lightleft setLightIntensity 10;
_lightleft setLightFlareSize 0.38;
_lightleft setLightFlareMaxDistance 150;
_lightleft setLightUseFlare TRUE;
_lightleft setLightDayLight TRUE;
private _lightright = createVehicleLocal ['#lightpoint',getPosWorld _vehicle];
_lightright hideObject TRUE;
uiSleep 0.2;
_lightright setLightColor _lightBlue; 
_lightright setLightBrightness 0.2;  
_lightright setLightAmbient _lightBlue;
[1,_lightright,[_vehicle,_attachPointR]] call QS_fnc_eventAttach;
_lightright setLightAttenuation [0.181,0,1000,130]; 
_lightright setLightIntensity 10;
_lightright setLightFlareSize 0.38;
_lightright setLightFlareMaxDistance 150;
_lightright setLightUseFlare TRUE;
_lightright setLightDayLight TRUE;
private _leftRed = TRUE;
for '_i' from 0 to 1 step 0 do {
	if (
		(!alive _vehicle) ||
		{(!(_vehicle getVariable ['Utility_Offroad_Beacons',FALSE]))} ||
		{(_vehicle getVariable ['QS_logistics_wreck',FALSE])} ||
		{(_vehicle getVariable ['QS_logistics_packed',FALSE])}
	) exitWith {
		if (_vehicle getVariable ['Utility_Offroad_Beacons',FALSE]) then {
			_vehicle setVariable ['Utility_Offroad_Beacons',FALSE,TRUE];
		};
	};
	if (_leftRed) then {
		_leftRed = FALSE;
		_lightright setLightBrightness 0;
		uiSleep 0.1;
		_lightleft setLightBrightness 6;
	} else {
		_leftRed = TRUE;
		_lightleft setLightBrightness 0;
		uiSleep 0.1;
		_lightright setLightBrightness 6;
	};
	uiSleep 0.333;
};
if (
	_deAnim &&
	{_isOffroad} &&
	{(local _vehicle)} &&
	{((_vehicle animationPhase 'hideServices') isEqualTo 0)}
) then {
	_vehicle animate ['BeaconsServicesStart',0,1];
};
deleteVehicle [_lightleft,_lightright];