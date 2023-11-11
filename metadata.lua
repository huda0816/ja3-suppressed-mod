return PlaceObj('ModDef', {
	'title', "Pinned Down",
	'description', "[Updated for 1.3 please report any bugs in the comments]\n\nThis mod introduces a suppression system, which is reflected in 5 new combat effects. While a counter tracks the suppression for each unit in the background, your units and opponents can acquire the following statuses:\n\n[list]\n[*]Shot At\n[*]Under Fire\n[*]Under Heavy Fire\n[*]Suppressed\n[*]Pinned down\n[/list]\n\nThe higher the status, the fewer APs are available to your characters in the next round and, in the case of interrupts, also in this round. In addition, units run the risk of panicking or going berserk.\n\nHowever, not every enemy and Merc reacts exactly the same to fire, but depending on experience or psychological constitution, have a certain resilience to suppression. Also, someone in good protective gear feels safer in a hail of bullets than someone in jeans and a t-shirt.\n\nIf the suppression is too much or too little for you, you will find two sliders in the mod options to influence it. \n\nThe whole thing was tested with the vanilla version of the game, but it should also run with mods that don’t change the vanilla character property “Suppressed”.\n\nMods can also easily override the suppression values of weapon types and combat actions.\n\nIf you find that the balance still needs to be tweaked, or you stumble upon a bug, please let me know.\n\n[b]Known Issues[/b]\n\nSometimes it can happen that someone who appears a little further away also receives suppression. This happens when a bullet hits quite far from the shot and the unit is nearby. This would be avoidable, but the game has to calculate quite a lot for this mod and it is rather the exception.\n\nThanks to everyone on the JA3 Modding Discord. Especially to audaki_ra and Tobias for their help.",
	'image', "Mod/ANKmKG/Images/_ff5ac272-5b19-4c5a-9273-62339c653f25.png",
	'last_changes', "v3.1\n\n[list]\n[*]Fixed options\n[*]Added a minimum value which gets removed from someones suppression each turn\n[/list]",
	'id', "ANKmKG",
	'author', "permanent666",
	'version_major', 3,
	'version_minor', 1,
	'version', 1235,
	'lua_revision', 233360,
	'saved_with_revision', 345543,
	'code', {
		"CharacterEffect/ShotAt.lua",
		"CharacterEffect/UnderFire.lua",
		"CharacterEffect/UnderHeavyFire.lua",
		"CharacterEffect/SuppressedCustom.lua",
		"CharacterEffect/PinnedDown.lua",
		"CharacterEffect/Suppressed.lua",
		"Code/Config.lua",
		"Code/Options.lua",
		"Code/SuppressionMeter.lua",
	},
	'has_options', true,
	'saved', 1699689646,
	'code_hash', -6478253464914181076,
	'steam_id', "3019207726",
})