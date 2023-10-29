/*/
File: fn_clientEventSlotItemChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	29/10/2023 A3 2.14 by Quiksilver
	
Description:

	Slot Item Changed Event

Notes:

	unit: Object - unit EH assigned to.
	name: String - name of the item/weapon/container (see getSlotItemName).
	slot: Number - slot id (see getSlotItemName).
	assigned: Boolean - true assign action, false unassign action.
__________________________________________________/*/

params ['_unit','_name','_slot','_assigned'];
if ((backpack _unit) in ['B_CombinationUnitRespirator_01_F','B_SCBA_01_F']) then {
	if ((backpack _unit) isEqualTo 'B_CombinationUnitRespirator_01_F') then {
		(getObjectTextures (backpackContainer _unit)) params ['','_hose1','_hoseAPR','_hoseReg',''];
		if ((toLowerANSI (goggles _unit)) in [
			'g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f'
		]) then {
			if (_hose1 isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
				(backpackContainer _unit) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
			};
			if (_hoseAPR isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
				(backpackContainer _unit) setObjectTextureGlobal [2,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
			};
			if (_hoseReg isNotEqualTo '') then {
				(backpackContainer _unit) setObjectTextureGlobal [3,''];
			};
		} else {
			if ((toLowerANSI (goggles _unit)) in ['g_regulatormask_f']) then {
				if (_hose1 isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
					(backpackContainer _unit) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
				};
				if (_hoseAPR isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [2,''];
				};
				if (_hoseReg isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
					(backpackContainer _unit) setObjectTextureGlobal [3,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
				};
			} else {
				if (_hose1 isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [1,''];
				};
				if (_hoseAPR isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [2,''];
				};
				if (_hoseReg isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [3,''];
				};
			};
		};
	};
	if ((backpack _unit) isEqualTo 'B_SCBA_01_F') then {
		(getObjectTextures (backpackContainer _unit)) params ['','_hoseAPR','_hoseReg'];
		if ((toLowerANSI (goggles _unit)) in [
			'g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f'
		]) then {
			if (_hoseAPR isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa') then {
				(backpackContainer _unit) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa'];
			};
			if (_hoseReg isNotEqualTo '') then {
				(backpackContainer _unit) setObjectTextureGlobal [2,''];
			};
		} else {
			if ((toLowerANSI (goggles _unit)) in ['g_regulatormask_f']) then {
				if (_hoseAPR isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [1,''];
				};
				if (_hoseReg isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa') then {
					(backpackContainer _unit) setObjectTextureGlobal [2,'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa'];
				};
			} else {
				if (_hoseAPR isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [1,''];
				};
				if (_hoseReg isNotEqualTo '') then {
					(backpackContainer _unit) setObjectTextureGlobal [2,''];
				};
			};
		};
	};
};