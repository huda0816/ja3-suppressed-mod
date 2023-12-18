function OnMsg.DamageDone(attacker, target, dmg, hit_descr)
    if not attacker or not target then
        return
    end

    local weapon = attacker:GetActiveWeapons()

    if IsKindOf(weapon, "Mortar") then
        SuppressionMeter:CalculateMortarSuppression(attacker, target, hit_descr, weapon)
    end
end

function OnMsg.CombatStart()
    SuppressionMeter:InitSuppression()
end

function OnMsg.TurnStart(team)
    SuppressionMeter:ResetTeamSuppression(team)
end

function OnMsg.CombatEnd()
    SuppressionMeter:RemoveSuppression()
end

function OnMsg.OnAttack(attacker, action, target, results, attack_args)
    SuppressionMeter:DoSuppression(action, results, attack_args)
end

function OnMsg.StatusEffectAdded(unit, id)
    if (id == "Suppressed") then
        SuppressionMeter:HandleVanillaSuppression(unit)
    end
end

DefineClass.SuppressionMeter = {
    MaxSuppressionRemoved = const.suppression_max_removed or 100,
    SuppressionMultiplier = SuppressedGetModOptions("suppression_multiplier", 100, "multiplier"),
    SuppressionAiMultiplier = SuppressedGetModOptions("suppression_ai_multiplier", 100, "multiplier"),
    SuppressionPlayerMultiplier = SuppressedGetModOptions("suppression_player_multiplier", 100, "multiplier"),
    SuppressionResistanceMultiplier = const.suppression_resitance_multiplier or 100,
    TresholdShotAt = const.suppression_state_treshold_shot_at or 5,
    TresholdUnderFire = const.suppression_state_treshold_under_fire or 25,
    TresholdUnderHeavyFire = const.suppression_state_treshold_under_heavy_fire or 50,
    TresholdSuppressedCustom = const.suppression_state_treshold_suppressed_custom or 75,
    TresholdPinnedDown = const.suppression_state_treshold_pinned_down or 100,
    ArmorResistanceMultiplier = const.suppression_armor_resistance_multiplier or 100,
    VanillaSuppressionValue = const.suppression_vanilla_value or 10,
    RemovedApPerLevel = const.suppression_consumed_ap_per_level or 2,
    TestMode = const.suppression_test_mode or false
}

function SuppressionMeter:UpdateProps(prop_name, value)
    local property_name = prop_name:gsub("suppressed", ""):gsub("_%l", string.upper):gsub("^%l", string.upper):gsub("_",
        "")

    self[property_name] = value and tonumber(value) or 100
end

function SuppressionMeter:HandleVanillaSuppression(unit)
    unit.suppression_meter = self:ApplySuppression(unit, self.VanillaSuppressionValue)

    self:ApplySuppressionStatus(unit)

    self:HandleSuppression(unit)
end

function SuppressionMeter:InitSuppression()
    local units = table.ifilter(g_Units, function(k, v)
        return v.HireStatus ~= "Dead"
    end)

    for _, unit in ipairs(units) do
        unit.suppression_meter = unit.suppression_meter or 0

        unit.suppression_resistance = self:CalculateSuppressionResistance(unit)
    end
end

function SuppressionMeter:RemoveSuppression()
    local units = table.ifilter(g_Units, function(k, v)
        return v.HireStatus ~= "Dead"
    end)

    for _, unit in ipairs(units) do
        unit.suppression_meter = 0
    end
end

function SuppressionMeter:ResetTeamSuppression(team, forced)
    if g_Teams and g_Teams[team] then
        local units = table.ifilter(g_Teams[team].units, function(k, v)
            return v.HireStatus ~= "Dead"
        end)

        for _, unit in ipairs(units) do
            if self.TestMode then
                unit:GodMode("invulnerable", true)
            end

            if not unit.team.player_team then
                self:SpecialAIRules(unit)
            end

            if unit:HasStatusEffect("Suppressed") then
                unit:RemoveStatusEffect("Suppressed")
            end

            unit.suppression_resistance = self:CalculateSuppressionResistance(unit)

            if forced then
                unit.suppression_meter = 0
            else
                unit.suppression_meter = Min(
                    Max((unit.suppression_meter or 0) - Max(15, (unit.suppression_resistance * 3)), 0), 200)
            end

            self:ApplySuppressionStatus(unit)

            if (unit.suppression_meter > 0) then
                self:HandleSuppression(unit)
            end
        end
    end
