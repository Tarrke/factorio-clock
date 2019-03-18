require("gclock/gameclock")


-- when creating a new game, initialize data structure
script.on_init(
function()
	gclock.mod_init()
end
)

-- When a player is joining, create the UI for them
script.on_event(defines.events.on_player_created, function(event)
	gclock.log("player created")
    local player = game.players[event.player_index]
    gclock.create_main_button(player)
    --gclock.create_chrono_button(player)
end)

-- if the version of the mod or any other version changed
script.on_configuration_changed(gclock.mod_init)

script.on_event(defines.events.on_tick, function(event)
    -- We just get track of time every seconds
    if (event.tick % 60 == 0) then
        gclock.update_time()
    end
end)

-- Register clicks on the GUI
script.on_event(defines.events.on_gui_click, function(event)
    gclock.on_gui_click(event)
end)

-- Get the tick when the player join a session
script.on_event(defines.events.on_player_joined_game, function(event)
    gclock.log("Player joined")
end)

script.on_event(defines.events.on_player_left_game, function(event)
    gclock.log("Player left")
end)

-- Register the custom key press
script.on_event("toggle-chrono-key", function(event)
    local player = game.players[event.player_index]
    gclock.log("Toggle chrono on tick: " .. tostring(event.tick))
    gclock.toggle_chrono_button(player)
end)