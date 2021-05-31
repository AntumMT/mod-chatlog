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
chatlog.single_file = core.settings:get_bool("chatlog.single_file", false)

chatlog.out = minetest.get_worldpath() .. "/chatlog"
if chatlog.single_file then
	chatlog.out = chatlog.out .. ".txt"
end


local function playerspeak(name, msg)
	local out_file = chatlog.out
	if not chatlog.single_file then
		-- make sure directory exists
		if not core.mkdir(chatlog.out) then
			chatlog.log("error", "could not create directory for writing: " .. chatlog.out)
			return
		end

		out_file = chatlog.out .. "/" .. os.date("%Y_%m_%d") .. ".txt"
	end

	if not core.safe_file_write(out_file,
			os.date("(" .. chatlog.format .. ") [" .. name .. "]: " .. msg .. "\n")) then
		chatlog.log("error", "could not open chatlog file for writing: " .. out_file)
	end
end

minetest.register_on_chat_message(playerspeak)