end

function SuppressionMeter:PanicRoll(obj, suppression_treshold)
    local suppression = obj.suppression_meter -- 150

    if (suppression < suppression_treshold) then
        return false
    end

    if (obj:HasStatusEffect("Panicked")) then
        return false
    end

    if (obj:HasStatusEffect("Berserk")) then
        return false
    end

    if (obj.StatusEffectImmunity["Suppressed"]) then
        return false
    end

    local level = obj:GetLevel()

    local panick_roll = obj:Random(100)

    return panick_roll < (suppression - suppression_treshold - level * 5)
end

function SuppressionMeter:GoProneRoll(obj)
    local suppression = obj.suppression_meter -- 150

    if (suppression < 20) then
        return false
    end

    if (obj:HasStatusEffect("Berserk")) then
        return false
    end

    if obj:IsThreatened(obj, 'pindown') then
        return false
    end

    if obj:IsThreatened(obj, 'melee') then
        return false
    end

    if not obj.team.player_team and obj:IsThreatened(obj, 'overwatch') then
        return false
    end

    local go_prone_roll = obj:Random(100)

    return go_prone_roll < suppression
end

-- if you are armored you feel safer
-- armorlevel is unarmored, lightly armored, amored and heavyly armored
-- armor_cover is 1, 2 and 3
-- someone who has an armor_cover of 3 and is heavyly armored has a resistance of 30
function SuppressionMeter:CalculateArmorSuppressionResistance(target)
    local armour_items = target:GetEquipedArmour()

    if #armour_items < 1 then
        return 0
    end

    local head_armor = table.find_value(armour_items, "Slot", "Head") or false;

    local body_armor = table.find_value(armour_items, "Slot", "Torso") or false;

    local leg_armor = table.find_value(armour_items, "Slot", "Legs") or false;

    local equipped_items = table.ifilter({ head_armor, body_armor, leg_armor }, function(k, v)
        return v
    end)

    if #equipped_items < 1 then
        return 0
    end

    local armor_points = 0

    local slot_modifiers = {
        ["Head"] = 1,    -- 90
        ["Torso"] = 1.2, -- 108
        ["Legs"] = 0.5   -- 45
    }

    local cover = 0

    for _, item in ipairs(equipped_items) do
        local condition = item.RevertConditionCounter and item.RevertConditionCounter > 0 and 100 or item.Condition or
            100

        if condition > 40 then
            cover = cover + 1
        end

        local sum = item:GetSumDamageReduction() or 0;

        armor_points = armor_points + (sum * slot_modifiers[item.Slot] * condition) / 100
    end

    local armor_suppression_resistance = 0

    if armor_points > 200 then
        armor_suppression_resistance = 9
    elseif armor_points > 100 then
        armor_suppression_resistance = 6
    elseif armor_points > 50 then
        armor_suppression_resistance = 3
    end

    armor_suppression_resistance = armor_suppression_resistance + 7 * cover

    armor_suppression_resistance = (armor_suppression_resistance * self.ArmorResistanceMultiplier) / 100

    return armor_suppression_resistance
end

function SuppressionMeter:SpecialAIRules(target)
    if target:HasStatusEffect("Berserk") then
        return
    end

    local total_ap = target.ActionPoints + target.free_move_ap

    target.suppression_level = target.suppression_level or 0

    --remove all ap if there are not enough ap to do something which makes sense
    if (target:IsThreatened(nil, 'overwatch') and target.suppression_level >= 4) or target.suppression_level > 4 then
        target:SetActionCommand("ChangeStance", nil, nil, "Prone")
        target:ConsumeAP(target.free_move_ap)
        target:ConsumeAP(target.ap)
    end

    -- if target:IsThreatened(target, 'pindown') then

    -- end

    -- if target:IsThreatened(target, 'overwatch') then

    -- end

    -- if target:IsThreatened(target, 'melee') then

    -- end
