-- License: MIT

chatlog = minetest.get_worldpath() .. "/chatlog.txt"

chatlog.format = core.settings:get("chatlog.format") or "%m/%d/%y %X"

function playerspeak(name, msg)
	local f = io.open(chatlog, "a")
	f:write(os.date("(" .. chatlog.format .. ") [" .. name .. "]: " .. msg .. "\n"))
	f:close()
end

minetest.register_on_chat_message(playerspeak)
