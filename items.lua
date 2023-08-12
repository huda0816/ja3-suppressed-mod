return {
PlaceObj('ModItemCharacterEffectCompositeDef', {
	'Id', "ShotAt",
	'Parameters', {
		PlaceObj('PresetParamNumber', {
			'Name', "ap_loss",
			'Value', 2,
			'Tag', "<ap_loss>",
		}),
	},
	'object_class', "StatusEffect",
	'msg_reactions', {
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
				end
				
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
			param_bindings = false,
		}),
	},
	'Modifiers', {},
	'DisplayName', T(510464695152, --[[ModItemCharacterEffectCompositeDef ShotAt DisplayName]] "Shot At"),
	'Description', T(792330021722, --[[ModItemCharacterEffectCompositeDef ShotAt Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	'AddEffectText', T(412740953082, --[[ModItemCharacterEffectCompositeDef ShotAt AddEffectText]] "<color EmStyle><DisplayName></color> is shot at"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
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
			'Value', 4,
			'Tag', "<ap_loss>",
		}),
	},
	'object_class', "StatusEffect",
	'msg_reactions', {
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
				    unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
				end
				
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
				    unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
			param_bindings = false,
		}),
	},
	'DisplayName', T(313402185495, --[[ModItemCharacterEffectCompositeDef UnderFire DisplayName]] "Under Fire"),
	'Description', T(337536955376, --[[ModItemCharacterEffectCompositeDef UnderFire Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	'AddEffectText', T(387783458681, --[[ModItemCharacterEffectCompositeDef UnderFire AddEffectText]] "<color EmStyle><DisplayName></color> is under fire"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
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
			'Value', 6,
			'Tag', "<ap_loss>",
		}),
	},
	'object_class', "StatusEffect",
	'msg_reactions', {
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.APssr)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
				end
				
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.APssr)
				end
			end,
			param_bindings = false,
		}),
	},
	'DisplayName', T(822871836175, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire DisplayName]] "Under Heavy Fire"),
	'Description', T(334880395032, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	'AddEffectText', T(919180442165, --[[ModItemCharacterEffectCompositeDef UnderHeavyFire AddEffectText]] "<color EmStyle><DisplayName></color> is under heavy fire"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
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
			'Value', 8,
			'Tag', "<ap_loss>",
		}),
	},
	'object_class', "StatusEffect",
	'msg_reactions', {
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
				end
				
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
			param_bindings = false,
		}),
	},
	'DisplayName', T(785373036573, --[[ModItemCharacterEffectCompositeDef SuppressedCustom DisplayName]] "Suppressed"),
	'Description', T(833916880502, --[[ModItemCharacterEffectCompositeDef SuppressedCustom Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	'AddEffectText', T(969834413493, --[[ModItemCharacterEffectCompositeDef SuppressedCustom AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
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
			'Value', 10,
			'Tag', "<ap_loss>",
		}),
	},
	'object_class', "StatusEffect",
	'msg_reactions', {
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
				end
				
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
			param_bindings = false,
		}),
	},
	'DisplayName', T(705794185892, --[[ModItemCharacterEffectCompositeDef PinnedDown DisplayName]] "Pinned Down"),
	'Description', T(626021581178, --[[ModItemCharacterEffectCompositeDef PinnedDown Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	'AddEffectText', T(786631920648, --[[ModItemCharacterEffectCompositeDef PinnedDown AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
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
		PlaceObj('MsgReaction', {
			Event = "StatusEffectAdded",
			Handler = function (self, obj, id, stacks)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "StatusEffectAdded")
				if not reaction_idx then return end
				
				local function exec(self, obj, id, stacks)
				if IsKindOf(obj, "Unit") then
					obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local _id = GetCharacterEffectId(self)
				if _id == id then exec(self, obj, id, stacks) end
				
			end,
			HandlerCode = function (self, obj, id, stacks)
				if IsKindOf(obj, "Unit") then
					obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
			param_bindings = false,
		}),
		PlaceObj('MsgReaction', {
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				local reaction_idx = table.find(self.msg_reactions or empty_table, "Event", "UnitBeginTurn")
				if not reaction_idx then return end
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				local id = GetCharacterEffectId(self)
				
				if id then
					if IsKindOf(unit, "StatusEffectObject") and unit:HasStatusEffect(id) then
						exec(self, unit)
					end
				else
					exec(self, unit)
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
	'DisplayName', T(948417836927, --[[ModItemCharacterEffectCompositeDef Suppressed DisplayName]] "Suppressed"),
	'Description', T(986879860923, --[[ModItemCharacterEffectCompositeDef Suppressed Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn. This character cannot <color EmStyle>Flank</color> enemies."),
	'AddEffectText', T(435148747721, --[[ModItemCharacterEffectCompositeDef Suppressed AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	'type', "Debuff",
	'lifetime', "Until End of Turn",
	'Icon', "UI/Hud/Status effects/suppressed",
	'RemoveOnEndCombat', true,
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
PlaceObj('ModItemOptionNumber', {
	'name', "suppressed_suppression_ai_multiplier",
	'DisplayName', "Suppression multiplier (AI)",
	'Help', "Reduce or increase the suppression value for the AI",
	'DefaultValue', 100,
	'MaxValue', 200,
	'StepSize', 10,
}),
PlaceObj('ModItemOptionNumber', {
	'name', "suppressed_suppression_player_multiplier",
	'DisplayName', "Suppression multiplier (Player)",
	'Help', "Reduce or increase the suppression value for the player",
	'DefaultValue', 100,
	'MaxValue', 200,
	'StepSize', 10,
}),
}