end

function SuppressionMeter:HandleSuppression(target)
    if target.HireStatus == "Dead" then
        return
    end

    if not g_Combat then
        return
    end

    local suppression_level = target.suppression_level or 0

    local old_suppression_level = target.old_suppression_level or 0

    local consumed_ap = (suppression_level - old_suppression_level) * self.RemovedApPerLevel

    if consumed_ap > 0 then
        target:ConsumeAP(consumed_ap * const.Scale.AP)
    end

    if self:PanicRoll(target, 100) then
        target:GainAP(12 * const.Scale.AP)
        target:AddStatusEffect("Panicked")
        return
    elseif self:PanicRoll(target, 120) then
        target:RemoveStatusEffect("PinnedDown")
        target:RemoveStatusEffect("SuppressedCustom")
        target:RemoveStatusEffect("UnderFire")
        target:RemoveStatusEffect("UnderHeavyFire")
        target:RemoveStatusEffect("ShotAt")
        target:GainAP(12 * const.Scale.AP)
        target.suppression_level = 0
        target.suppression_meter = 0
        target:AddStatusEffect("Berserk")
    else
        if not target.team.player_team then
            self:SpecialAIRules(target)
        end

        if target.stance ~= "Prone" then
            local go_prone = self:GoProneRoll(target)

            if go_prone then
                target:SetActionCommand("ChangeStance", nil, nil, "Prone")
            end
        end
    end
end

function SuppressionMeter:CalculateSuppressionResistance(target, test, not_armor)
    -- DieselPerk / ZombiePerk
    local target_is_immune = target.StatusEffectImmunity["Suppressed"] and true or false

    if target_is_immune then
        return 100
    end

    local morale = target:GetPersonalMorale()

    local resistance = Min(target:GetLevel() * 5, 50)

    if (target:HasStatusEffect("Berserk")) then
        resistance = resistance + 50
    elseif (HasPerk(target, "Psycho")) then
        resistance = resistance + 30
    end

    if not not_armor then
        local armor_resistance = self:CalculateArmorSuppressionResistance(target)

        resistance = resistance + armor_resistance
    end

    -- removed as it was to much
    -- if vanilla status suppressed is applied the suppression resistance is lowered
    -- if (target:HasStatusEffect("Suppressed")) then
    --     resistance = resistance - 10
    -- end

    if (target:HasStatusEffect("Inspired")) then
        resistance = resistance + 20
    end

    if (target:HasStatusEffect("Panicked")) then
        resistance = resistance - 20
    end

    local health_percentage = 100

    if not test then
        health_percentage = target:GetHealthPercentage()
    end

    local base_healt = target.base_Health

    local current_health = (base_healt * health_percentage) / 100.0

    local thresholds = { 50, 70, 90 }
    local resistance_increase = 5

    for i = 1, #thresholds do
        if current_health > thresholds[i] then
            resistance = resistance + resistance_increase * i
            break -- Exit the loop once the condition is met
        end
    end

    local thresholds = { 60, 40, 20 }
    local resistance_decrease = 10

    for i = 1, #thresholds do
        if health_percentage < thresholds[i] then
            resistance = resistance - resistance_decrease * i
            break -- Exit the loop once the condition is met
        end
    end

    resistance = resistance + (morale * 10)

    resistance = (resistance * self.SuppressionResistanceMultiplier) / 100

    return Min(Max(resistance, 0), 100)
end

