Config = {}

---THIS RESOURCE IS HEAVILY DEPENDENT ON QB RESOURCES {qb-menu,qb-vehiclekeys,qb-core: up to date 8/1/22}
Config.Target = 'qb-target' -- set to your targetting or to false
Config.Jobname = 'taxi'
Config.Command = 'callcab'
Config.Platetxt = 'TAXI'
Config.Fuel = 'LegacyFuel'
Config.VehicleHealth = 900 -- how much body health is acceptable for passengers out of 1000 -- set to 0 if you dont wnat ped to flea because of health
Config.VehicleSpeed = 120 -- how much speed is acceptable before ped fleas set to an unreasonably high number if you dont want ped to flea from speeding this is in mph
Config.Cooldown = 1000 -- how long after each run before the next is available (reccomend 0 if randomcalls is true)
Config.RandomCalls = true -- shuts off the feature to request npc runs instead has the npcs request the player at random intervals if they are in a work vehicle
Config.Calltime = { --time between calls in minutes
	['low'] = 5,
	['high'] = 10
}
Config.RideShare = false -- there is a chance of 2 npcs always. if this is set false you will get the pickup amount from each of them if true you will get it from only one
Config.PickupPrice = 50 -- price per mile for pickup (this is approximate...) I did not use distance between coords like most resources.
Config.DropOffPrice = 50 -- note the ui may increase in number but the payout is not exploitable at all 
Config.Tip = { --time between calls in minutes
	['active'] = true, -- if false there will be no chance that the driver gets a tip
	['low'] = 5,
	['high'] = 10
}
Config.ItemChance = {
	['items'] = {
		'lockpick',
		'cokebaggy',
		'cryptostick',
		'meth'
	},
	['active'] = true,
	['chance'] = 10 --percent of chance to recieve an item
}

Config.Locations = {
	['blip'] = {
		location = vector3(909.19, -176.79, 74.21),
		sprite = 1,
		scale = 0.8,
		color = 1,
		label = 'Cab-Co'
	},
	['boss'] = {
		location = vector3(907.05, -152.11, 83.5),
		label = '[E] Boss Menu'
	},
	['duty'] = {
		location = vector3(891.3, -170.68, 81.6),
		label = '[E] Cycle Duty'
	},
	['stash'] = {
		location = vector3(894.72, -175.61, 81.6),
		label = '[E] Cab-Co Storage',
		weight = 25000,
		size = 40
	},	
	['garage'] = {
		location = vector3(904.18, -175.19, 74.07),
		label = '[E] Cab-Co Garage',
		spawn = {
			vector4(899.996765, -181.090515, 73.470055, 237.086456298830),
			vector4(908.463562, -182.934692, 73.777763, 56.7324867248540),
			vector4(898.099121, -183.884720, 73.388062, 236.912689208980),
			vector4(906.718384, -186.038834, 73.634918, 57.6093368530270),
			vector4(904.972534, -188.826263, 73.442329, 59.5614662170410),
			vector4(916.434937, -170.759979, 74.050163, 100.678482),
			vector4(911.443359, -163.309494, 73.979507, 195.833191),
			vector4(918.656738, -167.168915, 74.243187, 102.003471),
			vector4(913.875061, -160.003235, 74.375732, 192.958450),
			vector4(920.076538, -163.785706, 74.415535, 100.066879)
		},
		['vehicles'] = {
			[0] = {
				'taxi',
			},
			[1] = {
				'taxi',
			},
			[2] = {
				'taxi',
			},
			[3] = {
				'taxi',
			},
			[4] = {
				'taxi',
			},
		}

	}
}

Config.Notifications = {
	['park'] = 'The Valet has parked the vehicle.',
	['nopark'] = 'There needs to be a cab in a parking spot for the valet to park it.',
	['carout'] = 'You Already have a car out.',
	['nocab'] = 'This isnt the original cab the rider called',
	['available'] = 'You are available for local calls.',
	['notavailable'] = 'You are not available for local calls.',
	['cooldown'] = 'You need to wait for another available job.'
}

Config.UI = {-- can change UI settings here must change variariable in HTML as well
	['speedlimiter'] = {-- in mph
		urban = 50,
		rural = 90,
		hwy = 120
	},
	['settings'] = {
		fare = "$ 50.00 /mi",
		focuskey = "F6",
		open = "F5"
	}
}

