function SuppressedGetModOptions(id, default, type)
	id = "suppressed_" .. id

	return CurrentModOptions[id] or const[id] or default or 0
end

function OnMsg.ApplyModOptions(mod_id)
	if CurrentModOptions then
		for k, v in pairs(CurrentModOptions) do
			if string.starts_with(k, "suppressed_") then
				SuppressionMeter:UpdateProps(k, v)
			end
		end
	end
end

-- Zulib or slider mod from audaki_ra has to be active for that
if Zulib.setupModSlider then
	Zulib.setupModSlider({
	  modId = CurrentModId,
	  optionId = 'suppressed_suppression_ai_multiplier',
	  displayType = 'value',
	  displayPostfix = '%',
	})

	Zulib.setupModSlider({
	  modId = CurrentModId,
	  optionId = 'suppressed_suppression_player_multiplier',
	  displayType = 'value',
	  displayPostfix = '%',
	})
end