function SuppressionMeter:ApplySuppression(obj, added_supp, attacker)
    obj.suppression_resistance = obj.suppression_resistance or self:CalculateSuppressionResistance(obj) or 0

    local suppression_resistance = obj.suppression_resistance

    -- add 50% suppression resistance if using this combat action
    if obj:HasStatusEffect("Protected") then
        suppression_resistance = suppression_resistance + 40
    end

    if self:CheckIfSameSide(obj, attacker) then
        suppression_resistance = suppression_resistance + 40
    end

    -- add 20% suppression resistance if not in combat as he cannot fear what he cannot see
    if not g_Combat then
        suppression_resistance = suppression_resistance + 20
    end

    added_supp = MulDivRound(added_supp, 100 - suppression_resistance, 100)

    added_supp = (added_supp * self.SuppressionMultiplier) / 100

    if obj.team and obj.team.player_team then
        added_supp = (added_supp * self.SuppressionPlayerMultiplier) / 100
    else
        added_supp = (added_supp * self.SuppressionAiMultiplier) / 100
    end

    local rounded_suppression = Max(0, added_supp)

    return (obj.suppression_meter or 0) + rounded_suppression, rounded_suppression, suppression_resistance
end

function SuppressionMeter:LogToSnype(target, attacker, added_supp, near_miss, is_target, bruttosupp,
                                     suppression_resistance)
    local targetName = target:GetDisplayName()

    local attackerName = attacker:GetDisplayName()

    local suppression = (target.suppression_meter or 0) + added_supp

    local hit = near_miss and "not directly hit" or "directly hit"



    CombatLog("debug", T({
        Untranslated("<em>-----------</em>")
    }))
    CombatLog("debug", T({
        Untranslated(
            "<em><attacker></em> inflicted <em><suppression>%</em> additional suppression on <em><target></em> (without modifiers: <em><bruttosupp>%</em>)"),
        target = targetName,
        attacker = attackerName,
        suppression = added_supp,
        bruttosupp = bruttosupp
    }))
    CombatLog("debug", T({
        Untranslated("<em><target></em> had <em><resistance>%</em> suppression resistance and was <hit>"),
        target = targetName,
        resistance = suppression_resistance,
        hit = hit
    }))
    if not is_target then
        CombatLog("debug", T({
            Untranslated("<em><target></em> was not the target of the attack"),
            target = targetName
        }))
    end
    CombatLog("debug", T({
        Untranslated("<em><target>'s</em> total suppression is <em><suppression>%</em>"),
        target = targetName,
        suppression = suppression
    }))
    CombatLog("debug", T({
        Untranslated("Modifier <em><modifier></em> PModifier <em><pmodifier></em> AIModifier <em><aimodifier></em>"),
        modifier = self.SuppressionMultiplier,
        pmodifier = self.SuppressionPlayerMultiplier,
        aimodifier = self.SuppressionAiMultiplier
    }))
    CombatLog("debug", T({
        Untranslated("<em>-----------</em>")
    }))
end

