return {
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "ShotAt",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Value', -2,
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(961066146746, --[[ModItemCharacterEffectCompositeDef ShotAt DisplayName]] "Shot At"),
		'Description', T(409582181554, --[[ModItemCharacterEffectCompositeDef ShotAt Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
		'AddEffectText', T(267598568608, --[[ModItemCharacterEffectCompositeDef ShotAt AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'Icon', "Mod/ANKmKG/Icons/suppression1.png",
		'RemoveOnEndCombat', true,
		'Shown', true,
		'HasFloatingText', true,
	}),
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "UnderFire",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Value', -4,
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(989455125648, --[[ModItemCharacterEffectCompositeDef UnderFire DisplayName]] "Under Fire"),
		'Description', T(390089603814, --[[ModItemCharacterEffectCompositeDef UnderFire Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
		'AddEffectText', T(780311442123, --[[ModItemCharacterEffectCompositeDef UnderFire AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'Icon', "Mod/ANKmKG/Icons/suppression2.png",
		'RemoveOnEndCombat', true,
		'Shown', true,
		'HasFloatingText', true,
	}),
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "UnderHeavyFire",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Value', -6,
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(240871056837, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire DisplayName]] "Under Heavy Fire"),
		'Description', T(484767204569, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
		'AddEffectText', T(668863159769, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'Icon', "Mod/ANKmKG/Icons/suppression3.png",
		'RemoveOnEndCombat', true,
		'Shown', true,
		'HasFloatingText', true,
	}),
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "SuppressedCustom",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Value', -8,
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(834366384495, --[[ModItemCharacterEffectCompositeDef SuppressedCustom DisplayName]] "Suppressed"),
		'Description', T(373418870750, --[[ModItemCharacterEffectCompositeDef SuppressedCustom Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
		'AddEffectText', T(122925869251, --[[ModItemCharacterEffectCompositeDef SuppressedCustom AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'Icon', "Mod/ANKmKG/Icons/suppression4.png",
		'RemoveOnEndCombat', true,
		'Shown', true,
		'HasFloatingText', true,
	}),
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "PinnedDown",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Value', -10,
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(181499975893, --[[ModItemCharacterEffectCompositeDef PinnedDown DisplayName]] "Pinned Down"),
		'Description', T(259808645196, --[[ModItemCharacterEffectCompositeDef PinnedDown Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
		'AddEffectText', T(967306901333, --[[ModItemCharacterEffectCompositeDef PinnedDown AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'Icon', "Mod/ANKmKG/Icons/suppression5.png",
		'RemoveOnEndCombat', true,
		'Shown', true,
		'HasFloatingText', true,
	}),
	PlaceObj('ModItemCharacterEffectCompositeDef', {
		'Id', "Suppressed",
		'Parameters', {
			PlaceObj('PresetParamNumber', {
				'Name', "ap_loss",
				'Tag', "<ap_loss>",
			}),
		},
		'object_class', "StatusEffect",
		'msg_reactions', {
			PlaceObj('MsgActorReaction', {
				ActorParam = "obj",
				Event = "StatusEffectAdded",
				Handler = function (self, obj, id, stacks)
					local reaction_def = (self.msg_reactions or empty_table)[1]
					if self:VerifyReaction("StatusEffectAdded", reaction_def, obj, obj, id, stacks) then
						if IsKindOf(obj, "Unit") then
						obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, obj, id, stacks)
					if IsKindOf(obj, "Unit") then
						obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
			PlaceObj('MsgActorReaction', {
				ActorParam = "unit",
				Event = "UnitBeginTurn",
				Handler = function (self, unit)
					local reaction_def = (self.msg_reactions or empty_table)[2]
					if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
						if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
					end
				end,
				HandlerCode = function (self, unit)
					if IsKindOf(unit, "Unit") then
						unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
					end
				end,
				param_bindings = false,
			}),
		},
		'DisplayName', T(497878015648, --[[ModItemCharacterEffectCompositeDef Suppressed DisplayName]] "Suppressed"),
		'Description', T(594631976836, --[[ModItemCharacterEffectCompositeDef Suppressed Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn. This character cannot <color EmStyle>Flank</color> enemies."),
		'AddEffectText', T(776408433487, --[[ModItemCharacterEffectCompositeDef Suppressed AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
		'type', "Debuff",
		'lifetime', "Until End of Turn",
		'Icon', "UI/Hud/Status effects/suppressed",
		'RemoveOnEndCombat', true,
	}),
	PlaceObj('ModItemCode', {
		'name', "Config",
		'CodeFileName', "Code/Config.lua",
	}),
	PlaceObj('ModItemCode', {
		'name', "Options",
		'comment', "Mod Options",
		'CodeFileName', "Code/Options.lua",
	}),
	PlaceObj('ModItemCode', {
		'name', "SuppressionMeter",
		'CodeFileName', "Code/SuppressionMeter.lua",
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Is test mode active?",
		id = "suppression_test_mode",
		type = "bool",
		value = false,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Is the suppression mod active?",
		id = "suppression_mod_active",
		type = "bool",
		value = true,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "How much APs are consumed per level of suppression",
		id = "suppression_consumed_ap_per_level",
		value = 2,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "How much suppression is removed per round",
		id = "suppression_max_removed",
		value = 1000,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Multiplier to the suppression damage taken by units",
		id = "suppression_multiplier",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Multiplier to the suppression damage taken by AI units",
		id = "suppression_ai_multiplier",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Multiplier to the suppression damage taken by units",
		id = "suppression_player_multiplier",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Multiplier to the suppression resistance",
		id = "suppression_resitance_multiplier",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Multiplier to the suppression armor resistance",
		id = "suppression_armor_resistance_multiplier",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Tresholds for suppression states",
		id = "suppression_state_treshold_shot_at",
		value = 5,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Tresholds for suppression states",
		id = "suppression_state_treshold_under_fire",
		value = 25,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Tresholds for suppression states",
		id = "suppression_state_treshold_under_heavy_fire",
		value = 50,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Tresholds for suppression states",
		id = "suppression_state_treshold_suppressed_custom",
		value = 75,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Tresholds for suppression states",
		id = "suppression_state_treshold_pinned_down",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Vanilla suppression value",
		id = "suppression_vanilla_value",
		value = 10,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Panic Treshold",
		id = "suppression_panic_treshold",
		value = 100,
	}),
	PlaceObj('ModItemConstDef', {
		comment = "Berserk Treshold",
		id = "suppression_panic_treshold",
		value = 120,
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "suppressed_suppression_multiplier",
		'DisplayName', "Suppression multiplier (All %)",
		'DefaultValue', "100",
		'ChoiceList', {
			"10",
			"20",
			"30",
			"40",
			"50",
			"60",
			"70",
			"80",
			"90",
			"100",
			"110",
			"120",
			"130",
			"140",
			"150",
			"160",
			"170",
			"180",
			"190",
			"200",
		},
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "suppressed_suppression_ai_multiplier",
		'DisplayName', "Suppression multiplier (AI %)",
		'DefaultValue', "100",
		'ChoiceList', {
			"10",
			"20",
			"30",
			"40",
			"50",
			"60",
			"70",
			"80",
			"90",
			"100",
			"110",
			"120",
			"130",
			"140",
			"150",
			"160",
			"170",
			"180",
			"190",
			"200",
		},
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "suppressed_suppression_player_multiplier",
		'DisplayName', "Suppression multiplier (Player %)",
		'DefaultValue', "100",
		'ChoiceList', {
			"10",
			"20",
			"30",
			"40",
			"50",
			"60",
			"70",
			"80",
			"90",
			"100",
			"110",
			"120",
			"130",
			"140",
			"150",
			"160",
			"170",
			"180",
			"190",
			"200",
		},
	}),
	PlaceObj('ModItemOptionChoice', {
		'name', "suppressed_consumed_aps_log_level",
		'DisplayName', "AP loss log level",
		'Help', "Use short or important to see how much AP is lossed due to suppression",
		'DefaultValue', "debug (visible only in debug mode)",
		'ChoiceList', {
			"debug (visible only in debug mode)",
			"short (visible in Snype)",
			"important (visible on screen and in Snype)",
		},
	}),
}