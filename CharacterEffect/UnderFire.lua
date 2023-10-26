UndefineClass('UnderFire')
DefineClass.UnderFire = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {
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
				
				local reaction_def = (self.msg_reactions or empty_table)[1]
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
	DisplayName = T(989455125648, --[[ModItemCharacterEffectCompositeDef UnderFire DisplayName]] "Under Fire"),
	Description = T(390089603814, --[[ModItemCharacterEffectCompositeDef UnderFire Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	AddEffectText = T(780311442123, --[[ModItemCharacterEffectCompositeDef UnderFire AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	type = "Debuff",
	Icon = "Mod/ANKmKG/Icons/suppression2.png",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

