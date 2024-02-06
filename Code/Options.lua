function SuppressedGetModOptions(id, default, type)
	id = "suppressed_" .. id

	if nil == CurrentModOptions then
		return default or 0
	end

	return SuppressedRemoveCommentsFromOptions(CurrentModOptions[id]) or const[id] or default or 0
end

function OnMsg.ApplyModOptions(mod_id)
	if mod_id == CurrentModId and CurrentModOptions then
		for k, v in pairs(CurrentModOptions) do
			if string.starts_with(k, "suppressed_") then
				SuppressionMeter:UpdateProps(k, SuppressedRemoveCommentsFromOptions(v))
			end
		end
	end
end

function SuppressedRemoveCommentsFromOptions(rawValue)
	-- remove everything after the first whitespace
	local value = string.gsub(rawValue, "%s.*", "")

	return value
end
