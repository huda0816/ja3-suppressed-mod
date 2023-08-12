UndefineClass('PinnedDown')
DefineClass.PinnedDown = {
	__parents = { "StatusEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	object_class = "StatusEffect",
	msg_reactions = {
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
	DisplayName = T(705794185892, --[[ModItemCharacterEffectCompositeDef PinnedDown DisplayName]] "Pinned Down"),
	Description = T(626021581178, --[[ModItemCharacterEffectCompositeDef PinnedDown Description]] "Penalty of <color EmStyle><ap_loss> is applied to your maximum AP</color> for this turn."),
	AddEffectText = T(786631920648, --[[ModItemCharacterEffectCompositeDef PinnedDown AddEffectText]] "<color EmStyle><DisplayName></color> is suppressed"),
	type = "Debuff",
	lifetime = "Until End of Turn",
	Icon = "Mod/ANKmKG/Icons/suppression5.png",
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