function SuppressionMeter:ApplySuppressionStatus(target)
    target.old_suppression_level = target.suppression_level or 0

    target.suppression_level = 0

    if (target.suppression_meter > self.TresholdPinnedDown) then
        target.suppression_level = 5

        if not target:HasStatusEffect("PinnedDown") then
            target:RemoveStatusEffect("SuppressedCustom")
            target:RemoveStatusEffect("UnderFire")
            target:RemoveStatusEffect("UnderHeavyFire")
            target:RemoveStatusEffect("ShotAt")
            target:AddStatusEffect("PinnedDown")
        end
    elseif (target.suppression_meter > self.TresholdSuppressedCustom) then
        target.suppression_level = 4

        if not target:HasStatusEffect("SuppressedCustom") then
            target:RemoveStatusEffect("PinnedDown")
            target:RemoveStatusEffect("UnderFire")
            target:RemoveStatusEffect("UnderHeavyFire")
            target:RemoveStatusEffect("ShotAt")
            target:AddStatusEffect("SuppressedCustom")
        end
    elseif (target.suppression_meter > self.TresholdUnderHeavyFire) then
        target.suppression_level = 3

        if not target:HasStatusEffect("UnderHeavyFire") then
            target:RemoveStatusEffect("PinnedDown")
            target:RemoveStatusEffect("SuppressedCustom")
            target:RemoveStatusEffect("UnderFire")
            target:RemoveStatusEffect("ShotAt")
            target:AddStatusEffect("UnderHeavyFire")
        end
    elseif (target.suppression_meter > self.TresholdUnderFire) then
        target.suppression_level = 2

        if not target:HasStatusEffect("UnderFire") then
            target:RemoveStatusEffect("PinnedDown")
            target:RemoveStatusEffect("SuppressedCustom")
            target:RemoveStatusEffect("UnderHeavyFire")
            target:RemoveStatusEffect("ShotAt")
            target:AddStatusEffect("UnderFire")
        end
    elseif (target.suppression_meter > self.TresholdShotAt) then
        target.suppression_level = 1

        if not target:HasStatusEffect("ShotAt") then
            target:RemoveStatusEffect("PinnedDown")
            target:RemoveStatusEffect("SuppressedCustom")
            target:RemoveStatusEffect("UnderFire")
            target:RemoveStatusEffect("UnderHeavyFire")
            target:AddStatusEffect("ShotAt")
        end
    else
        target.suppression_level = 0

        target:RemoveStatusEffect("PinnedDown")
        target:RemoveStatusEffect("SuppressedCustom")
        target:RemoveStatusEffect("UnderFire")
        target:RemoveStatusEffect("UnderHeavyFire")
        target:RemoveStatusEffect("ShotAt")
    end
end

function SuppressionMeter:CalculateSuppression(obj, action, results, attack_args, is_near_miss, is_target)
    local weapon = attack_args.weapon

    local suppression = 0

    if IsKindOf(weapon, "Grenade") then
        suppression = self:CalculateExplosivesSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    elseif IsKindOfClasses(weapon, "Unarmed", "ThrowableKnife", "MeleeWeapon") then
        suppression = self:CalculateMeleeSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    elseif IsKindOfClasses(weapon, "MachineGun", "SniperRifle", "AssaultRifle", "SubmachineGun", "Pistol", "Revolver",
            "Shotgun") then
        suppression = self:CalculateFireArmsSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    elseif IsKindOfClasses(weapon, "HeavyWeapon") then
        suppression = self:CalculateHeavyWeaponSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    end

    local new_suppression, added_suppression, suppression_resistance = self:ApplySuppression(obj, suppression,
        attack_args.obj)

    self:LogToSnype(obj, attack_args.obj, added_suppression, is_near_miss, is_target, suppression, suppression_resistance)

    return new_suppression
end

function SuppressionMeter:CalculateAOESuppression(aoe, caoe, obj, results, suppression_value)
    local radius = (aoe + caoe) * const.SlabSizeX

    local distance = obj:GetDist(results.explosion_pos or results.target_pos)

    local distance_percent = distance / (radius / 100)

    return Max((suppression_value * (100 - distance_percent)) / 200, 0) + suppression_value / 2
end

function SuppressionMeter:CalculateExplosivesSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    local weapon_suppression_value = weapon.SuppressionValue or SUPPWeaponSuppressionValues[weapon.class] or 0

    return self:CalculateAOESuppression(weapon.AreaOfEffect, weapon.CenterAreaOfEffect, obj, results,
        weapon_suppression_value)
end

