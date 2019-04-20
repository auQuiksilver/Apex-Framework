/*/
File: QS_data_roles.sqf
Author:

	Quiksilver
	
Last modified:

	13/10/2018 A3 1.84 by Quiksilver
	
Description:

	Role Assignment Data
	
Roles:


	[
		<role>,
		<minimum unlocked>
		<maximum unlocked>,
		<per X number of players another slot will open, up to the max>,
		<role whitelist>
	]
__________________________________________________________________________/*/

if (worldName isEqualTo 'Altis') exitWith {
	[
		[
			'rifleman',				// Role
			'Rifleman',				// Role Title
			999,						// Minimum slots unlocked
			999,						// Max number in role
			0,						// per X number of players another slot will open, up to the max
			0
		],
		[
			'medic',
			'Medic',
			4,
			10,
			6,
			0
		],
		[
			'autorifleman',
			'Autorifleman',
			4,
			10,
			6,
			0
		],
		[
			'machine_gunner',
			'Heavy Gunner',
			4,
			10,
			6,
			0
		],
		[
			'engineer',
			'Engineer',
			4,
			10,
			6,
			0
		],
		[
			'sniper',
			'Sniper',
			1,
			2,
			12,
			0
		],
		[
			'pilot_heli',
			'Pilot (Helicopter)',
			3,
			5,
			12,
			0
		],
		[
			'pilot_plane',
			'Pilot (Plane)',
			1,
			1,
			-1,
			0
		],
		[
			'uav',
			'UAV Operator',
			1,
			1,
			-1,
			0
		],
		[
			'mortar',
			'Mortar Gunner',
			1,
			1,
			-1,
			0
		],
		[
			'jtac',
			'JTAC',
			1,
			1,
			-1,
			0
		],
		[
			'squad_leader',
			'Squad Leader',
			2,
			6,
			10,
			0
		],
		[
			'commander',
			'Commander',
			1,
			1,
			-1,
			0
		]
	]
};
[
	[
		'rifleman',				// Role
		'Rifleman',				// Role Title
		-1,						// Minimum slots unlocked
		-1,						// Max number in role
		-1,
		0						// per X number of players another slot will open, up to the max
	],
	[
		'medic',
		'Medic',
		4,
		10,
		6,
		0
	],
	[
		'autorifleman',
		'Autorifleman',
		4,
		10,
		6,
		0
	],
	[
		'machine_gunner',
		'Heavy Gunner',
		4,
		10,
		6,
		0
	],
	[
		'engineer',
		'Engineer',
		4,
		10,
		6,
		0
	],
	[
		'sniper',
		'Sniper',
		1,
		2,
		12,
		0
	],
	[
		'pilot_heli',
		'Pilot (Helicopter)',
		3,
		5,
		12,
		0
	],
	[
		'pilot_plane',
		'Pilot (Plane)',
		1,
		1,
		-1,
		0
	],
	[
		'uav',
		'UAV Operator',
		1,
		1,
		-1,
		0
	],
	[
		'mortar',
		'Mortar Gunner',
		1,
		1,
		-1,
		0
	],
	[
		'jtac',
		'JTAC',
		1,
		1,
		-1,
		0
	],
	[
		'squad_leader',
		'Squad Leader',
		2,
		6,
		10,
		0
	],
	[
		'commander',
		'Commander',
		1,
		1,
		-1,
		0
	]
]