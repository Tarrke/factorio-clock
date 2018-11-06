if not gclock then gclock = {} end

require("mod-gui")
require("trkcommon")

function gclock.mod_init()
	gclock.log("setting up mod data")
	if not global.gclock then
		global.gclock = {}
		gclock.reset_chrono()
	end
	for _,player in pairs(game.players) do
		gclock.create_button(player)
	end
end

-- Should we write some log for player ?
function gclock.show_log(player)
    return settings.get_player_settings(player)["gclock-show-log"].value
end

-- Wrap function to write logs with a header and control
function gclock.log(message)
	trk.log("gClock: " .. message, gclock.show_log)
end

-- Creating Button for display
function gclock.create_button(player)
	gclock.log("Creating UI button for player " .. player.name)

	if mod_gui.get_button_flow(player)["gclock_button"] == nil then
		local button = mod_gui.get_button_flow(player).add({
			type = "button",
			name = "gclock_button",
			caption = "Game Clock",
			style = "gclock_button_default"
		})
		button.style.visible = true
	end

	if mod_gui.get_button_flow(player)["gclock_chrono"] == nil then
		local chrono = mod_gui.get_button_flow(player).add({
			type = "button",
			name = "gclock_chrono",
			capton = "Click to start",
			style = "gclock_button_green"
		})
		chrono.style.visible = true
	end
end

-- Update the clock for all players
function gclock.update_time()
	for _, player in pairs(game.players) do
		gclock.refresh_button(player)
	end
end

-- Update current player button caption
function gclock.refresh_button(player)
	local button = mod_gui.get_button_flow(player)["gclock_button"]
	if button then
		-- TODO: use gclock.convert_ticks
		ticks = game.tick
		secs = ticks / 60
		mins = ((secs - secs%60) / 60) % 60
		hrs = secs / 3600
		s = string.format("%02d:%02d:%02d", hrs, mins, secs%60)
		button.caption = s
	end
	local chrono = mod_gui.get_button_flow(player)["gclock_chrono"]
	if chrono then
		if global.gclock["chrono_start"] then
			if global.gclock["chrono_started"] then
				ticks = game.tick - global.gclock["chrono_start"] + global.gclock["chrono_elapsed"]
			else
				ticks = global.gclock["chrono_elapsed"]
			end
			hrs, mins, secs = gclock.convert_ticks(ticks)
			s = string.format("%02d:%02d:%02d", hrs, mins, secs%60)
			chrono.caption = s
		else
			gclock.log("No start tick...")
			chrono.caption = "Click to Start"
		end
	end
end

function gclock.convert_ticks(ticks)
	secs = ticks / 60
	mins = ((secs - secs%60) / 60) % 60
	hrs = secs / 3600
	return hrs, mins, secs
end

-- Reset the Chrono
function gclock.reset_chrono()
	global.gclock["chrono_start"] = nil
	global.gclock["chrono_started"] = nil
	global.gclock["chrono_elapsed"] = 0
end

-- callback function for gui clicks
function gclock.on_gui_click(event)
	gclock.log("Click on gui: " .. event.element.name .. " at tick " .. event.tick)
	if( event.element.name == "gclock_chrono") then
		-- Sets the chrono state. On left click fire up the chrono. On right click reset the timer
		if event.button == defines.mouse_button_type.right then
			gclock.reset_chrono()
		elseif event.button == defines.mouse_button_type.left then
			gclock.log("left click")
			if global.gclock["chrono_started"] then
				-- Stop the clock
				gclock.log("Should stop the chrono")
				global.gclock["chrono_started"] = false
				global.gclock["chrono_elapsed"] = global.gclock["chrono_elapsed"] + event.tick - global.gclock["chrono_start"]
			else
				gclock.log("Should start the chrono")
				global.gclock["chrono_start"] = event.tick
				global.gclock["chrono_started"] = true
				gclock.log("Sets chrono start tick at " .. global.gclock["chrono_start"])
			end
		end
	end
end