-- Direct MMExtension flight controls for keyboards without PageUp/PageDown.
-- Up/wheel: ascend or descend; Down: native Land command.

local wheelTicks = 0
local active = false
local verticalSpeed = 30

local function canFly()
	return Game.CurrentScreen == 0
		and Map.IsOutdoor()
		and Party.SpellBuffs[const.PartyBuff.Fly].ExpireTime > Game.Time
end

local function verticalStep(speed)
	if not canFly() then
		return false
	end
	Party.Flying = true
	Party.InAir = true
	Party.FlyingBit = true
	Party.SpeedZ = speed
	active = true
	return true
end

function events.KeyDown(t)
	if t.Key == const.Keys.UP then
		if verticalStep(verticalSpeed) then
			t.Key = 0
		end
	elseif t.Key == const.Keys.DOWN and (canFly() or Party.Flying) then
		wheelTicks = 0
		active = false
		Party.SpeedZ = 0
		Party.Flying = false
		Party.InAir = false
		mem.call(0x467A50, 1, 0x6A72A0, 15)
		t.Key = 0
	end
end

function events.WindowMessage(t)
	if t.Msg ~= 0x020A then
		return
	end
	local speed = (t.WParam < 0) and -verticalSpeed or verticalSpeed
	if verticalStep(speed) then
		wheelTicks = 6
		t.Handled = true
	end
end

function events.Tick()
	if not active then
		return
	end
	if not canFly() then
		wheelTicks = 0
		active = false
		Party.SpeedZ = 0
		return
	end
	if wheelTicks > 0 then
		wheelTicks = wheelTicks - 1
	end
	if wheelTicks == 0
		and not Keys.IsPressed(const.Keys.UP)
		and not Keys.IsPressed(const.Keys.DOWN) then
		Party.SpeedZ = 0
		active = false
	end
end
