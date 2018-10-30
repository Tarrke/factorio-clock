if not gclock then gclock = {} end

require("mod-gui")
require("trkcommon")

function gclock.mod_init()
	gclock.log("setting up mod data")
	
	for _,player in pairs(game.players) do
		gclock.create_button(player)
	end
end
		
-- Should we write some log for player ?
function gclock.show_log(player)
	return true
    -- return settings.get_player_settings(player)["gclock-show-log"].value
end

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
			caption = "Game Clock"
		})
		
		button.style.visible = true
	end
end

function gclock.update_time()
	for _, player in pairs(game.players) do
		gclock.refresh_button(player)
	end
end

function gclock.refresh_button(player)
	if mod_gui.get_button_flow(player)["gclock_button"] then
		ticks = game.tick
		secs = ticks / 60
		mins = ((secs - secs%60) / 60) % 60
		hrs = secs / 3600
		s = string.format("%02d:%02d:%02d", hrs, mins, secs%60)
		mod_gui.get_button_flow(player)["gclock_button"].caption = s
	end
end