Config.Peds = {
	['model'] = {
		['male'] = {
			"A_M_M_ACult_01","A_M_M_AfriAmer_01","A_M_M_Beach_01","A_M_M_Beach_02","A_M_M_BevHills_01","A_M_M_BevHills_02","A_M_M_Business_01",
			"A_M_M_EastSA_01","A_M_M_EastSA_02","A_M_M_Farmer_01","A_M_M_FatLatin_01","A_M_M_GenFat_01","A_M_M_GenFat_02","A_M_M_Golfer_01","A_M_M_HasJew_01","A_M_M_Hillbilly_01","A_M_M_Hillbilly_02","A_M_M_Indian_01",
			"A_M_M_KTown_01","A_M_M_Malibu_01","A_M_M_MexCntry_01","A_M_M_MexLabor_01","A_M_M_OG_Boss_01","A_M_M_Paparazzi_01","A_M_M_Polynesian_01","A_M_M_ProlHost_01","A_M_M_RurMeth_01","A_M_M_Salton_01","A_M_M_Salton_02",
			"A_M_M_Salton_03","A_M_M_Salton_04","A_M_M_Skater_01","A_M_M_Skidrow_01","A_M_M_SoCenLat_01","A_M_M_SouCent_01","A_M_M_SouCent_02","A_M_M_SouCent_03","A_M_M_SouCent_04","A_M_M_StLat_02","A_M_M_Tennis_01",
			"A_M_M_Tourist_01","A_M_M_TrampBeac_01","A_M_M_Tramp_01","A_M_M_TranVest_01","A_M_M_TranVest_02","A_M_O_ACult_01","A_M_O_ACult_02","A_M_O_Beach_01","A_M_O_GenStreet_01","A_M_O_KTown_01","A_M_O_Salton_01",
			"A_M_O_SouCent_01","A_M_O_SouCent_02","A_M_O_SouCent_03","A_M_O_Tramp_01","A_M_Y_ACult_01","A_M_Y_ACult_02","A_M_Y_BeachVesp_01","A_M_Y_BeachVesp_02","A_M_Y_Beach_01","A_M_Y_Beach_02","A_M_Y_Beach_03","A_M_Y_BevHills_01",
			"A_M_Y_BevHills_02","A_M_Y_BreakDance_01","A_M_Y_BusiCas_01","A_M_Y_Business_01","A_M_Y_Business_02","A_M_Y_Business_03","A_M_Y_Cyclist_01","A_M_Y_DHill_01","A_M_Y_Downtown_01","A_M_Y_EastSA_01","A_M_Y_EastSA_02",
			"A_M_Y_Epsilon_01","A_M_Y_Epsilon_02","A_M_Y_Gay_01","A_M_Y_Gay_02","A_M_Y_GenStreet_01","A_M_Y_GenStreet_02","A_M_Y_Golfer_01","A_M_Y_HasJew_01","A_M_Y_Hiker_01","A_M_Y_Hippy_01","A_M_Y_Hipster_01","A_M_Y_Hipster_02",
			"A_M_Y_Hipster_03","A_M_Y_Indian_01","A_M_Y_Jetski_01","A_M_Y_Juggalo_01","A_M_Y_KTown_01","A_M_Y_KTown_02","A_M_Y_Latino_01","A_M_Y_MethHead_01","A_M_Y_MexThug_01","A_M_Y_MotoX_01","A_M_Y_MotoX_02","A_M_Y_MusclBeac_01",
			"A_M_Y_MusclBeac_02","A_M_Y_Polynesian_01","A_M_Y_RoadCyc_01","A_M_Y_Runner_01","A_M_Y_Runner_02","A_M_Y_Salton_01","A_M_Y_Skater_01","A_M_Y_Skater_02","A_M_Y_SouCent_01","A_M_Y_SouCent_02","A_M_Y_SouCent_03","A_M_Y_SouCent_04",
			"A_M_Y_StBla_01","A_M_Y_StBla_02","A_M_Y_StLat_01","A_M_Y_StWhi_01","A_M_Y_StWhi_02","A_M_Y_Sunbathe_01","A_M_Y_Surfer_01","A_M_Y_VinDouche_01","A_M_Y_Vinewood_01","A_M_Y_Vinewood_02","A_M_Y_Vinewood_03","A_M_Y_Vinewood_04",
			"A_M_Y_Yoga_01","G_M_M_ArmBoss_01","G_M_M_ArmGoon_01","G_M_M_ArmLieut_01","G_M_M_ChemWork_01","G_M_M_ChiBoss_01","G_M_M_ChiCold_01","G_M_M_ChiGoon_01","G_M_M_ChiGoon_02","G_M_M_KorBoss_01","G_M_M_MexBoss_01","G_M_M_MexBoss_02","G_M_Y_ArmGoon_02","G_M_Y_Azteca_01",
			"G_M_Y_BallaEast_01","G_M_Y_BallaOrig_01","G_M_Y_BallaSout_01","G_M_Y_FamCA_01","G_M_Y_FamDNF_01","G_M_Y_FamFor_01","G_M_Y_Korean_01","G_M_Y_Korean_02","G_M_Y_KorLieut_01","G_M_Y_Lost_01","G_M_Y_Lost_02","G_M_Y_Lost_03",
			"G_M_Y_MexGang_01","G_M_Y_MexGoon_01","G_M_Y_MexGoon_02","G_M_Y_MexGoon_03","G_M_Y_PoloGoon_01","G_M_Y_PoloGoon_02","G_M_Y_SalvaBoss_01","G_M_Y_SalvaGoon_01","G_M_Y_SalvaGoon_02","G_M_Y_SalvaGoon_03","G_M_Y_StrPunk_01","G_M_Y_StrPunk_02","U_M_M_Aldinapoli","U_M_M_BankMan","U_M_M_BikeHire_01","U_M_M_FIBArchitect","U_M_M_FilmDirector","U_M_M_GlenStank_01",
			"U_M_M_Griff_01","U_M_M_Jesus_01","U_M_M_JewelSec_01","U_M_M_JewelThief","U_M_M_MarkFost","U_M_M_PartyTarget","U_M_M_ProlSec_01","U_M_M_ProMourn_01","U_M_M_RivalPap","U_M_M_SpyActor","U_M_M_WillyFist","U_M_O_FinGuru_01",
			"U_M_Y_BabyD","U_M_Y_BurgerDrug_01","U_M_Y_Chip","U_M_Y_Cyclist_01","U_M_Y_FIBMugger_01","U_M_Y_Hippie_01","U_M_Y_ImpoRage","U_M_Y_Justin","U_M_Y_Mani","U_M_Y_MilitaryBum","U_M_Y_Paparazzi","U_M_Y_Party_01",
			"U_M_Y_Pogo_01","U_M_Y_Prisoner_01","U_M_Y_ProlDriver_01","U_M_Y_RSRanger_01"
		},
		['female'] = {
			"A_F_M_EastSA_01","A_F_M_EastSA_02","A_F_M_FatBla_01","A_F_M_FatCult_01","A_F_M_FatWhite_01","A_F_M_KTown_01","A_F_M_KTown_02","A_F_M_ProlHost_01","A_F_M_Salton_01","A_F_M_SkidRow_01","A_F_M_SouCentMC_01","A_F_M_SouCent_01","A_F_M_SouCent_02",
			"A_F_M_Tourist_01","A_F_M_TrampBeac_01","A_F_M_Tramp_01","A_F_O_GenStreet_01","A_F_O_Indian_01","A_F_O_KTown_01","A_F_O_Salton_01","A_F_O_SouCent_01","A_F_O_SouCent_02","A_F_Y_Beach_01","A_F_Y_BevHills_01","A_F_Y_BevHills_02",
			"A_F_Y_BevHills_03","A_F_Y_BevHills_04","A_F_Y_Business_01","A_F_Y_Business_02","A_F_Y_Business_03","A_F_Y_Business_04","A_F_Y_EastSA_01","A_F_Y_EastSA_02","A_F_Y_EastSA_03","A_F_Y_Epsilon_01","A_F_Y_Fitness_01",
			"A_F_Y_Fitness_02","A_F_Y_GenHot_01","A_F_Y_Golfer_01","A_F_Y_Hiker_01","A_F_Y_Hippie_01","A_F_Y_Hipster_01","A_F_Y_Hipster_02","A_F_Y_Hipster_03","A_F_Y_Hipster_04","A_F_Y_Indian_01","A_F_Y_Juggalo_01","A_F_Y_Runner_01",
			"A_F_Y_RurMeth_01","A_F_Y_SCDressy_01","A_F_Y_Skater_01","A_F_Y_SouCent_01","A_F_Y_SouCent_02","A_F_Y_SouCent_03","A_F_Y_Tennis_01","A_F_Y_Topless_01","A_F_Y_Tourist_01","A_F_Y_Tourist_02","A_F_Y_Vinewood_01",
			"A_F_Y_Vinewood_02","A_F_Y_Vinewood_03","A_F_Y_Vinewood_04","A_F_Y_Yoga_01","S_M_Y_WinClean_01","S_M_Y_XMech_01","S_M_Y_XMech_02","U_F_M_Corpse_01","U_F_M_Miranda","U_F_M_ProMourn_01","U_F_O_MovieStar","U_F_O_ProlHost_01","U_F_Y_BikerChic","U_F_Y_COMJane","U_F_Y_corpse_01","U_F_Y_corpse_02",
			"U_F_Y_HotPosh_01","U_F_Y_JewelAss_01","U_F_Y_Mistress","U_F_Y_PoppyMich","U_F_Y_Princess","U_F_Y_SpyActress"
		}

	},
	['names'] = {
		['male'] = {
			'Marcus Rollins',
			'Christopher Lopez',
			'Patrick Medina',
			'Steven Hunt Jr.',
			'Tracy Johnson',
			'Jose Bradley',
			'Joseph Myers',
			'Eduardo Kim',
			'Andre Franco',
			'David Santiago',
			'Stanley Shaw',
			'Matthew Jennings',
			'Aaron Morales',
			'Marcus Valenzuela',
			'Eddie Cunningham',
			'Timothy Graham',
			'Evan Jones',
			'Tracy Young',
			'Daniel Mccarty',
			'Aaron Lang',
			'Thomas Hunter',
			'Daniel Williams PhD',
			'Ronald Ford',
			'Brent Morales',
			'Zachary Jones',
			'Mr. Anthony Jenkins MD',
			'Zachary Butler',
			'Ryan Smith',
			'Brian Bruce',
			'David Rodriguez',
			'Robert Mendoza',
			'Benjamin Harvey',
			'Charles Watkins',
			'Michael Spencer',
			'Brandon Barker',
			'Maxwell Mclean',
			'Michael Hart',
			'Dennis Shannon',
			'Scott Rodriguez',
			'Walter Wilson',
			'Lee Smith',
			'Jordan Graves',
			'Andrew Neal',
			'Vincent Reed',
			'Christopher Hubbard',
			'Jeffrey Roberts',
			'Nicholas Juarez',
			'Jesse Porter',
			'John West',
			'Jacob Rose'
		},
		['female'] = {
			'Miranda Williamson',
			'Rebekah Garcia',
			'Megan Kelly',
			'Crystal Santos',
			'Jill Burns',
			'Jacqueline Leblanc',
			'Emily Krause',
			'Stephanie Dennis',
			'Brittany Trujillo',
			'Allison Ramos',
			'Jane Steele',
			'Cheryl Simmons',
			'Robin Thomas',
			'Stacy Rice',
			'Laura Garcia',
			'Heather Meyers',
			'Ashley Wright',
			'Karen Henry',
			'Brenda Duncan',
			'Jessica Carlson',
			'Erika Warner',
			'Jacqueline Wheeler',
			'Laura Goodman',
			'Maria Villanueva',
			'Jordan Wilson',
			'Sarah Wood',
			'Sarah Lucas',
			'Julie Miller',
			'Melissa Patrick',
			'Kelly Jackson',
			'Kayla Frederick',
			'Susan Massey',
			'Lori Jones',
			'Angela Wilson',
			'Sarah Harris',
			'Mrs. Renee Irwin',
			'Jessica Fisher',
			'Deanna Bradford',
			'Paula Hansen',
			'Kristen Ortega',
			'Susan Wolfe',
			'Brenda Wright',
			'Cynthia Calderon',
			'Allison Bright',
			'Nicole Sanders',
			'Beth Osborn',
			'Melissa Davis',
			'Melanie Velazquez',
			'Stacy Smith',
			'Sarah Rollins'
		}
	}
}

