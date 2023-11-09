function SuppressedGetModOptions(id, default, type)
	id = "suppressed_" .. id

	if not CurrentModOptions then
		return default or 0
	end

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