function SuppressionMeter:CalculateFireArmsSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    local max_range = weapon.WeaponRange * 1000

    local target_dist = obj:GetDist(attack_args.obj)

    local distance_percent = target_dist / (max_range / 100)

    local rangeModifier = self:GetEffectiveSuppression(distance_percent)

    local weapon_suppression_value = weapon.SuppressionValue or SUPPWeaponSuppressionValues[weapon.class] or
        SUPPWeaponSuppressionValues[weapon.object_class] or 0

    local attack_type_suppression_bonus = action.SuppressionValue or SUPPCombatActionSuppressionBonus[action.id] or 0

    local suppression = attack_type_suppression_bonus * 1000

    local base = 1.1
    local exponent = 0
    local exponentIncrement = 0.53

    weapon_suppression_value = weapon_suppression_value * 1000

    for _, shot in ipairs(results.shots) do
        local result = base ^ exponent

        local shot_effectiveness_percent = Max(100 - (result - 1) * 100, 0)

        if shot_effectiveness_percent < 0 then

        else
            local shot_suppression = MulDivRound(weapon_suppression_value, shot_effectiveness_percent, 100)

            if shot.hits and #shot.hits > 0 and shot.hits[1].obj == obj then

            else -- shot_suppression = MulDivRound(shot_suppression, 75, 100)
                shot_suppression = Max(shot_suppression - MulDivRound(weapon_suppression_value, 50, 100), 0)
            end

            suppression = suppression + shot_suppression
        end

        exponent = exponent + exponentIncrement
    end

    local max_range = weapon.WeaponRange * 1000

    local target_dist = obj:GetDist(attack_args.obj)

    local distance_percent = target_dist / (max_range / 100)

    if (distance_percent > 200) then
        suppression = 0
    elseif (distance_percent > 100) then
        suppression = MulDivRound(suppression, Max(0, 100 - (distance_percent - 100)), 100)
    end

    suppression = MulDivRound(suppression, rangeModifier, 100)

    return DivRound(suppression, 1000)
end

-- just weapon + attack type suppression which are both 0 by default
function SuppressionMeter:CalculateMeleeSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    local weapon_suppression_value = weapon.SuppressionValue or SUPPWeaponSuppressionValues[weapon.class] or 0

    local attack_type_suppression_bonus = action.SuppressionValue or SUPPCombatActionSuppressionBonus[action.id] or 0

    return weapon_suppression_value + attack_type_suppression_bonus
end

-- suppression is based on the fired projectiles
function SuppressionMeter:CalculateHeavyWeaponSuppression(weapon, obj, action, results, attack_args, is_near_miss)
    if IsKindOfClasses(weapon, "GrenadeLauncher", "RocketLauncher") then
        local ordnance = results.ordnance

        local suppression_value = ordnance.SuppressionValue or SUPPWeaponSuppressionValues[ordnance.class] or 0

        return self:CalculateAOESuppression(ordnance.AreaOfEffect, ordnance.CenterAreaOfEffect, obj, results,
            suppression_value)
    end

    if IsKindOf(weapon, "Mortar") then
        --nothing to see here
    end

    return 10
end

function SuppressionMeter:CalculateMortarSuppression(attacker, target, hit_descr, weapon)
    local ordnance = weapon.ammo

    local suppression = ordnance.SuppressionValue or SUPPWeaponSuppressionValues[ordnance.class] or 0

    if not hit_descr.explosion_center then
        suppression = suppression * 2 / 3
    end

    local new_suppression, added_suppression = self:ApplySuppression(target, suppression, attacker)

    self:LogToSnype(target, attacker, added_suppression, false, false)

    target.suppression_meter = new_suppression

    self:ApplySuppressionStatus(target)

    self:HandleSuppression(target)
end

function SuppressionMeter:DoSuppression(action, results, attack_args)
    local target = attack_args.target

    local attacker = attack_args.obj

    local hit_objs = table.filter(results.hit_objs, function(k, v)
        return v ~= target and k ~= "target" and IsKindOf(v, "Unit")
    end)

    local close_units = self:GetCloseUnits(target, attacker)

    if IsKindOf(target, "Unit") then
        table.insert(close_units, target)
    end

    if close_units and #close_units > 0 then
        for _, unit in ipairs(close_units) do
            local is_near_miss = false
            local is_hit = true

            if table.find(hit_objs, unit) or unit == target then
                -- print("is_hit", unit.session_id)
            else
                is_hit = false
                is_near_miss = self:IsNearMiss(results, attack_args, unit)
            end

            if is_hit or is_near_miss then
                unit.suppression_meter = self:CalculateSuppression(unit, action, results, attack_args,
                    is_near_miss, false)

                self:ApplySuppressionStatus(unit)

                self:HandleSuppression(unit)
            end
        end
    end
