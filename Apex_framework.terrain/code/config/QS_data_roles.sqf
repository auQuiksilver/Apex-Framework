/*/
File: QS_data_roles.sqf
Author:

	Quiksilver
	
Last modified:

	17/04/2017 A3 1.68 by Quiksilver
	
Description:

	Role Assignment Data
	
Roles:


	[
		<role>,
		<minimum unlocked>
		<max number in role>,
		<per X number of players another slot will open, up to the max>
	]
		
	
__________________________________________________________________________/*/

private _return = [];
if (worldName isEqualTo 'Altis') exitWith {
	[
		[
			'soldier',				// Role
			'Rifleman',				// Role Title
			-1,						// Minimum slots unlocked
			-1,						// Max number in role
			-1						// per X number of players another slot will open, up to the max
		],
		[
			'medic',
			'Combat Life Saver',
			4,
			10,
			6
		],
		[
			'autorifleman',
			'Autorifleman',
			4,
			10,
			6
		],
		[
			'engineer',
			'Engineer',
			4,
			10,
			6
		],
		[
			'sniper',
			'Sniper',
			1,
			2,
			12
		],
		[
			'pilot_heli',
			'Helicopter Pilot',
			3,
			5,
			12
		],
		[
			'pilot_fighter',
			'Fighter Pilot',
			1,
			1,
			-1
		],
		[
			'uav_operator',
			'UAV Operator',
			1,
			1,
			-1
		],
		[
			'mortar_gunner',
			'Mortar Gunner',
			1,
			1,
			-1
		],
		[
			'squad_leader',
			'Squad Leader',
			2,
			6,
			10
		],
		[
			'commander',
			'Commander',
			1,
			1,
			-1
		]
	]
};