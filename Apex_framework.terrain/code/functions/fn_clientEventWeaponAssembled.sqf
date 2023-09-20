/*/
File: fn_clientEventWeaponAssembled.sqf
Author: 

	Quiksilver
	
Last modified:

	20/09/2023 A3 2.14 by Quiksilver
	
Description:

	Weapon Assembled Event
___________________________________________________/*/

params ['_player','_weapon'];
_this spawn {
	params ['_player','_weapon'];
	_t = diag_tickTime + 2;
	waitUntil {
		uiSleep 0.1;
		((!isNull _weapon) || {(diag_tickTime > _t)})
	};
	if (!isNull _weapon) then {
		_weapon setVariable ['QS_weapon_assembler',clientOwner,TRUE];
		_weapon setVariable ['QS_weapon_assemblyEnabled',TRUE,TRUE];
		if (alive _weapon) then {
			if ((_weapon isKindOf 'StaticWeapon') || {(_weapon isKindOf 'StaticMortar')}) then {
				_weapon setVariable ['QS_RD_draggable',TRUE,TRUE];
				_weapon enableVehicleCargo TRUE;
				if (_weapon isKindOf 'StaticWeapon') then {
					_weapon disableTIEquipment TRUE;
					player setVariable ['QS_client_assembledWeapons',((player getVariable 'QS_client_assembledWeapons') + [_weapon]),FALSE];
				};
				if (_weapon isKindOf 'StaticMortar') then {
					private _array = [];
					private _mortarMagsToRemove = 1;
					{
						_magazineType = _x # 0;
						_turret = _x # 1;
						if ((toLowerANSI _magazineType) in ['8rnd_82mm_mo_smoke_white']) then {
							_array pushBack [_magazineType,_turret];
						} else {
							if ((toLowerANSI _magazineType) in ['8rnd_82mm_mo_shells']) then {
								if (_mortarMagsToRemove > 0) then {
									_mortarMagsToRemove = _mortarMagsToRemove - 1;
									_array pushBack [_magazineType,_turret];
								};
							};
						};
					} forEach (magazinesAllTurrets _weapon);
					if (_array isNotEqualTo []) then {
						{
							_weapon removeMagazineTurret _x;
						} forEach _array;
					};
				};
				if (_weapon isKindOf 'AA_01_base_F') then {
					for '_i' from 0 to 5 step 1 do {
						_weapon addMagazineTurret ['1Rnd_GAA_missiles',[0]];
					};
				};
				if (_weapon isKindOf 'AT_01_base_F') then {
					for '_i' from 0 to 5 step 1 do {
						_weapon addMagazineTurret ['1Rnd_GAT_missiles',[0]];
					};
				};
			} else {
				if (unitIsUAV _weapon) then {
					if ((['medical',(typeOf _weapon),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',(typeOf _weapon),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
						_weapon setVariable ['QS_medicalVehicle_reviveTickets',0,TRUE];
					};
					_weapon setVariable ['QS_RD_recruitable',TRUE,TRUE];
					_weapon setVariable ['QS_logistics',TRUE,TRUE];
					_weapon setVehicleReportRemoteTargets TRUE;
					_weapon setVehicleReceiveRemoteTargets FALSE;
					_weapon enableAIFeature ['LIGHTS',FALSE];
					_ugvCargoDisable = {
						params ['_parentVehicle','_cargoVehicle'];
						_displayName = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cargoVehicle)],
							{getText ((configOf _cargoVehicle) >> 'displayName')},
							TRUE
						];
						[_cargoVehicle,_displayName] spawn {
							params ['_cargoVehicle','_displayName'];
							waitUntil {
								(cameraOn isNotEqualTo _cargoVehicle)
							};
							deleteVehicleCrew _cargoVehicle;
							_cargoVehicle engineOn FALSE;
							50 cutText [format [localize 'STR_QS_Text_317',_displayName],'PLAIN DOWN',0.75];
						};
					};
					_ugvCargoEnable = {
						params ['_parentVehicle','_cargoVehicle'];
						createVehicleCrew _cargoVehicle;
					};
					_weapon addEventHandler ['CargoLoaded',_ugvCargoDisable];
					_weapon addEventHandler ['CargoUnloaded',_ugvCargoEnable];
					if (_weapon isKindOf 'Air') then {
						_weapon flyInHeight 5;
						_weapon flyInHeightASL [5,5,5];
						_customUpText = [
							actionKeysNames ['User18',1] trim ['"',0],
							localize 'STR_QS_Text_367'
						] select ((actionKeysNamesArray 'User18') isEqualTo []);
						_customDownText = [
							actionKeysNames ['User17',1] trim ['"',0],
							localize 'STR_QS_Text_366'
						] select ((actionKeysNamesArray 'User17') isEqualTo []);
						_text = format [
							'<t align="left">%4</t><t align="right">[%1] [%7]</t><br/><br/><t align="left">%5</t><t align="right">[%2] [%8]</t><br/><br/><t align="left">%6</t><t align="right">[%3]</t>',
							(actionKeysNames 'gunElevUp') trim ['"',0],
							(actionKeysNames 'gunElevDown') trim ['"',0],
							(actionKeysNames 'vehicleTurbo') trim ['"',0],
							(localize 'STR_QS_Hints_147'),
							(localize 'STR_QS_Hints_148'),
							(localize 'STR_QS_Hints_149'),
							_customUpText,
							_customDownText
						];
						[_text,TRUE,TRUE,localize 'STR_QS_Hints_150',TRUE] call QS_fnc_hint;
					};
					_weapon spawn {
						uiSleep 1;
						if ((crew _this) isNotEqualTo []) then {
							if (player isEqualTo (leader (group player))) then {

							};
							(group (driver _this)) setVariable ['QS_HComm_grp',FALSE,TRUE];
							{
								_x setName ['AI','AI','AI'];
								_x setVariable ['QS_RD_recruitable',TRUE,TRUE];
							} forEach (crew _this);
						};
					};
					player setVariable ['QS_client_assembledWeapons',((player getVariable 'QS_client_assembledWeapons') + [_weapon]),FALSE];
				};
			};
		};
	};
	[player,_weapon,FALSE,TRUE] call QS_fnc_unloadCargoPlacementMode;
};