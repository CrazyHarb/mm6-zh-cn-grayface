-- MM6: prevent the decoration count's adjacent flags from becoming a huge
-- 32-bit Count during map loading. The low 16 bits contain the real count.
-- Crash evidence: MM6+0xAF390 while comparing DecList entries.

local function normalizeDecListCount()
	if mem.u2[0x5E218A] ~= 0 then
		mem.u2[0x5E218A] = 0
	end
end

-- Both native loops read Count as a 32-bit value before comparing entries.
mem.autohook(0x43FAD0, normalizeDecListCount)
mem.autohook(0x456954, normalizeDecListCount)

function events.BeforeLoadMap()
	normalizeDecListCount()
end

function events.AfterLoadMap()
	normalizeDecListCount()
end
