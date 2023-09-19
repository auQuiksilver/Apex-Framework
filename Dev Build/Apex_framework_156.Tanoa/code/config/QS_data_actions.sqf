/*/
File: QS_data_actions.sqf
Author:

	Quiksilver
	
Last modified:

	1/09/2022 A3 2.10 by Quiksilver
	
Description:

	Whitelisted addActions Text
___________________________________________/*/

[
	localize 'STR_QS_Interact_036',			// Sit
	localize 'STR_QS_Interact_066',			// Stand
	localize 'STR_QS_Interact_003',			// Escort
	localize 'STR_QS_Interact_004',			// Load
	localize 'STR_QS_Interact_037',			// Load cargo
	localize 'STR_QS_Interact_005',			// Unload
	localize 'STR_QS_Interact_038',			// Unload cargo
	localize 'STR_QS_Interact_006',			// Question civilian
	localize 'STR_QS_Interact_001',			// Drag
	localize 'STR_QS_Interact_002',			// Carry
	localize 'STR_QS_Interact_007',			// Command Follow
	localize 'STR_QS_Interact_008',			// Command Recruit
	localize 'STR_QS_Interact_009',			// Command Dismiss
	localize 'STR_QS_Interact_022',			// Command Surrender
	localize 'STR_QS_Interact_010',			// Release
	localize 'STR_QS_Interact_011',			// Respawn vehicle
	localize 'STR_QS_Interact_012',			// Open cargo doors
	localize 'STR_QS_Interact_013',			// Close cargo doors
	localize 'STR_QS_Interact_014',			// Service
	localize 'STR_QS_Interact_015',			// Unflip
	localize 'STR_QS_Interact_016',			// Revive
	localize 'STR_A3_Arsenal',				// Arsenal
	localize 'STR_QS_Interact_019',			// Beacons On
	localize 'STR_QS_Interact_020',			// Beacons Off
	localize 'STR_QS_Interact_021',			// Tow
	localize 'STR_QS_Interact_023',			// Rescue
	localize 'STR_QS_Interact_024',			// Secure
	localize 'STR_QS_Interact_026',			// Turret safety
	localize 'STR_QS_Interact_027',			// Collect gold tooth
	localize 'STR_QS_Interact_095',			// Turn on live feed
	localize 'STR_QS_Interact_096',			// Turn off live feed
	localize 'STR_QS_Interact_097',			// Activate air defense
	localize 'STR_QS_Interact_067',			// Unlock turret (Left)
	localize 'STR_QS_Interact_068',			// Unlock turret (Right)
	localize 'STR_QS_Interact_069',			// Lock turret (Left)
	localize 'STR_QS_Interact_070',			// Lock turret (Right)
	localize 'STR_QS_Interact_071',			// Cancel turret actions
	localize 'STR_QS_Interact_029',			// Join group
	localize 'STR_QS_Interact_030',			// FOB Status
	localize 'STR_QS_Interact_031',			// Activate FOB
	localize 'STR_QS_Interact_032',			// Enable FOB Respawn
	localize 'STR_QS_Interact_065',			// Cancel
	localize 'STR_QS_Interact_033',			// Edit Inventory
	localize 'STR_QS_Interact_098',			// Pick up intel
	localize 'STR_QS_Interact_099',			// Drop intel
	localize 'STR_QS_Interact_100',			// Upload intel
	localize 'STR_QS_Interact_101',			// Activate device
	localize 'STR_QS_Interact_102',			// About Us
	localize 'STR_QS_Interact_034',			// Push vehicle
	localize 'STR_A3_BIS_fnc_initIntelObject_take',
	localize 'STR_QS_Interact_103',			// Take Intel
	localize 'STR_QS_Interact_035',			// Inflate boat
	localize 'STR_QS_Interact_088',			// Suspend side missions
	localize 'STR_QS_Interact_104',			// Resume side missions
	localize 'STR_QS_Interact_089',			// Suspend primary missions
	localize 'STR_QS_Interact_105',			// Resume primary missions	
	localize 'STR_QS_Interact_090',			// Cycle primary mission
	localize 'STR_QS_Interact_072',			// 0 - Close Menu
	localize 'STR_QS_Interact_073',			// 1 - (Target) Delete
	localize 'STR_QS_Interact_074',			// 2 - Spectate			
	localize 'STR_QS_Interact_075',			// 3 - Invincibility
	localize 'STR_QS_Interact_076',			// 4 - Show Pilots
	localize 'STR_QS_Interact_077',			// 5 - (Target) Repair
	localize 'STR_QS_Interact_078',			// 6 - (Target) Pardon
	localize 'STR_QS_Interact_079',			// 7 - (Target) Punish
	localize 'STR_QS_Interact_080',			// 8 - No function assigned
	localize 'STR_QS_Interact_081',			// 9 - No function assigned
	localize 'STR_QS_Interact_082',			// 10 - (Target) Revive
	localize 'STR_QS_Interact_083',			// 11 - Map Teleport
	localize 'STR_QS_Interact_084',			// 12 - (Clean) Base
	localize 'STR_QS_Interact_085',			// 13 - (Clean) Island
	localize 'STR_QS_Interact_086',			// 14 - Splendid Cam
	localize 'STR_QS_Interact_087',			// 15 - Dev Terminal
	localize 'STR_QS_Interact_053',			// Fastrope
	localize 'STR_QS_Interact_054',			// Fastrope AI units
	localize 'STR_QS_Interact_055',			// Detach fastrope
	localize 'STR_QS_Interact_056',			// Disable fastrope
	localize 'STR_QS_Interact_057',			// Enable fastrope
	'   ',
	localize 'STR_QS_Interact_059',			// Pick up
	localize 'STR_QS_Interact_040',			// Treat (Medical Station)
	localize 'STR_QS_Interact_039',			// Activate vehicle
	localize 'STR_QS_Interact_106',			// Weapons safe on base
	localize 'STR_QS_Interact_091',			// Spawn plane
	localize 'STR_QS_Interact_060',			// Confirm target
	localize 'STR_QS_Interact_041',			// Report target
	localize 'STR_QS_Interact_062',			// Raise plow
	localize 'STR_QS_Interact_061',			// Lower plow
	localize 'STR_QS_Interact_025',			// Examine
	localize 'STR_A3_action_useCatapult',
	localize 'STR_QS_Interact_046',			// Initiate Launch Sequence
	localize 'STR_QS_Interact_047',			// Launch
	localize 'STR_QS_Interact_048',			// Retract
	localize 'STR_QS_Interact_017',			// Stabilise
	localize 'STR_QS_Interact_107',			// Inspect
	localize 'STR_QS_Interact_045',			// Self destruct
	localize 'STR_QS_Interact_049',			// Deploy camo net
	localize 'STR_QS_Interact_050',			// Remove camo net
	localize 'STR_QS_Interact_051',			// Mount slat armor
	localize 'STR_QS_Interact_052',			// Remove slat armor
	localize 'STR_QS_Interact_108',			// Retract Cargo Ropes
	localize 'STR_QS_Interact_109',			// Extend Cargo Ropes
	localize 'STR_QS_Interact_110',			// Shorten Cargo Ropes
	localize 'STR_QS_Interact_111',			// Release Cargo
	localize 'STR_QS_Interact_112',			// Deploy Cargo Ropes
	localize 'STR_QS_Interact_113',			// Attach To Cargo Ropes
	localize 'STR_QS_Interact_114',			// Drop Cargo Ropes
	localize 'STR_QS_Interact_115',			// Pickup Cargo Ropes
	localize 'STR_A3_action_Recover_Boat',
	localize 'STR_QS_Interact_018',			// Role Selection
	localize 'STR_QS_Interact_043',			// Set Cruise Control
	localize 'STR_QS_Interact_094',			// Take controls
	localize 'STR_QS_Interact_044',			// Open Parachute
	localize 'STR_QS_Interact_028',			// Take beret
	localize 'STR_QS_Interact_118'			// Cut Loose
]