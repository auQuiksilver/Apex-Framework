/*/
File: fn_AIdynamicSkill.sqf
Author:

	Quiksilver
	
Last Modified:

	24/06/2019 A3 1.94 by Quiksilver
	
Description:

	AI Dynamic Skill
	
Resources:

	https://community.bistudio.com/wiki/setSkill
	https://community.bistudio.com/wiki/setSkill_array
	https://community.bistudio.com/wiki/CfgAISkill
	https://community.bistudio.com/wiki/AI_Sub-skills
	https://community.bistudio.com/wiki/skillFinal
	https://community.bistudio.com/wiki/disableAI
	https://community.bistudio.com/wiki/enableAI
	
Notes:

	- Group skill profile
	- Unit type skill profile
	- Initial set
	- Recalculate
	
5,
10,
15,
20,
25,
30,
35,
40,
45,
50,
_____________________________________________________________________/*/

[
	[
		'MIN',
		[0,0,0,0,0,0,0,0,0,0],
		// Infantry
		[
			['aimingAccuracy',[0,0,0,0,0,0,0,0,0,0]],
			['aimingShake',[0,0,0,0,0,0,0,0,0,0]],
			['aimingSpeed',[0,0,0,0,0,0,0,0,0,0]],
			['reloadSpeed',[0,0,0,0,0,0,0,0,0,0]],
			['spotDistance',[0,0,0,0,0,0,0,0,0,0]],
			['spotTime',[0,0,0,0,0,0,0,0,0,0]],
			
			['commanding',[0,0,0,0,0,0,0,0,0,0]],
			['courage',[0,0,0,0,0,0,0,0,0,0]],
			['endurance',[0,0,0,0,0,0,0,0,0,0]],
			['general',[0,0,0,0,0,0,0,0,0,0]]
		],
		// Vehicle crew
		[
			['aimingAccuracy',[0,0,0,0,0,0,0,0,0,0]],
			['aimingShake',[0,0,0,0,0,0,0,0,0,0]],
			['aimingSpeed',[0,0,0,0,0,0,0,0,0,0]],
			['reloadSpeed',[0,0,0,0,0,0,0,0,0,0]],
			['spotDistance',[0,0,0,0,0,0,0,0,0,0]],
			['spotTime',[0,0,0,0,0,0,0,0,0,0]],
			
			['commanding',[0,0,0,0,0,0,0,0,0,0]],
			['courage',[0,0,0,0,0,0,0,0,0,0]],
			['endurance',[0,0,0,0,0,0,0,0,0,0]],
			['general',[0,0,0,0,0,0,0,0,0,0]]
		]
	],
	[
		'REGULAR',
		[0.15,0.15,0.175,0.175,0.2,0.2,0.225,0.225,0.25,0.25],
		// Infantry
		[
			['aimingAccuracy',[0.08,0.09,0.1,0.1,0.1,0.11,0.11,0.12,0.12,0.13]],
			['aimingShake',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			['aimingSpeed',[0.31,0.32,0.33,0.34,0.35,0.36,0.37,0.38,0.39,0.4]],
			['reloadSpeed',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			['spotDistance',[0.31,0.32,0.33,0.34,0.35,0.36,0.37,0.38,0.39,0.4]],
			['spotTime',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		],
		// Vehicle crew
		[
			['aimingAccuracy',[0.08,0.09,0.1,0.1,0.1,0.11,0.11,0.12,0.12,0.13]],
			['aimingShake',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			['aimingSpeed',[0.31,0.32,0.33,0.34,0.35,0.36,0.37,0.38,0.39,0.4]],
			['reloadSpeed',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			['spotDistance',[0.31,0.32,0.33,0.34,0.35,0.36,0.37,0.38,0.39,0.4]],
			['spotTime',[0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		]
	],
	[
		'VETERAN',
		[0.3,0.325,0.35,0.375,0.4,0.4,0.425,0.45,0.475,0.5],
		// Infantry
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		],
		// Vehicle crew
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		]
	],
	[
		'ELITE',
		[0.55,0.575,0.6,0.625,0.65,0.65,0.675,0.7,0.725,0.75],
		// Infantry
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		],
		// Vehicle crew
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		]
	],
	[
		'MAX',
		[1,1,1,1,1,1,1,1,1,1],
		// Infantry
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		],
		// Vehicle crew
		[
			['aimingAccuracy',[1,1,1,1,1,1,1,1,1,1]],
			['aimingShake',[1,1,1,1,1,1,1,1,1,1]],
			['aimingSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['reloadSpeed',[1,1,1,1,1,1,1,1,1,1]],
			['spotDistance',[1,1,1,1,1,1,1,1,1,1]],
			['spotTime',[1,1,1,1,1,1,1,1,1,1]],
			
			['commanding',[1,1,1,1,1,1,1,1,1,1]],
			['courage',[1,1,1,1,1,1,1,1,1,1]],
			['endurance',[1,1,1,1,1,1,1,1,1,1]],
			['general',[1,1,1,1,1,1,1,1,1,1]]
		]		
	]
]