end

function SuppressionMeter:GetCloseUnits(target, attacker)
    local units = g_Units

    units = table.ifilter(units, function(k, v)
        return v.HireStatus ~= "Dead" and v.session_id ~= target.session_id and v.session_id ~= attacker.session_id
    end)

    local close_units = {}

    for _, unit in ipairs(units) do
        -- TODO: add variable for close distance
        if unit:GetDist(target) < 10000 then
            table.insert(close_units, unit)
        end
    end

    return close_units
end

function SuppressionMeter:CheckIfSameSide(attacker, target)
    if not target or not attacker then
        return false
    end

    if attacker.team.player_team and target.team.player_team then
        return true
    end

    if attacker.team.player_enemy and target.team.player_enemy then
        return true
    end

    if attacker.team.player_ally and target.team.player_ally then
        return true
    end

    if attacker.team.player_ally and target.team.player_team then
        return true
    end

    if attacker.team.player_team and target.team.player_ally then
        return true
    end

    return false
end

function SuppressionMeter:IsNearMiss(results, attack_args, target)
    local attacker = attack_args.obj

    if IsValidTarget(target) then
        local slab_size = const.SlabSizeX
        local dist_stuckpos_to_target = 100 * slab_size
        local dist_stuckpos_to_attacker = 0
        local dist_target_to_attacker = attacker:GetDist(target)

        if self:CheckIfSameSide(attacker, target) and dist_target_to_attacker <= slab_size * 3 then
            return false
        end

        for _, shot in ipairs(results.shots) do
            local new_dist_to_target = 1000 * slab_size

            if shot.miss then
                new_dist_to_target = target:GetDist(shot.stuck_pos)
            else
                local first_hit = shot.hits[1]

                if first_hit then
                    new_dist_to_target = target:GetDist(first_hit.pos)
                else
                    new_dist_to_target = target:GetDist(shot.target_pos)
                end
            end

            if new_dist_to_target < dist_stuckpos_to_target then
                dist_stuckpos_to_target = new_dist_to_target

                if dist_stuckpos_to_target <= slab_size * 1.5 then
                    return true
                end

                if shot.miss then
                    dist_stuckpos_to_attacker = attacker:GetDist(shot.stuck_pos)
                else
                    local first_hit = shot.hits[1]

                    if first_hit then
                        dist_stuckpos_to_attacker = attacker:GetDist(first_hit.pos)
                    else
                        dist_stuckpos_to_attacker = attacker:GetDist(shot.target_pos)
                    end
                end

                local travel_distance = dist_stuckpos_to_target + dist_target_to_attacker

                if travel_distance <= dist_stuckpos_to_attacker + MulDivRound(slab_size, 75, 100) then
                    return true
                end
            end
        end
    end

    return false
end

-- Tests

function SuppressionMeter:CalcResistanceForAllUnits(global, merc, armor)
    print("I calculate the resistance for all units")

    if global then
        local units = gv_UnitData

        for _, unit in pairs(units) do
            if not unit.team then
                unit.team = g_Teams[1]
            end

            if not merc or unit.StartingSalary ~= 1000 then
                print("Resistance", unit.session_id, self:CalculateSuppressionResistance(unit, true, not armor))
            end
        end
    else
        local units = g_Units

        for _, unit in ipairs(units) do
            if not merc or string.find(unit.Portrait, "Mercs") then
                print("Resistance", unit.session_id, self:CalculateSuppressionResistance(unit, false, not armor))
            end
        end
    end
end

function SuppressionMeter:GetEffectiveSuppression(distance)
    local decayRate = 0.004
    local initial = 150

    local result = initial

    for d = 1, distance do
        result = result * (1 - decayRate)
    end

    return result
end
