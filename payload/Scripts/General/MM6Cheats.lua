-- MM6 console cheats: god(), mana(), nocd(), buff(), learn(), immune()
-- Toggles last for the current process; they are not written into save files.

local enabled = {hp = false, sp = false, cd = false, immune = false}

local function refillHP(pl)
	pl.HP = pl:GetFullHP()
end

local function refillSP(pl)
	pl.SP = pl:GetFullSP()
end

local function clearConditions(pl)
	for c = 0, const.Condition.Eradicated do
		pl.Conditions[c] = 0
	end
end

local function report(text)
	print(text)
	return text
end

function god()
	enabled.hp = not enabled.hp
	if enabled.hp then
		for _, pl in Party.PlayersArray do
			refillHP(pl)
		end
	end
	return report("Infinite HP: "..(enabled.hp and "ON" or "OFF"))
end

function mana()
	enabled.sp = not enabled.sp
	if enabled.sp then
		for _, pl in Party.PlayersArray do
			refillSP(pl)
		end
	end
	return report("Infinite SP: "..(enabled.sp and "ON" or "OFF"))
end

function nocd()
	enabled.cd = not enabled.cd
	if enabled.cd then
		for _, pl in Party.PlayersArray do
			pl.RecoveryDelay = 0
		end
	end
	return report("No attack cooldown: "..(enabled.cd and "ON" or "OFF"))
end

local compoundPartyBuffs = {
	const.PartyBuff.FireResistance,
	const.PartyBuff.ColdResistance,
	const.PartyBuff.ElecResistance,
	const.PartyBuff.MagicResistance,
	const.PartyBuff.PoisonResistance,
	const.PartyBuff.FeatherFall,
	const.PartyBuff.GuardianAngel,
	const.PartyBuff.WizardEye,
}
local singlePartyBuffs = {
	const.PartyBuff.TorchLight,
	const.PartyBuff.Fly,
	const.PartyBuff.WaterWalk,
}
local playerBuffs = {
	const.PlayerBuff.Bless,
	const.PlayerBuff.Heroism,
	const.PlayerBuff.Haste,
	const.PlayerBuff.Shield,
	const.PlayerBuff.Stoneskin,
	const.PlayerBuff.TempLuck,
	const.PlayerBuff.TempIntellect,
	const.PlayerBuff.TempPersonality,
	const.PlayerBuff.TempAccuracy,
	const.PlayerBuff.TempSpeed,
	const.PlayerBuff.TempMight,
	const.PlayerBuff.TempEndurancy,
}

local function setBuff(b, power, expireTime)
	b.ExpireTime = expireTime
	b.Power = power
	b.Skill = const.Master
	b.OverlayId = 0
	b.Caster = 0
	b.Bits = 0
end

function buff()
	if Game.CurrentScreen ~= 0 then
		return report("Full buffs: load a game first")
	end
	local expireTime = Game.Time + const.Day
	-- Master compound spells at skill 10 use Power 40; single spells use 10.
	for _, id in ipairs(compoundPartyBuffs) do
		setBuff(Party.SpellBuffs[id], 40, expireTime)
	end
	for _, id in ipairs(singlePartyBuffs) do
		setBuff(Party.SpellBuffs[id], 10, expireTime)
	end
	for _, pl in Party.PlayersArray do
		for _, id in ipairs(playerBuffs) do
			setBuff(pl.SpellBuffs[id], 40, expireTime)
		end
	end
	return report("Full buffs applied for 24 game hours")
end

local masterSkills = {
	const.Skills.Staff,
	const.Skills.Sword,
	const.Skills.Dagger,
	const.Skills.Axe,
	const.Skills.Spear,
	const.Skills.Bow,
	const.Skills.Mace,
	const.Skills.Blaster,
	const.Skills.Fire,
	const.Skills.Air,
	const.Skills.Water,
	const.Skills.Earth,
	const.Skills.Spirit,
	const.Skills.Mind,
	const.Skills.Body,
	const.Skills.Light,
	const.Skills.Dark,
}

function learn()
	for _, pl in Party.PlayersArray do
		for _, skill in ipairs(masterSkills) do
			pl.Skills[skill] = const.Master
		end
		for spell = 0, 99 do
			pl.Spells[spell] = true
		end
	end
	return report("Weapon and magic skills mastered; all spells learned")
end

function immune()
	enabled.immune = not enabled.immune
	if enabled.immune then
		for _, pl in Party.PlayersArray do
			clearConditions(pl)
		end
	end
	return report("Negative-condition immunity: "..(enabled.immune and "ON" or "OFF"))
end

function events.CalcDamageToPlayer(t)
	if enabled.hp then
		t.Result = 0
	end
end

function events.GetAttackDelay(t)
	if enabled.cd then
		t.Result = 0
	end
end

function events.Tick()
	if not (enabled.hp or enabled.sp or enabled.cd or enabled.immune) then
		return
	end
	for _, pl in Party.PlayersArray do
		if enabled.hp then
			refillHP(pl)
		end
		if enabled.sp then
			refillSP(pl)
		end
		if enabled.cd then
			pl.RecoveryDelay = 0
		end
		if enabled.immune then
			clearConditions(pl)
		end
	end

end
