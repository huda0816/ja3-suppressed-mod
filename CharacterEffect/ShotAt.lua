UndefineClass('ShotAt')
DefineClass.ShotAt = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {
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
		}),
	},
	DisplayName = T(961066146746, --[[ModItemCharacterEffectCompositeDef ShotAt DisplayName]] "Shot At"),
	Description = T(409582181554, --[[ModItemCharacterEffectCompositeDef ShotAt Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	AddEffectText = T(267598568608, --[[ModItemCharacterEffectCompositeDef ShotAt AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	type = "Debuff",
	Icon = "Mod/ANKmKG/Icons/suppression1.png",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

