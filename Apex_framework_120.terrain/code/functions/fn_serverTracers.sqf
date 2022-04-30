/*/
File: fn_serverTracers.sqf
Author: 

	Quiksilver

Last Modified:

	25/09/2018 A3 1.84 by Quiksilver
	
Description:

	Give the units tracer mags when possible
__________________________________________________________/*/

scriptName 'QS Set Tracers';
params ['_pool'];
private _QS_newUnit = objNull;
private _QS_unit_side = sideEmpty;
private _QS_magazinesUnit = [];
private _QS_testMag = '';
private _QS_primaryWeaponMag = '';
{
	if (local _x) then {
		if (alive _x) then {
			if (isNil {_x getVariable 'QS_tracersAdded'}) then {
				_QS_newUnit = _x;
				_QS_newUnit setVariable ['QS_tracersAdded',TRUE,FALSE];
				_QS_unit_side = side _QS_newUnit;
				if (_QS_unit_side in [EAST,WEST,RESISTANCE]) then {
					_QS_magazinesUnit = magazines _QS_newUnit;
					{
						_QS_testMag = _QS_magazinesUnit select _forEachIndex;
						if (_QS_testMag isEqualTo '30Rnd_65x39_caseless_mag') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '30Rnd_65x39_caseless_mag_Tracer';
						};
						if (_QS_testMag isEqualTo '30Rnd_65x39_caseless_green') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '30Rnd_65x39_caseless_green_mag_Tracer';
						};
						if (_QS_testMag isEqualTo '30Rnd_556x45_Stanag') then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_556x45_Stanag_Tracer_Red';
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_556x45_Stanag_Tracer_Yellow';
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_556x45_Stanag_Tracer_Green';
							};
						};
						if (_QS_testMag isEqualTo '30Rnd_45ACP_Mag_SMG_01') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '30Rnd_45ACP_Mag_SMG_01_Tracer_Green';
						};
						if (_QS_testMag isEqualTo '200Rnd_65x39_cased_Box') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '200Rnd_65x39_cased_Box_Tracer';
						};
						if (_QS_testMag isEqualTo '150Rnd_762x51_Box') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '150Rnd_762x51_Box_Tracer';
						};
						if (_QS_testMag isEqualTo '150Rnd_762x54_Box') then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '150Rnd_762x54_Box_Tracer';
						};
						if (_QS_testMag in ['200Rnd_556x45_Box_F','200Rnd_556x45_Box_Red_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '200Rnd_556x45_Box_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '200Rnd_556x45_Box_Tracer_Red_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '200Rnd_556x45_Box_Tracer_F';
							};
						};
						if (_QS_testMag in ['30Rnd_545x39_Mag_F','30Rnd_545x39_Mag_Green_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_545x39_Mag_Tracer_Green_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_545x39_Mag_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_545x39_Mag_Tracer_Green_F';
							};
						};
						if (_QS_testMag in ['30Rnd_580x42_Mag_F']) then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '30Rnd_580x42_Mag_Tracer_F';
						};
						if (_QS_testMag in ['100Rnd_580x42_Mag_F']) then {
							_QS_newUnit removeMagazine _QS_testMag;
							_QS_newUnit addMagazine '100Rnd_580x42_Mag_Tracer_F';
						};
						if (_QS_testMag in ['30Rnd_762x39_Mag_F','30Rnd_762x39_Mag_Green_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_762x39_Mag_Tracer_Green_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_762x39_Mag_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removeMagazine _QS_testMag;
								_QS_newUnit addMagazine '30Rnd_762x39_Mag_Tracer_Green_F';
							};
						};						
					} forEach _QS_magazinesUnit;	
					if (!((primaryWeaponMagazine _QS_newUnit) isEqualTo [])) then {
						_QS_primaryWeaponMag = (primaryWeaponMagazine _QS_newUnit) select 0;
						if (_QS_primaryWeaponMag isEqualTo '30Rnd_65x39_caseless_mag') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '30Rnd_65x39_caseless_mag_Tracer';
						};
						if (_QS_primaryWeaponMag isEqualTo '30Rnd_65x39_caseless_green') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '30Rnd_65x39_caseless_green_mag_Tracer';
						};
						if (_QS_primaryWeaponMag isEqualTo '30Rnd_556x45_Stanag') then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_556x45_Stanag_Tracer_Red';
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_556x45_Stanag_Tracer_Yellow';
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_556x45_Stanag_Tracer_Green';
							};
						};
						if (_QS_primaryWeaponMag isEqualTo '30Rnd_45ACP_Mag_SMG_01') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '30Rnd_45ACP_Mag_SMG_01_Tracer_Green';
						};
						if (_QS_primaryWeaponMag isEqualTo '200Rnd_65x39_cased_Box') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '200Rnd_65x39_cased_Box_Tracer';
						};
						if (_QS_primaryWeaponMag isEqualTo '150Rnd_762x51_Box') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '150Rnd_762x51_Box_Tracer';
						};
						if (_QS_primaryWeaponMag isEqualTo '150Rnd_762x54_Box') then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '150Rnd_762x54_Box_Tracer';
						};
						
						if (_QS_primaryWeaponMag in ['200Rnd_556x45_Box_F','200Rnd_556x45_Box_Red_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '200Rnd_556x45_Box_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '200Rnd_556x45_Box_Tracer_Red_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '200Rnd_556x45_Box_Tracer_F';
							};
						};
						
						if (_QS_primaryWeaponMag in ['30Rnd_545x39_Mag_F','30Rnd_545x39_Mag_Green_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_545x39_Mag_Tracer_Green_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_545x39_Mag_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_545x39_Mag_Tracer_Green_F';
							};
						};						
						if (_QS_primaryWeaponMag in ['30Rnd_580x42_Mag_F']) then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '30Rnd_580x42_Mag_Tracer_F';
						};
						if (_QS_primaryWeaponMag in ['100Rnd_580x42_Mag_F']) then {
							_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
							_QS_newUnit addPrimaryWeaponItem '100Rnd_580x42_Mag_Tracer_F';
						};
						if (_QS_primaryWeaponMag in ['30Rnd_762x39_Mag_F','30Rnd_762x39_Mag_Green_F']) then {
							if (_QS_unit_side isEqualTo EAST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_762x39_Mag_Tracer_Green_F';							
							};
							if (_QS_unit_side isEqualTo WEST) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_762x39_Mag_Tracer_F';							
							};
							if (_QS_unit_side isEqualTo RESISTANCE) then {
								_QS_newUnit removePrimaryWeaponItem _QS_primaryWeaponMag;
								_QS_newUnit addPrimaryWeaponItem '30Rnd_762x39_Mag_Tracer_Green_F';
							};
						};
					};
				};
			};
		};
	};
	sleep 0.05;
} count _pool;