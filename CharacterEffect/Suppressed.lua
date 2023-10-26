UndefineClass('Suppressed')
DefineClass.Suppressed = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {
		PlaceObj('MsgActorReaction', {
			ActorParam = "obj",
			Event = "StatusEffectAdded",
			Handler = function (self, obj, id, stacks)
				
				local function exec(self, obj, id, stacks)
				if IsKindOf(obj, "Unit") then
					obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				
				if not IsKindOf(self, "MsgReactionsPreset") then return end
				
				local reaction_def = (self.msg_reactions or empty_table)[1]
				if not reaction_def or reaction_def.Event ~= "StatusEffectAdded" then return end
				
				if not IsKindOf(self, "MsgActorReactionsPreset") then
					exec(self, obj, id, stacks)
				end
				
				if self:VerifyReaction("StatusEffectAdded", reaction_def, obj, obj, id, stacks) then
					exec(self, obj, id, stacks)
				end
			end,
			HandlerCode = function (self, obj, id, stacks)
				if IsKindOf(obj, "Unit") then
					obj:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
		}),
		PlaceObj('MsgActorReaction', {
			ActorParam = "unit",
			Event = "UnitBeginTurn",
			Handler = function (self, unit)
				
				local function exec(self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
				end
				
				if not IsKindOf(self, "MsgReactionsPreset") then return end
				
				local reaction_def = (self.msg_reactions or empty_table)[2]
				if not reaction_def or reaction_def.Event ~= "UnitBeginTurn" then return end
				
				if not IsKindOf(self, "MsgActorReactionsPreset") then
					exec(self, unit)
				end
				
				if self:VerifyReaction("UnitBeginTurn", reaction_def, unit, unit) then
					exec(self, unit)
				end
			end,
			HandlerCode = function (self, unit)
				if IsKindOf(unit, "Unit") then
					unit:ConsumeAP(-self:ResolveValue("ap_loss") * const.Scale.AP)
				end
			end,
		}),
	},
	DisplayName = T(497878015648, --[[ModItemCharacterEffectCompositeDef Suppressed DisplayName]] "Suppressed"),
	Description = T(594631976836, --[[ModItemCharacterEffectCompositeDef Suppressed Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn. This character cannot <color EmStyle>Flank</color> enemies."),
	AddEffectText = T(776408433487, --[[ModItemCharacterEffectCompositeDef Suppressed AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	type = "Debuff",
	lifetime = "Until End of Turn",
	Icon = "UI/Hud/Status effects/suppressed",
	RemoveOnEndCombat = true,
}

