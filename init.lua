-- License: MIT

chatlog = {}
chatlog.modname = core.get_current_modname()

function chatlog.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. chatlog.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


chatlog.format = core.settings:get("chatlog.format") or "%m/%d/%y %X"

chatlog.out = minetest.get_worldpath() .. "/chatlog.txt"


local function playerspeak(name, msg)
	local f = io.open(chatlog.out, "a")
	if f then
		f:write(os.date("(" .. chatlog.format .. ") [" .. name .. "]: " .. msg .. "\n"))
		f:close()
	else
		chatlog.log("error", "could not open chatlog file for writing: " .. chatlog.out)
	end
end

minetest.register_on_chat_message(playerspeak)