Config.PedLoc = {
	{vector4(665.543823, -7.429958, 84.026718, 176.723206)},
	{vector4(784.726440, -165.131882, 74.236824, 170.017776)},
	{vector4(853.373718, -112.669716, 79.347000, 328.411346)},
	{vector4(922.498047, 46.935883, 81.106392, 58.112934)},
	{vector4(809.962524, 563.165649, 125.915207, 314.346619)},
	{vector4(640.919922, 260.330109, 103.298309, 30.510521)},
	{vector4(503.992493, 102.890533, 96.269470, 233.296722)},
	{vector4(305.265808, 17.183130, 83.238762, 244.322937)},
	{vector4(344.213043, -94.365395, 67.709274, 172.645233)},
	{vector4(506.963470, -236.648956, 48.844997, 255.662201)},
	{vector4(359.939850, -290.655243, 53.853817, 55.452602)},
	{vector4(250.292664, -199.166382, 54.436764, 64.379028)},
	{vector4(104.221680, -207.526489, 54.636181, 65.565102)},
	{vector4(128.824326, -303.805573, 45.330448, 176.800812)},
	{vector4(280.322296, -391.708435, 45.025593, 268.849426)},
	{vector4(277.772766, -590.030334, 43.303734, 74.586884)},
	{vector4(128.158508, -560.679321, 43.565144, 72.617271)},
	{vector4(24.719215, -741.903381, 44.189842, 243.200623)},
	{vector4(-53.877964, -787.595215, 44.225124, 330.306580)},
	{vector4(-174.438278, -810.316528, 31.336441, 251.565826)},
	{vector4(-78.337227, -914.322021, 29.340528, 161.488251)},
	{vector4(75.438972, -1032.134521, 29.461191, 243.300537)},
	{vector4(251.750839, -999.319885, 29.264729, 74.560776)},
	{vector4(396.292572, -928.419678, 29.418688, 243.611786)},
	{vector4(432.512421, -643.573853, 28.721367, 101.318245)},
	{vector4(495.414276, -1277.130249, 29.316364, 267.911041)},
	{vector4(785.922729, -1294.771606, 26.272680, 273.821808)},
	{vector4(776.934509, -1085.101440, 28.599466, 295.699188)},
	{vector4(1211.992798, -1390.532715, 35.376896, 178.688324)},
	{vector4(1311.902100, -1602.886108, 52.575462, 317.327789)},
	{vector4(1213.771240, -1771.138428, 40.009296, 31.175194)},
	{vector4(1054.907593, -1872.324463, 30.517714, 172.863724)},
	{vector4(912.960388, -2190.658203, 30.494535, 236.818848)},
	{vector4(17.354498, -2537.106201, 6.148541, 238.416992)},
	{vector4(-211.765625, -1998.942871, 27.755428, 276.070374)},
	{vector4(-1138.807373, -1994.898804, 13.166603, 318.187164)},
	{vector4(-1026.764160, -2737.892822, 20.169289, 332.379608)},
	{vector4(-1086.844238, -1535.575806, 4.633732, 197.156708)},
	{vector4(-1295.315796, -1151.424683, 5.466588, 86.969284)},
	{vector4(-1285.422119, -879.070923, 11.423104, 121.423447)},
	{vector4(-1299.666504, -381.008362, 36.566437, 287.869537)},
	{vector4(-1430.648560, -266.789886, 46.264629, 132.330093)},
	{vector4(-1678.483765, -293.319794, 51.883308, 141.045441)},
	{vector4(-2080.951172, -338.981476, 13.252520, 4.602396)},
	{vector4(-3030.730225, 94.146378, 12.346247, 342.665039)},
	{vector4(-3026.332764, 550.215698, 7.469450, 287.802643)},
	{vector4(-2972.082764, 475.519287, 15.404305, 55.184494)},
	{vector4(-3237.309082, 1015.311096, 12.232530, 259.515930)},
	{vector4(-2551.321533, 1910.686890, 169.007324, 219.812546)},
	{vector4(-1287.052246, 2520.933105, 20.002293, 197.995407)},
	{vector4(1494.615356, 3589.932861, 35.521774, 213.684753)},
	{vector4(1355.727173, 3584.642822, 34.895203, 151.715042)},
	{vector4(948.245789, 3618.226074, 32.553905, 66.201683)},
	{vector4(341.769073, 3408.740479, 36.594810, 37.871025)},
	{vector4(89.951004, 3594.256836, 39.814449, 126.909500)},
	{vector4(2110.798340, 4766.583008, 41.216091, 79.622765)},
	{vector4(2901.773926, 4428.802734, 48.278984, 297.059937)},
	{vector4(1700.337769, 4934.765137, 42.078136, 59.046291)},
	{vector4(138.298111, 6434.508789, 31.360682, 157.742050)},
	{vector4(-116.292328, 6460.291992, 31.468451, 167.897400)},
	{vector4(-316.808746, 6258.469238, 31.514378, 108.216148)},
	{vector4(-419.565796, 6010.999023, 31.491949, 286.690918)},
	{vector4(1853.364014, 2595.005127, 45.672047, 266.674133)}
}